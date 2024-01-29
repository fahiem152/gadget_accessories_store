// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/chat_datasource.dart';
import 'package:projecttas_223200007/data/models/channel.dart';
import 'package:projecttas_223200007/data/models/message.dart';

import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/chat_buuble_widget.dart';

class RoomChatPage extends StatefulWidget {
  final UserModel partnerUser;
  const RoomChatPage({
    Key? key,
    required this.partnerUser,
  }) : super(key: key);

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blue,
        title: Text(widget.partnerUser.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                  stream: FirebaseDatasource.instance.messageStream(
                      channelid(widget.partnerUser.uid, currentUser!.uid)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final List<Message> messages = snapshot.data ?? [];
                    //if message is null
                    if (messages.isEmpty) {
                      return const Center(
                        child: Text('No message found'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        reverse: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return ChatBubbleWidget(
                            direction: message.senderId == currentUser!.uid
                                ? Direction.right
                                : Direction.left,
                            message: message.textMessage,
                            type: BubbleType.alone,
                          );
                        },
                      ),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    final channel = Channel(
      id: channelid(currentUser!.uid, widget.partnerUser.uid),
      memberIds: [currentUser!.uid, widget.partnerUser.uid],
      members: [UserModel.fromFirebaseUser(currentUser!), widget.partnerUser],
      lastMessage: _messageController.text.trim(),
      sendBy: currentUser!.uid,
      lastTime: Timestamp.now(),
      unRead: {
        currentUser!.uid: false,
        widget.partnerUser.uid: true,
      },
    );

    await FirebaseDatasource.instance
        .updateChannel(channel.id, channel.toMap());

    var docRef = FirebaseFirestore.instance.collection('messages').doc();
    var message = Message(
      id: docRef.id,
      textMessage: _messageController.text.trim(),
      senderId: currentUser!.uid,
      sendAt: Timestamp.now(),
      channelId: channel.id,
    );
    FirebaseDatasource.instance.addMessage(message);

    var channelUpdateData = {
      'lastMessage': message.textMessage,
      'sendBy': currentUser!.uid,
      'lastTime': message.sendAt,
      'unRead': {
        currentUser!.uid: false,
        widget.partnerUser.uid: true,
      },
    };
    FirebaseDatasource.instance.updateChannel(channel.id, channelUpdateData);

    _messageController.clear();
  }
}

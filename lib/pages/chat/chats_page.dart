// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:projecttas_223200007/data/datasources/firebase_datasource/chat_datasource.dart';
// import 'package:projecttas_223200007/data/models/channel.dart';
// import 'package:projecttas_223200007/pages/chat/room_chat_page.dart';

// class ChatsPage extends StatelessWidget {
//   final bool isAdmin;
//   ChatsPage({
//     Key? key,
//     required this.isAdmin,
//   }) : super(key: key);
//   final currentUser = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 24.0,
//         ),
//         Expanded(
//           child: StreamBuilder<List<Channel>>(
//               stream:
//                   FirebaseDatasource.instance.channelStream(currentUser!.uid),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 final List<Channel> channels = (snapshot.data ?? [])
//                     .where((element) => element.id != currentUser!.uid)
//                     .toList();
//                 //if user is null
//                 if (channels.isEmpty) {
//                   return const Center(
//                     child: Text('No channel found'),
//                   );
//                 }
//                 return ListView.separated(
//                     itemCount: channels.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.green,
//                           radius: 25,
//                           child: Text(channels[index].members[0].name[0],
//                               style: const TextStyle(color: Colors.white)),
//                         ),
//                         title: Text(channels[index].members[0].name),
//                         subtitle: Text(channels[index].lastMessage),
//                         onTap: () {
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             return RoomChatPage(
//                               partnerUser: channels[index].members[0],
//                             );
//                           }));
//                         },
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return const Divider();
//                     });
//               }),
//         ),
//       ],
//     );
//   }
// }

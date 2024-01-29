// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';

import 'package:projecttas_223200007/data/models/user_model.dart';
import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserModel user;
  const UpdateProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  File? file;
  String? imageUrl;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    emailController.text = widget.user.email;
    uidController.text = widget.user.uid;
    nameController.text = widget.user.name;
    imageUrl = widget.user.photoUrl;
  }

  @override
  void dispose() {
    emailController.dispose();
    uidController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        file = File(xFile.path);
        setState(() {});
      }
    });
  }

  doUpdateUser(UserModel model) async {
    final result = await FirebaseDatasource().editUser(model);
    if (result) {
      context.showSnackBarSuccess("Success Update Profile");
      Navigator.pop(context);
    } else {
      context.showSnackBarError("Failed Update Profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blue,
        title: Text(
          "Update Profile Page",
          style: TextStyleConstant.textWhite,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 52,
          child: isLoading
              ? context.showLoading()
              : ButtonWidget(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});

                    if (file != null) {
                      final uploadImage = await FirebaseDatasource()
                          .uploadFileUser(file!, widget.user.uid);
                      final model = UserModel(
                        uid: widget.user.uid,
                        email: widget.user.email,
                        name: nameController.text,
                        photoUrl: uploadImage,
                      );
                      doUpdateUser(model);
                    } else {
                      final model = UserModel(
                        uid: widget.user.uid,
                        email: widget.user.email,
                        name: nameController.text,
                        photoUrl: widget.user.photoUrl,
                      );
                      doUpdateUser(model);
                    }
                    isLoading = false;
                    setState(() {});
                  },
                  color: ColorConstant.blue,
                  child: Center(
                    child: Text(
                      "Update Profile",
                      style: TextStyleConstant.textWhite.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              "UID",
              style: TextStyleConstant.textBlack.copyWith(
                fontWeight: bold,
              ),
            ),
            TextFormFieldBorderWidget(
              controller: uidController,
              pleaceholder: "Uid",
              isReadOnly: true,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              "E-mail",
              style: TextStyleConstant.textBlack.copyWith(
                fontWeight: bold,
              ),
            ),
            TextFormFieldBorderWidget(
              controller: emailController,
              pleaceholder: "E-Mail",
              isReadOnly: true,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              "Name",
              style: TextStyleConstant.textBlack.copyWith(
                fontWeight: bold,
              ),
            ),
            TextFormFieldBorderWidget(
                controller: nameController, pleaceholder: "Name"),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              "Image",
              style: TextStyleConstant.textBlack.copyWith(
                fontWeight: bold,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 12.0, bottom: 8),
                height: 180 - 24,
                padding: const EdgeInsets.all(4.0),
                width: (MediaQuery.of(context).size.width / 2) - 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstant.blue,
                  ),
                ),
                child: file == null
                    ? (imageUrl == null
                        ? Image.asset('assets/images/human.jpg')
                        : Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                          ))
                    : Image.file(
                        file!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonWidget(
                onPressed: () => getImage(),
                color: ColorConstant.blue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    "Select Image",
                    style: TextStyleConstant.textWhite,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}

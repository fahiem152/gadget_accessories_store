// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projecttas_223200007/data/datasources/firebase_datasource/firebase_datasource.dart';
import 'package:projecttas_223200007/data/models/product_model.dart';

import 'package:projecttas_223200007/shared/colors/colors.dart';
import 'package:projecttas_223200007/shared/indicator/indicator.dart';
import 'package:projecttas_223200007/shared/textstyle/textstyle.dart';
import 'package:projecttas_223200007/shared/validator/validator.dart';
import 'package:projecttas_223200007/shared/widgets/button_widget.dart';
import 'package:projecttas_223200007/shared/widgets/image_local_widget.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<File> imageFiles = [];
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFiles.add(File(xFile.path));
        setState(() {});
      }
    });
  }

  doAddProduct(ProductModel model) async {
    isLoading = true;
    setState(() {});
    final result = await FirebaseDatasource().addProduct(model, imageFiles);
    if (result) {
      context.showSnackBarSuccess("Success Add Product");
      Navigator.pop(context);
    } else {
      context.showSnackBarError("Failed Add Product");
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blue,
        title: Text(
          "Add Product Page",
          style: TextStyleConstant.textWhite,
        ),
        actions: const [],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: isLoading
            ? SizedBox(height: 50, child: context.showLoading())
            : SizedBox(
                height: 50,
                child: ButtonWidget(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        imageFiles.isNotEmpty) {
                      final model = ProductModel(
                          id: '',
                          name: nameController.text,
                          description: descriptionController.text,
                          price: priceController.text,
                          images: []);
                      doAddProduct(model);
                    } else {
                      const snackBar = SnackBar(
                        content: Text(
                            'Please complete all fields and Choose Image.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  color: ColorConstant.blue,
                  child: Center(
                    child: Text(
                      'Add Product',
                      style: TextStyleConstant.textWhite.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
              ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldBorderWidget(
                    controller: nameController,
                    pleaceholder: 'Name Product',
                    validator: (value) => Validator.nama(value)),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormFieldBorderWidget(
                    controller: descriptionController,
                    pleaceholder: 'Description Product',
                    validator: (value) => Validator.description(value)),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormFieldBorderWidget(
                    controller: priceController,
                    pleaceholder: 'Price Product',
                    validator: (value) => Validator.price(value)),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstant.grey,
                    ),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Image Products",
                        style: TextStyleConstant.textBlack.copyWith(
                          fontSize: 16.0,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8.0,
                            ),
                            ...imageFiles
                                .map((e) => ImagesLocalWidget(
                                      image: e,
                                      onTap: () {
                                        imageFiles.remove(e);
                                        setState(() {});
                                      },
                                    ))
                                .toList(),
                            imageFiles.length < 3
                                ? GestureDetector(
                                    onTap: () => getImage(),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorConstant.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          4,
                                        ),
                                      ),
                                      height: 120,
                                      width: 100,
                                      child: const Column(
                                        children: [
                                          Icon(
                                            Icons.add_photo_alternate,
                                            size: 80,
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            "Add Image",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

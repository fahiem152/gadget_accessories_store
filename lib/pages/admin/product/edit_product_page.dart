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
import 'package:projecttas_223200007/shared/widgets/image_network_card.dart';
import 'package:projecttas_223200007/shared/widgets/textformfield_border_widget.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;
  const EditProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<File> imageFiles = [];
  List<String> imageNetwork = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    descriptionController.text = widget.product.description;
    priceController.text = widget.product.price;
    imageNetwork = widget.product.images;
  }

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

  doEditProduct(ProductModel model) async {
    isLoading = true;
    setState(() {});
    final result = await FirebaseDatasource().editProduct(model, imageFiles);
    if (result) {
      context.showSnackBarSuccess("Success Add Product");
      Navigator.pop(context);
    } else {
      context.showSnackBarError("Failed Add Product");
    }
    isLoading = false;
    setState(() {});
  }

  buildImage() {
    return Row(
      children: [
        const SizedBox(
          width: 8.0,
        ),
        imageNetwork.isNotEmpty
            ? Row(
                children: [
                  ...imageNetwork.map(
                    (e) => ImagesNetworkWidget(
                      image: e,
                      onTap: () {
                        imageNetwork = List.from(
                          imageNetwork,
                        );
                        imageNetwork.remove(e);

                        setState(() {});
                      },
                    ),
                  ),
                  ...imageFiles
                      .map(
                        (e) => ImagesLocalWidget(
                          image: e,
                          onTap: () {
                            imageFiles.remove(e);
                            setState(() {});
                          },
                        ),
                      )
                      .toList()
                ],
              )
            : const SizedBox(),
        imageNetwork.length + imageFiles.length < 3
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blue,
        title: Text(
          "Edit Product Page",
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
                          id: widget.product.id,
                          name: nameController.text,
                          description: descriptionController.text,
                          price: priceController.text,
                          images: imageNetwork);
                      doEditProduct(model);
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
                      'Edit Product',
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
                        child: buildImage(),
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

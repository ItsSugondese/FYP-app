import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/services/temporary-attachments/temporary_attachments_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

@RoutePage()
class AddStaffscreen extends StatefulWidget {
  // Use the constructor to receive the data
  final FoodMenu? foodMenu;
  AddStaffscreen({Key? key, this.foodMenu}) : super(key: key);

  @override
  State<AddStaffscreen> createState() => _AddStaffscreenState();
}

class _AddStaffscreenState extends State<AddStaffscreen> {
  // FoodManagementService foodManagementService = FoodManagementService();
  TemporaryAttachmentsService temporaryAttachmentsService =
      TemporaryAttachmentsService();

  final TextEditingController _foodIdController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodCostController = TextEditingController();
  final TextEditingController _foodDescriptionController =
      TextEditingController();
  final List<TextEditingController> _foodMenuItemsController = [];
  final ScrollController scrollController = ScrollController();

  File? _imageFile;
  String? fileName;
  String? description;
  double? foodPrice;
  int? fileId;
  bool isToggled = false;

  bool isFoodSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.foodMenu != null) {
      isFoodSelected = true;
      _foodIdController.text = widget.foodMenu!.id.toString();
      _foodCostController.text = widget.foodMenu!.cost.toString();
      _foodNameController.text = widget.foodMenu!.name.toString();
      _foodDescriptionController.text = widget.foodMenu!.description.toString();
      fileId = widget.foodMenu!.photoId;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      fileId =
          await temporaryAttachmentsService.uploadFile(_imageFile!, context);
      setState(() {
        fileName = path.basename(_imageFile!.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Form(
        key: _formKey, // Add this key
        autovalidateMode: AutovalidateMode
            .onUserInteraction, // Add this line for auto-validation
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _foodNameController,
                  decoration: InputDecoration(labelText: 'Food Name?'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _foodCostController,
                  decoration: InputDecoration(labelText: 'Food Price?'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true), // Specify numeric keyboard
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                    // This formatter allows only numeric values with up to 2 decimal places
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _foodDescriptionController,
                  decoration:
                      InputDecoration(labelText: 'Description of the food?'),
                ),
                SizedBox(height: 16),

                Switch(
                  value: isToggled,
                  onChanged: (value) {
                    setState(() {
                      isToggled = value;
                      if (isToggled) {
                        _foodMenuItemsController.add(TextEditingController());
                      } else {
                        _foodMenuItemsController.clear();
                      }
                    });
                  },
                ),
                Column(
                  children: _foodMenuItemsController.map((controller) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(labelText: 'Enter text'),
                      ),
                    );
                  }).toList(),
                ),

                isToggled
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _foodMenuItemsController
                                .add(TextEditingController());
                          });
                        },
                        child: Text('Add Item'),
                      )
                    : Container(),

                SizedBox(
                  height: 16,
                ),
                // Button to pick an image
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _pickImage();
                      },
                      child: Text('Pick Image'),
                    ),
                    fileName == null ? Container() : Text("${fileName}")
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: !isAllFilled()
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            // AddStaffPayload addStaffPayload = AddStaffPayload(fullName: fullName, email: email, contactNumber: contactNumber)

                            // foodManagementService.saveFoodDetails(
                            //     context, response.toJson());
                          }
                        },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isAllFilled() {
    if (((!isFoodSelected && fileId != null) || isFoodSelected) &&
        _foodCostController.text.isNotEmpty &&
        _foodNameController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}

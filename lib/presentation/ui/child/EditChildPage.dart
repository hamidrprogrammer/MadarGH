import 'dart:convert';
import 'dart:typed_data';

import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ios_app/config/appData/route/AppRoute.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/child/AddChildUi.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/viewModel/child/AddChildViewModel.dart';

import 'package:my_ios_app/presentation/ui/main/DropDownFormField.dart';
class EditChildPage extends StatefulWidget {
  const EditChildPage({Key? key}) : super(key: key);

  @override
  EditChildUiState createState() => EditChildUiState();
}

class EditChildUiState   extends State<EditChildPage>  {
  String? _selectedGender;


  @override
  Widget build(BuildContext context) {
    final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
    final ChildsItem? packageId = Get.arguments as ChildsItem;
    DateTime? birthDate = packageId?.birtDate;
    int birthDay = birthDate!.day; // 25
    int birthMonth = birthDate.month; // 10
    int birthYear = birthDate.year; // 2018
    Uint8List bytes = base64Decode(packageId?.childPicture?.content ?? '');

    return CubitProvider(
        create: (context) => AddChildViewModel(AppState.idle),
        builder: (bloc, state) {
          bloc.submitEditInit(packageId!);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Stack(
                children: [
                  Positioned.fill(
                    top: kIsWeb ? 0 : 15,
                    child: Image.asset(
                      'assets/Rectangle21.png', // Path to your SVG file
                      fit: BoxFit.fitWidth,
                      // To cover the entire AppBar
                    ),
                  ),
                  AppBar(
                    title: Text(
                      'edit_child'.tr,
                      style: TextStyle(
                        fontFamily: 'IRANSansXFaNum',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    iconTheme: IconThemeData(color: Colors.white),
                    backgroundColor:
                        Colors.transparent, // Make AppBar transparent
                    elevation: 0, // Remove shadow
                  ),
                ],
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextInputField(
                        title: 'child_first_name'.tr,
                        hintText: '${packageId?.childFirstName}',
                        onChangeValue: bloc.onChildFirstNameChange,
                      ),
                      SizedBox(height: 16),
                      _buildTextInputField(
                        title: 'child_last_name'.tr,
                        hintText: '${packageId?.childLastName}',
                        onChangeValue: bloc.onChildLastNameChange,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildGenderRadioButton("پسر",
                              _selectedGender == "0",
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _selectedGender = "0"; // Update the selected value
                                });
                                late String defaultImageBase64;
                                // Store the default image as Base64
                                bloc.onChildGenderChange(0);
                                rootBundle.load('assets/boy.png').then((byteData) {
                                  Uint8List imageBytes = byteData.buffer.asUint8List();
                                  defaultImageBase64 = base64Encode(imageBytes);
                                  ImageFileModel image=  ImageFileModel(
                                    name:DateTime.now().microsecondsSinceEpoch.toString(),
                                    mimType: 'image/png', // Adjust based on your default image type
                                    content: defaultImageBase64,
                                    Id: '0',
                                  );
                                  bloc.selectedImage = image;
                                  bloc.selectedImage?.Id = '00000000-0000-0000-0000-000000000000';
                                });
                              }),
                          SizedBox(width: 50),
                          buildGenderRadioButton("دختر",
                              _selectedGender == "1",
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _selectedGender = "1"; // Update the selected value
                                });
                                late String defaultImageBase64; // Store the default image as Base64
                                bloc.onChildGenderChange(1);

                                rootBundle.load('assets/girl.png').then((byteData) {
                                  Uint8List imageBytes = byteData.buffer.asUint8List();
                                  defaultImageBase64 = base64Encode(imageBytes);
                                  ImageFileModel image=  ImageFileModel(
                                    name: DateTime.now().microsecondsSinceEpoch.toString(),
                                    mimType: 'image/png', // Adjust based on your default image type
                                    content: defaultImageBase64,
                                    Id: '0',

                                  );
                                  bloc.selectedImage = image;
                                  bloc.selectedImage?.Id = '00000000-0000-0000-0000-000000000000';
                                });


                              }),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Text(
                      //   'birth_date'.tr,
                      //   style: TextStyle(
                      //     fontFamily: 'IRANSansXFaNum',
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 14,
                      //     color: Color(0xff353842),
                      //   ),
                      // ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'child_picture_optional'.tr,
                            style: TextStyle(
                              fontFamily: 'IRANSansXFaNum',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff353842),
                            ),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              bloc.addImage();
                              // Handle image upload
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (bloc.selectedImage != null&& _selectedGender == null)
                                  ClipOval(
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.memory(
                                        bloc.selectedImage!.getFileFormBase642(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                // Show a generic default image if no selected image and no gender is selected
                                if (bloc.selectedImage == null && _selectedGender == null && packageId.gender == null)
                                  Image.asset(
                                    'assets/edit.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                if (bloc.selectedImage == null && _selectedGender == null&&  packageId.gender != null )
                                  Image.asset(
                                    packageId.gender  == 1 ? 'assets/girl.png' : 'assets/boy.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                // Show gender-specific default images if no selected image
                                if ( _selectedGender != null )
                                  Image.asset(
                                    _selectedGender == '1' ? 'assets/girl.png' : 'assets/boy.png',
                                    width: 100,
                                    height: 100,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      _buildSubmitButton(() {
                        bloc.submitEdit(packageId!);
                      }, bloc.uiState.isLoading),
                      SizedBox(height: 16),
                      // _buildDeleteChildButton(),
                    ],
                  ),
                )),
          );
        });
  }
  Widget buildGenderRadioButton(String text ,  bool value, {required Null Function(bool? newValue) onChanged}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff353842),
          ),
        ),
        Radio(
          value: value,
          groupValue: true,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildTextInputField(
      {required String title,
      required String hintText,
      required Function(String) onChangeValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff353842),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Color(0xfff6f6f8),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            onChanged: onChangeValue,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: 'IRANSansXFaNum',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xff505463),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'gender'.tr,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xff353842),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(value: 1, groupValue: 2, onChanged: (value) {}),
                Text(
                  'boy'.tr,
                  style: TextStyle(
                    fontFamily: 'IRANSansXFaNum',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff505463),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(value: 2, groupValue: 1, onChanged: (value) {}),
                Text(
                  'girl'.tr,
                  style: TextStyle(
                    fontFamily: 'IRANSansXFaNum',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff505463),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton(Function onPress, bool isLoading) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ElevatedButton(
          onPressed: () {
            onPress();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(16.0),
          ),
          child: Center(
            child: isLoading
                ? MyLoader()
                : Text(
                    'save_changes'.tr,
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteChildButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          // Handle delete action
        },
        child: Text(
          'delete_child'.tr,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff505463),
          ),
        ),
      ),
    );
  }
}

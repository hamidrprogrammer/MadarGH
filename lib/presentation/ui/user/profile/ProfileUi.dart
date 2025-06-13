import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:core/dioNetwork/interceptor/culture_interceptor.dart';
import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';
import 'package:my_ios_app/presentation/ui/login/LoginUi.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/child/GetChildsViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/ProfileViewModel.dart';
import 'package:my_ios_app/useCase/app/set_culture_use_case.dart';
import 'package:my_ios_app/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../../../../data/body/user/information/InformationBodey.dart';
import 'ChildsProfileUi.dart';
import 'package:flutter/services.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({Key? key}) : super(key: key);
  @override
  _ProfileUiState createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  bool _isLoading = false;
  bool _isEdit = false;
  Map<String, dynamic>? userInfo; // Loading state
  String firstName = ' ';
  String lastName = ' ';
  @override
  void initState() {
    super.initState();
    // Automatically call getUserInfo when the page is navigated to
  }

  // Updated `sendUsernameToServer` function
  Future<void> sendUsernameToServer(
      BuildContext context, String name, String family) async {
    final url = Uri.parse(
        "https://back.mamakschool.ir/api/User/UpdateUserInApplication");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final authToken = prefs.getString("token");
    // final motherEducation = prefs.getString("motherEducation");
    // final motherJobTitle = prefs.getString("motherJobTitle");
    // final motherJobStatus = prefs.getString("motherJobStatus");
    // final fatherEducation = prefs.getString("fatherEducation");
    // final fatherJobStatus = prefs.getString("fatherJobStatus");
    // final fatherJobTitle = prefs.getString("fatherJobTitle");
    // final maritalStatus = prefs.getString("maritalStatus");
    // final mentalPeace = prefs.getString("mentalPeace");
    // final support = prefs.getString("support");
    // final health = prefs.getString("health");

    // if (authToken == null) {
    //   return;
    // }

    // try {
    //   String? nullIfEmpty(String? value) =>
    //       value?.isEmpty ?? true ? null : value;
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': "$authToken",
    //       "refreshtoken": "$authToken"
    //     },
    //     body: jsonEncode({
    //       "id": 0,
    //       "firstName": nullIfEmpty(name),
    //       "lastName": nullIfEmpty(family),
    //       "motherEducation": nullIfEmpty(motherEducation),
    //       "motherJobTitle": nullIfEmpty(motherJobTitle),
    //       "motherJobStatus": nullIfEmpty(motherJobStatus),
    //       "fatherEducation": nullIfEmpty(fatherEducation),
    //       "fatherJobTitle": nullIfEmpty(fatherJobTitle),
    //       "fatherJobStatus": nullIfEmpty(fatherJobStatus),
    //       "maritalStatus": nullIfEmpty(maritalStatus),
    //       "mentalPeace": nullIfEmpty(mentalPeace),
    //       "support": nullIfEmpty(support),
    //       "health": nullIfEmpty(health),
    //     }),
    //   );

    //   if (response.statusCode == 200) {
    //     print("Username updated successfully");
    //     Navigator.pop(context); // Close the dialog
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("نام شما با موفقیت تغییر کرد")),
    //     );
    //     prefs.setString("fullName", "$name $family");
    //     setState(() {});
    //   } else {
    //     print("Failed to update username: ${response.statusCode}");
    //     const SnackBar(content: Text("خطا در ویرایش نام مادر"));
    //   }
    // } catch (e) {
    //   print("Error updating username: $e");
    // }
  }

  Widget _buildListItem(
      String assetPath, String title, final Function() onSelectChild,
      {bool isLogout = false,
      bool disable = false,
      Color logoutColor = Colors.black}) {
    return Opacity(
      opacity: disable ? 0.3 : 1, // Set the desired opacity here
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: -2.0),
        leading: SvgPicture.asset(
          assetPath,
          width: 20.0, // Adjust size as needed
          height: 20.0, // Adjust size as needed
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontSize: 12.0,
            color: isLogout ? logoutColor : Color(0xFF353842),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 8.0, color: Color(0xFF353842)),
        onTap: () {
          if (!disable) {
            onSelectChild();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
    logoutClick() {
      Get.dialog(const LogoutDialog());
    }

    changePasswordClick() {
      _navigationServiceImpl.navigateTo(AppRoute.changePassword);
    }

    contactUsApp() {
      _navigationServiceImpl.navigateTo(AppRoute.contactUsApp);
    }

    mChildrenScreenClick() {
      _navigationServiceImpl.navigateTo(AppRoute.myChildren);
    }

    transactionsScreen() {
      _navigationServiceImpl.navigateTo(AppRoute.transactionsScreen);
    }

    addChildClick() {
      _navigationServiceImpl.navigateTo(AppRoute.addChild);
    }

    CalendarScreen() {
      // SharedPreferences.getInstance().then((prefs) {
      //   final _isLoggedIn = prefs.getString('isUserMeeting') ?? 'false';
      //   print("invokeSupport=======================s==========" +
      //       _isLoggedIn.toString());
      //   bool result = _isLoggedIn == 'true';
      //   if (result) {
      //     // Data is not null and not empty
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text("شما قبلا در مشاوره شرکت کرده اید")),
      //     );
      //     print("Data: $_isLoggedIn");
      //   } else {
      //     // Data is null or empty
      //     _navigationServiceImpl.navigateTo(AppRoute.calendarScreen);
      //   }
      // });
    }

    sourceClick() {
      _navigationServiceImpl.navigateTo(AppRoute.sourceClick);
    }

    informationClick() {
      _navigationServiceImpl.navigateTo(AppRoute.information);
    }

    subscriptionClick() {
      _navigationServiceImpl.navigateTo(AppRoute.subscription);
    }

    void makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );

      // if (await canLaunch(launchUri.toString())) {
      //   await launch(launchUri.toString());
      // } else {
      //   throw 'Could not launch $launchUri';
      // }
    }

    void resetApp() {
      // You can either navigate to your main page or reinitialize state here
      // Example of navigating to home page (ensure the route exists)
      Get.offAllNamed('/home'); // or replace '/home' with your main route

      // Alternatively, if you want to clear the navigation stack
      // Get.offAll(() => HomePage()); // Replace with your main widget
    }

    final MyImagePicker _myImagePicker = GetIt.I.get();

    var avatarId = '00000000-0000-0000-0000-000000000000';
    langsClick() async {
      setState(() {
        _isLoading = true;
      });
      Get.updateLocale(Locale('en', 'US'));
      GetIt.I
          .get<LocalSessionImpl>()
          .insertData({UserSessionConst.lang: 'English'});
      SetCultureUseCase().invoke(MyFlow(flow: (state) {}), data: 'en-US');
      GetIt.I.get<CultureInterceptor>().setCulture('en-US');
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
    }

    langsClickFa() async {
      setState(() {
        _isLoading = true;
      });
      GetIt.I
          .get<LocalSessionImpl>()
          .insertData({UserSessionConst.lang: 'Persian'});
      SetCultureUseCase().invoke(MyFlow(flow: (state) {}), data: 'fa-IR');
      GetIt.I.get<CultureInterceptor>().setCulture('fa-IR');
      Get.updateLocale(Locale('fa', 'IR'));
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
    }

    return WillPopScope(
        onWillPop: () async {
          // Return false to prevent back navigation
          return true;
        },
        child: CubitProvider(
          create: (context) => ProfileViewModel(AppState.idle),
          builder: (bloc, state) {
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
                          'dashboard'.tr,
                          style: const TextStyle(
                            fontFamily: 'IRANSansXFaNum',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        iconTheme: const IconThemeData(color: Colors.white),
                        backgroundColor:
                            Colors.transparent, // Make AppBar transparent
                        elevation: 0, // Remove shadow
                      ),
                    ],
                  ),
                ),
                body: Container(
                  color: const Color(0xFFF8F8FC),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_isLoading)
                              Center(
                                child: LoadingAnimationWidget.hexagonDots(
                                  color: const Color.fromARGB(255, 246, 5, 121),
                                  size: 45,
                                ),
                              ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     InkWell(
                            //       onTap: langsClickFa,
                            //       child: SizedBox(
                            //         width: 50, // Set the desired width
                            //         height: 70, // Set the desired height
                            //         child: Column(
                            //           children: [
                            //             Image.asset(
                            //               'assets/iran.png',
                            //               width: 20,
                            //             ),
                            //             SizedBox(height: 10),
                            //             Text(
                            //               'فارسی',
                            //               style: TextStyle(
                            //                 fontSize: 10.0,
                            //                 color: Color(0xFF696F82),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(width: 8),
                            //     InkWell(
                            //         onTap: langsClick,
                            //         child: SizedBox(
                            //           width: 50, // Set the desired width
                            //           height: 70, // Set the desired height
                            //           child: Column(
                            //             children: [
                            //               SvgPicture.asset(
                            //                 'assets/england.svg',
                            //                 width: 20,
                            //               ),
                            //               SizedBox(height: 10),
                            //               Text(
                            //                 'English',
                            //                 style: TextStyle(
                            //                   fontSize: 10.0,
                            //                   color: Color(0xFF696F82),
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         )),
                            //   ],
                            // ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                FutureBuilder(
                                  future: bloc.getUserImage,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != null &&
                                        snapshot.data is String &&
                                        snapshot.data != '') {
                                      return CircleAvatar(
                                        radius: 27.0,
                                        backgroundColor: Colors
                                            .transparent, // Set transparent background
                                        child: ClipOval(
                                          child: Image.memory(
                                            base64Decode(
                                                snapshot.data.toString()),
                                            width:
                                                54.0, // Adjust size as needed
                                            height:
                                                54.0, // Adjust size as needed
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }
                                    return ClipOval(
                                      child: Image.asset(
                                        'assets/maman.png',
                                        width: 54.0, // Adjust size as needed
                                        height: 54.0, // Adjust size as needed
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'username'.tr,
                                      style: const TextStyle(
                                        fontFamily: 'IRANSansXFaNum',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Color(0xFF696F82),
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: bloc.getUserFullName,
                                      builder: (context, snapshot) {
                                        return Container(
                                            width: 110,
                                            child: Text(
                                              snapshot.hasData
                                                  ? snapshot.data?.toString() ??
                                                      ''
                                                  : 'user_name'.tr,
                                              style: const TextStyle(
                                                fontFamily: 'IRANSansXFaNum',
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 14.0,
                                                color: Color(0xFF353842),
                                                // Add ellipsis if the text overflows
                                              ),
                                              maxLines:
                                                  2, // Limit the text to 2 lines
                                              overflow: TextOverflow.ellipsis,
                                            ));
                                      },
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      "ویرایش نام مادر",
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    FutureBuilder(
                                                        future:
                                                            bloc.getMotherName,
                                                        builder: (context,
                                                            snapshot) {
                                                          print(
                                                              "getMotherName");
                                                          print(snapshot.data
                                                              .toString());
                                                          Map<String, dynamic>
                                                              data =
                                                              jsonDecode(snapshot
                                                                  .data
                                                                  .toString());
                                                          String first =
                                                              data['firstName'];
                                                          String last =
                                                              data['lastName'];
                                                          // setState(() {
                                                          //   lastName = last;
                                                          //   firstName = first;
                                                          // });
                                                          return Column(
                                                            children: [
                                                              _buildTextInputField(
                                                                title:
                                                                    'name'.tr,
                                                                hintText: first,
                                                                value: first,
                                                                onChangeValue:
                                                                    (value) {
                                                                  print(value);

                                                                  setState(() {
                                                                    firstName =
                                                                        value;
                                                                  });
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              _buildTextInputField(
                                                                title:
                                                                    'family'.tr,
                                                                hintText: last,
                                                                value: last,
                                                                onChangeValue:
                                                                    (value) {
                                                                  print(value);
                                                                  setState(() {
                                                                    lastName =
                                                                        value;
                                                                  });
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  minimumSize:
                                                                      Size(150,
                                                                          50),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          4,
                                                                      horizontal:
                                                                          12),
                                                                ),
                                                                onPressed: () {
                                                                  if (first.length <=
                                                                          1 ||
                                                                      last.length <=
                                                                          1) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                          duration: const Duration(
                                                                              seconds:
                                                                                  3), // Use the provided or default duration

                                                                          content:
                                                                              Text("نام و یا نام خانوادگی نباید خالی باشد")),
                                                                    );
                                                                  } else {
                                                                    if (firstName
                                                                            .length <=
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                        firstName =
                                                                            first;
                                                                      });
                                                                    }
                                                                    if (lastName
                                                                            .length <=
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                        lastName =
                                                                            last;
                                                                      });
                                                                    }
                                                                    bloc.getUserInfoUpdate(
                                                                        firstName,
                                                                        lastName);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'change_username'
                                                                      .tr,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'change_username'.tr,
                                        style: const TextStyle(
                                          fontFamily: 'IRANSansXFaNum',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 8.0,
                                          color: Color(0xFF9E3840),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),

                                // OutlinedButton(
                                //   onPressed: () async {
                                //     bloc.getImage();
                                //   },
                                //   style: OutlinedButton.styleFrom(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 8.0, vertical: 4.0),
                                //   ),
                                OutlinedButton(
                                  onPressed: () async {
                                    bloc.getImage();
                                  },
                                  child: Text(
                                    'change_profile_image'.tr,
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Color(0xFF9E3840),
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                  ),
                                ),
                                // ),

                                // IconButton(
                                //   icon: SvgPicture.asset(
                                //     'assets/user-cirle.svg',
                                //     width: 30.0, // Adjust size as needed
                                //     height: 30.0, // Adjust size as needed
                                //   ),
                                //   iconSize: 30.0,
                                //   onPressed: () {},
                                // ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.layers,
                                    color: Colors.black, size: 24.0),
                                const SizedBox(width: 8.0),
                                Text(
                                  'user_subscription'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'IRANSansXFaNum',
                                    fontSize: 8.0,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                FutureBuilder(
                                    future: bloc.getUserDay,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data == 0
                                            ? 'no_active_package'.tr
                                            : '${'remaining_days'.tr}\n${snapshot.data} ' +
                                                "${'day'.tr}",
                                        style: const TextStyle(
                                          fontFamily: 'IRANSansXFaNum',
                                          fontSize: 11.0,
                                          color: Color(0xFFFDC00F),
                                        ),
                                        textAlign: TextAlign
                                            .center, // Center the text horizontally
                                      );
                                    }),
                                const SizedBox(width: 8.0),
                                ElevatedButton(
                                  onPressed: () {
                                    subscriptionClick();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 4.0),
                                  ),
                                  child: Text(
                                    'buy_subscription'.tr,
                                    style: const TextStyle(
                                      fontFamily: 'IRANSansXFaNum',
                                      fontSize: 8.0,
                                      color: Color(0xFF9E3840),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      _buildListItem(
                          'assets/huge-icon-user-outline-users-02.svg',
                          'my_children'.tr,
                          mChildrenScreenClick),
                      const Divider(thickness: 0.3),
                      _buildListItem(
                          'assets/huge-icon-user-outline-user-polygon.svg',
                          'support'.tr,
                          sourceClick),
                      const Divider(thickness: 0.3),
                      FutureBuilder(
                          future: bloc.getUserMetting,
                          builder: (context, snapshot) {
                            bool result = snapshot.data == 'true';
                            return _buildListItem(
                                'assets/huge-icon-time-and-date-outline-calendar-01.svg',
                                'schedule_meeting'.tr,
                                CalendarScreen,
                                disable: result);
                          }),
                      const Divider(thickness: 0.3),
                      _buildListItem(
                          'assets/huge-icon-shipping-and-delivery-outline-package-02.svg',
                          'recommended_subscription_packages'.tr,
                          subscriptionClick),
                      const Divider(thickness: 0.3),
                      _buildListItem(
                          'assets/huge-icon-ecommerce-outline-wallet.svg',
                          'my_payments'.tr,
                          transactionsScreen),
                      const Divider(thickness: 0.3),
                      _buildListItem(
                          'assets/huge-icon-smart-house-outline-smart-lock.svg',
                          'change_password'.tr,
                          changePasswordClick),
                      const SizedBox(height: 16.0),
                      const Divider(thickness: 0.3),
                      _buildListItem(
                          'assets/huge-icon-communication-outline-calling.svg',
                          'contact_us'.tr, () {
                        contactUsApp();
                      }),
                      const SizedBox(height: 16.0),
                      const Divider(thickness: 0.3),
                      _buildListItem(
                          'assets/huge-icon-interface-outline-logout-2.svg',
                          'logout'.tr,
                          logoutClick,
                          isLogout: true,
                          logoutColor: Color(0xFFFF1438)),
                    ],
                  ),
                ));
          },
        ));
  }
}

Widget _buildTextInputField(
    {required String title,
    required String hintText,
    required String value,
    required Function(String) onChangeValue}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'IRANSansXFaNum',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xff353842),
        ),
      ),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          color: Color(0xfff6f6f8),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: TextFormField(
          onChanged: onChangeValue,
          textAlign: TextAlign.right,
          initialValue: value,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
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

class FactorsTableUi extends StatelessWidget {
  FactorsTableUi({super.key});
  final List<String> columns = [
    'factor_number'.tr,
    'date'.tr,
    'price'.tr,
    'discount_code'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: DataTable(
        columns: List.generate(
          columns.length,
          (index) => DataColumn(
            label: index == 3
                ? const SizedBox()
                : Text(
                    columns[index],
                  ),
          ),
        ),
        rows: List.generate(
          1,
          (index) => DataRow(
            cells: List.generate(
              columns.length,
              (index) => DataCell(
                index == 3 ? const FactorDetailButton() : const Text('-'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FactorDetailButton extends StatelessWidget {
  const FactorDetailButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton.icon(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
        ),
        onPressed: () {},
        icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
        label: Text(
          'see_factor'.tr,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
    final session = GetIt.I.get<LocalSessionImpl>();

    return WillPopScope(
        onWillPop: () async => true,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LOGOUT'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  20.dpv,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            // final SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // await prefs.clear();
                            session.clearSession();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginUi()),
                              (Route<dynamic> route) =>
                                  false, // Remove all routes from the stack
                            );
                          },
                          child: Text(
                            'yes'.tr,
                            style: TextStyle(
                              fontFamily: 'IRANSansXFaNum',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      8.dph,
                      Container(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 133, 1, 71),
                                    width: 1),
                              ),
                            ),
                            onPressed: () {
                              GetIt.I.get<NavigationServiceImpl>().pop();
                            },
                            child: Text(
                              'no'.tr,
                              style: TextStyle(
                                fontFamily: 'IRANSansXFaNum',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ))
                    ],
                  ),
                  8.dpv,
                ],
              ),
            ),
          ),
        ));
  }
}

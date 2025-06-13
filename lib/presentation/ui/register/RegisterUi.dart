import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/recaptcha/recaptcha.dart';

import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/SignUpViewModel.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../../config/appData/locales/AppDefaultLocale.dart';

enum EducationStatus {
  UnderDiploma(1),
  Diploma(2),
  Bachelor(3),
  Master(4),
  PHD(5),
  UpperPHD(6);

  final int value;
  const EducationStatus(this.value);
}

enum JobStatus {
  FullTime(1),
  PartTime(2),
  HouseKeeper(3);

  final int value;
  const JobStatus(this.value);
}

enum MaritalStatus {
  Couple(1),
  GoodWithEachOther(2),
  Divorced(3);

  final int value;
  const MaritalStatus(this.value);
}

enum MentalPeaceStatus {
  VeryGood(1),
  Good(2),
  Normal(3),
  Bad(4),
  VeryBad(5);

  final int value;
  const MentalPeaceStatus(this.value);
}

enum SupportStatus {
  VeryHigh(1),
  High(2),
  Normal(3),
  Low(4),
  VeryLow(5);

  final int value;
  const SupportStatus(this.value);
}

enum HealthStatus {
  VeryBad(1),
  Bad(2),
  Average(3),
  Good(4),
  VeryGood(5);

  final int value;
  const HealthStatus(this.value);
}

// Extension methods to get display names for each enum value
extension EducationStatusExtension on EducationStatus {
  String get displayName {
    switch (this) {
      case EducationStatus.UnderDiploma:
        return 'زیر دیپلم';
      case EducationStatus.Diploma:
        return 'دیپلم';
      case EducationStatus.Bachelor:
        return 'لیسانس';
      case EducationStatus.Master:
        return 'فوق لیسانس';
      case EducationStatus.PHD:
        return 'دکتری';
      case EducationStatus.UpperPHD:
        return 'فوق دکتری';
      default:
        return '';
    }
  }
}

extension JobStatusExtension on JobStatus {
  String get displayName {
    switch (this) {
      case JobStatus.FullTime:
        return 'تمام وقت';
      case JobStatus.PartTime:
        return 'پاره وقت';
      case JobStatus.HouseKeeper:
        return 'خانه دار';
      default:
        return '';
    }
  }
}

extension MaritalStatusExtension on MaritalStatus {
  String get displayName {
    switch (this) {
      case MaritalStatus.Couple:
        return 'با همسرم زندگی میکنم';
      case MaritalStatus.GoodWithEachOther:
        return 'جدا شدیم اما هنوز ارتباط سالمی داریم';
      case MaritalStatus.Divorced:
        return 'جدا شدم و به تنهایی کودک را بزرگ میکنم';
      default:
        return '';
    }
  }
}

extension MentalPeaceStatusExtension on MentalPeaceStatus {
  String get displayName {
    switch (this) {
      case MentalPeaceStatus.VeryGood:
        return 'خیلی خوب';
      case MentalPeaceStatus.Good:
        return 'خوب';
      case MentalPeaceStatus.Normal:
        return 'معمولی';
      case MentalPeaceStatus.Bad:
        return 'بد';
      case MentalPeaceStatus.VeryBad:
        return 'خیلی بد';
      default:
        return '';
    }
  }
}

extension SupportStatusExtension on SupportStatus {
  String get displayName {
    switch (this) {
      case SupportStatus.VeryHigh:
        return 'خیلی زیاد';
      case SupportStatus.High:
        return 'زیاد';
      case SupportStatus.Normal:
        return 'معمولی';
      case SupportStatus.Low:
        return 'کم';
      case SupportStatus.VeryLow:
        return 'خیلی کم';
      default:
        return '';
    }
  }
}

extension HealthStatusExtension on HealthStatus {
  String get displayName {
    switch (this) {
      case HealthStatus.VeryBad:
        return 'خیلی بد';
      case HealthStatus.Bad:
        return 'بد';
      case HealthStatus.Average:
        return 'معمولی';
      case HealthStatus.Good:
        return 'خوب';
      case HealthStatus.VeryGood:
        return 'خیلی خوب';
      default:
        return '';
    }
  }
}

class RegisterUi extends StatelessWidget {
  const RegisterUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => SignUpViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Stack(
              children: [
                Positioned.fill(
                  top: kIsWeb ? 0 : 30,
                  child: Image.asset(
                    'assets/Rectangle21.png', // Path to your SVG file
                    fit: BoxFit.fitWidth,
                    // To cover the entire AppBar
                  ),
                ),
                AppBar(
                  title: Text(
                    "register".tr,
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
          body: Directionality(
            textDirection: AppDefaultLocale.getAppLocale.toString() == "en_US"
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "enter_username_or_mobile".tr,
                    style: const TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xFF353842),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width:
                        double.infinity, // Make the parent container full width
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Align items to the right
                      children: [
                        GestureDetector(
                          onTap: () {
                            bloc.onChangeSignUpBy(SignUpBy.mobile);
                          },
                          child: buildRadioButton(
                              "شماره موبایل", bloc.signUpBy?.isMobile == true),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            bloc.onChangeSignUpBy(SignUpBy.email);
                          },
                          child: buildRadioButton(
                              "ایمیل", bloc.signUpBy?.isEmail == true),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  bloc.signUpBy?.isEmail == true
                      ? buildTextInputField(
                          "email".tr, "email".tr, bloc.onEmailChange,
                          keyboardType: TextInputType.emailAddress)
                      : buildTextInputField(
                          "mobile".tr, "mobile".tr, bloc.onMobileChange,
                          keyboardType: TextInputType.phone),
                  // Replace hardcoded text with keys

                  SizedBox(height: 15),
                  buildTextInputField("mother_first_name".tr,
                      "mother_first_name".tr, bloc.onFirstNameChange),
                  SizedBox(height: 15),
                  buildTextInputField("mother_last_name".tr,
                      "mother_last_name".tr, bloc.onLastNameChange),
                  SizedBox(height: 15),
                  buildTextInputField(
                      "password".tr, "password".tr, bloc.onPasswordChange,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true),
                  SizedBox(height: 15),
                  buildTextInputField("confirm_password".tr,
                      "confirm_password".tr, bloc.onConfirmPasswordChange,
                      obscureText: true),
                  const SizedBox(height: 15),
                  Text(
                    "accept_terms".tr,
                    style: const TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF353842),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: kIsWeb ? 5 : 30),

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          if (!kIsWeb) SizedBox(height: 15),
                          if (kIsWeb)
                            SizedBox(
                                width: 400,
                                height: 110,
                                child: Recaptcha(
                                  onChangeToken: bloc.onChangeToken,
                                )),
                        ],
                      )),
                  ElevatedButton(
                    onPressed: bloc.register.call(),
                    child: Center(
                      child: bloc.uiState.isLoading
                          ? const MyLoader(color: Colors.black)
                          : Text(
                              "continue".tr,
                              style: TextStyle(
                                fontFamily: 'IRANSansXFaNum',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: bloc.gotoLoginPage.call(),
                      child: Text(
                        "have_account".tr,
                        style: TextStyle(
                          fontFamily: 'IRANSansXFaNum',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF9E3840),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextInputField(
      String title, String placeholder, final Function(String) onChangeValue,
      {TextInputType keyboardType = TextInputType.text,
      bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF353842),
          ),
          textAlign: TextAlign.right,
        ),
        SizedBox(height: 8),
        TextField(
          onChanged: onChangeValue,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none, // Remove default border
            hintText: placeholder,
          ),
        ),
      ],
    );
  }

  Widget buildRadioButton(String title, bool isSelected) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF505463),
          ),
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 8),
        SvgPicture.asset(
          isSelected ? 'assets/radio-button-2.svg' : 'assets/radio-button.svg',
          width: 28,
          height: 28,
        ),
      ],
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    // if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    //   throw Exception('Could not launch $uri');
    // }
  }
}

class FormTitleWithStar extends StatelessWidget {
  const FormTitleWithStar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const StarText(),
      ],
    );
  }
}

class StarText extends StatelessWidget {
  const StarText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("*",
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.red));
  }
}

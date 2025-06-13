import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/form/validator/EmailValidator.dart';
import 'package:my_ios_app/core/form/validator/MobileValidator.dart';
import 'package:my_ios_app/core/form/validator/NameValidator.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MamakTitle.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/app/ContactUsViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

import 'MamakMap.dart';

class ContactUsUi extends StatelessWidget {
  const ContactUsUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ContactUsViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "پشتیبان",
              style: TextStyle(
                fontFamily: 'IRANSansXFaNum',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            leading: IconButton(
              icon:
                  Image.asset('assets/huge-icon-arrows-outline-arrow-left.svg'),
              onPressed: () {},
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Information about the advisor
                  buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSectionHeader('اطلاعات مشاور'),
                        divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'خانم سارا موسوی',
                                style: TextStyle(
                                  fontFamily: 'IRANSansXFaNum',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFF272930),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'کارشناس ارشد روانشناسی کودک',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'IRANSansXFaNum',
                                  color: Color(0xFF353842),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '0912356269',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'IRANSansXFaNum',
                                  color: Color(0xFF0197F6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Session information
                  buildSessionInfo(
                      'اطلاعات جلسه ی ایکس',
                      'شما برای آشنایی بیشتر با گروه مامک با پشتیبان خود جلسه مشاوره دارید.',
                      'تاریخ جلسه : شنبه  1402/12/11 ساعت : 12:45',
                      'شما در این جلسه شرکت کرده اید.'),
                  buildSessionInfo(
                      'اطلاعات جلسه ی معارفه',
                      'شما برای آشنایی بیشتر با گروه مامک با پشتیبان خود جلسه مشاوره دارید.',
                      'تاریخ جلسه : شنبه  1402/12/11 ساعت : 12:45',
                      'متاسفانه شما این جلسه را از دست داده اید.'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget divider() {
    return Divider(
      color: Color(0xFFD1D5DA), // Adjust to your desired color
      thickness: 1,
      height: 1,
    );
  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'IRANSansXFaNum',
          color: Color(0xFF505463),
        ),
      ),
    );
  }

  Widget buildSectionContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget buildSessionInfo(
      String header, String description, String dateInfo, String status) {
    return buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader(header),
          divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'IRANSansXFaNum',
                    color: Color(0xFF353842),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  dateInfo,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'IRANSansXFaNum',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF272930),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    if (status == 'شما در این جلسه شرکت کرده اید.')
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF3D9C68),
                      )
                    else
                      Icon(
                        Icons.remove_circle_outlined,
                        color: Color(0xFFCC102D),
                      ),
                    SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'IRANSansXFaNum',
                        color: status.contains('شرکت کرده اید')
                            ? Color(0xFF3D9C68)
                            : Color(0xFFCC102D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class ContactUsFormUi extends StatelessWidget {
  const ContactUsFormUi({
    Key? key,
    required this.formKey,
    required this.onNameChange,
    required this.onEmailChange,
    required this.onMobileChange,
    required this.onSubjectChange,
    required this.onTextChange,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final Function(String) onNameChange,
      onEmailChange,
      onMobileChange,
      onSubjectChange,
      onTextChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.dpev,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormFieldHelper(
              label: 'name'.tr,
              hint: 'name'.tr,
              keyboardType: TextInputType.text,
              onChangeValue: onNameChange,
              validator: NameValidator(),
            ),
            8.dpv,
            TextFormFieldHelper(
              label: 'email'.tr,
              hint: 'email'.tr,
              keyboardType: TextInputType.emailAddress,
              onChangeValue: onEmailChange,
              validator: EmailValidator(),
            ),
            8.dpv,
            TextFormFieldHelper(
              label: 'phone_number'.tr,
              hint: 'phone_number'.tr,
              keyboardType: TextInputType.number,
              onChangeValue: onMobileChange,
              validator: MobileValidator(),
            ),
            8.dpv,
            TextFormFieldHelper(
                label: 'subject_msg'.tr,
                hint: 'subject_msg'.tr,
                keyboardType: TextInputType.text,
                onChangeValue: onSubjectChange),
            8.dpv,
            SizedBox(
              height: 200,
              child: TextFormFieldHelper(
                label: 'text_msg'.tr,
                hint: 'text_msg'.tr,
                keyboardType: TextInputType.text,
                onChangeValue: onTextChange,
                expand: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:core/utils/flow/MyFlow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/form/validator/EmailValidator.dart';
import 'package:my_ios_app/core/form/validator/MobileValidator.dart';
import 'package:my_ios_app/core/form/validator/NameValidator.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/user/profile/Meeting.dart';
import 'package:my_ios_app/presentation/viewModel/app/ContactUsViewModel.dart';
import 'package:my_ios_app/useCase/child/AdddataUseVase.dart';
// import 'package:url_launcher/url_launcher.dart';

class SourceUi extends StatefulWidget {
  const SourceUi({Key? key}) : super(key: key);
  @override
  _SourceUiUiState createState() => _SourceUiUiState();
}

class _SourceUiUiState extends State<SourceUi> {
  bool isLoading = false;
  String errorMessage = '';
  late List<Supervisors> supervisorsData = [];

  @override
  void initState() {
    getReservedMeeting();
    super.initState();
  }

  void getReservedMeeting() {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    AdddataUseVase().getAllSupervisorsOfUserChildren(MyFlow(flow: (appState) {
      setState(() {
        isLoading = false;
        if (appState.isSuccess) {
          print("appState.getData is Meeting");
          print(appState.getData is List<Supervisors>);
          // Assuming `getReservedMeetings` returns a list of meetings
          if (appState.getData is List<Supervisors>) {
            List<Supervisors> response = appState.getData;
            supervisorsData = response;
            setState(() {
              supervisorsData = response;
            });
          }
        } else if (appState.isFailed) {
          errorMessage =
              appState.getErrorModel?.message ?? 'Failed to fetch meetings';
        }
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ContactUsViewModel(AppState.idle),
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
                    "support_title".tr, // replaced Farsi text
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
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: supervisorsData.length,
                    itemBuilder: (context, index) {
                      Supervisors data = supervisorsData[index];
                      return buildSectionContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSectionHeader(
                                'advisor_info'.tr), // replaced Farsi text
                            divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data.FirstName} ${data.LastName}', // replaced Farsi text
                                    style: TextStyle(
                                      fontFamily: 'IRANSansXFaNum',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xFF272930),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${data.ChildFirstName} ${data.ChildLastName}', // replaced Farsi text
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'IRANSansXFaNum',
                                      color: Color(0xFF353842),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${data.Mobile} ',
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
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                  // Information about the advisor

                  // // Session information
                  // buildSessionInfo(
                  //     'session_info_x'.tr, // replaced Farsi text
                  //     'session_description_x'.tr, // replaced Farsi text
                  //     'session_date_info_x'.tr, // replaced Farsi text
                  //     'session_status_attended'.tr), // replaced Farsi text
                  // buildSessionInfo(
                  //     'intro_session_info'.tr, // replaced Farsi text
                  //     'session_description_intro'.tr, // replaced Farsi text
                  //     'session_date_info_intro'.tr, // replaced Farsi text
                  //     'session_status_missed'.tr), // replaced Farsi text
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
                    if (status ==
                        'session_status_attended'.tr) // replaced Farsi text
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

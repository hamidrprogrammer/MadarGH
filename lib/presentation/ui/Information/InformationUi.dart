
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/core/form/validator/LastNameValidator.dart';
import 'package:my_ios_app/core/form/validator/NameValidator.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakLogo.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/recaptcha/recaptcha.dart';

import 'package:my_ios_app/presentation/ui/register/text_with_link.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/SignUpViewModel.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../viewModel/user/InformationViewModel.dart';
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
class InformationUi extends StatefulWidget {
  const InformationUi({Key? key}) : super(key: key);

  @override
  _InformationUiState createState() => _InformationUiState();
}
class _InformationUiState extends State<InformationUi> {
  final ValueNotifier<int> maritalStatusNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => InformationViewModel(AppState.idle),
      builder: (bloc, state) {
        bloc.fetchData(); //
        return FutureBuilder<void>(
            future: bloc.fetchDatat(),

          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
        } else {

          maritalStatusNotifier.value = bloc.info!.maritalStatus!;

          return SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
        child: Form(
        key: bloc.formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        20.dpv,
        Text(
       "اطلاعات والدین",
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        ),
        20.dpv,
        const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        MamakLogo(),
        ],
        ),
        20.dpv,

        10.dpv,
        FormTitleWithStar(title: "mothers_name".tr),
        4.dpv,
        TextFormFieldHelper(
        label: bloc.info?.firstName ?? "mothers_name".tr,
        hint: bloc.info?.firstName ?? "mothers_name".tr,
        keyboardType: TextInputType.text,
        onChangeValue: bloc.onFirstNameChange,
        validator: NameValidator(),
        ),
        10.dpv,
        FormTitleWithStar(title: "mothers_family".tr),
        4.dpv,
        TextFormFieldHelper(
        label: bloc.info?.lastName ?? "mothers_family".tr,
        hint: bloc.info?.lastName ??"mothers_family".tr,
        keyboardType: TextInputType.text,
        onChangeValue: bloc.onLastNameChange,
        validator: LastNameValidator(),
        ),
        10.dpv,
        20.dpv,
        Text(
        'وضعیت تحصیلی مادر را انتخاب کنید',
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<EducationStatus>(
        borderRadius: const BorderRadius.all(
        Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          bloc.info?.motherEducation != null &&
        bloc.info!.motherEducation! > 0 &&
        bloc.info!.motherEducation! <= EducationStatus.values.length
              ?EducationStatus.values[bloc.info!.motherEducation! -1].displayName : 'وضعیت تحصیلی مادر را انتخاب کنید',
        style: context.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: .9,
        ),
        // value: bloc.signUpBy,
        items: EducationStatus.values.map((item) {
        return DropdownMenuItem<EducationStatus>(
        value: item,
        child: Text(item.displayName),
        );
        }).toList(),
        onChanged: (value) {
        bloc.onEducationStatusChange(value!.value);
        },
        ),
        ),
        20.dpv,
        Text(
        'وضعیت شغلی مادر را انتخاب کنید'.tr,
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<JobStatus>(
        borderRadius: const BorderRadius.all(
        Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          bloc.info?.motherJobStatus != null &&
        bloc.info!.motherJobStatus! > 0 &&
        bloc.info!.motherJobStatus! <= JobStatus.values.length
              ?JobStatus.values[bloc.info!.motherJobStatus! -1].displayName : 'وضعیت شغلی مادر را انتخاب کنید'.tr,
        style: context.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: .9,
        ),
        // value: bloc.signUpBy,
        items: JobStatus.values.map((item) {
        return DropdownMenuItem<JobStatus>(
        value: item,
        child: Text(item.displayName),
        );
        }).toList(),
        onChanged: (value) {
        bloc.onJobStatusChange (value!.value);
        },
        ),
        ),
        20.dpv,
        Text(
        "عنوان شغل مادر",
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        TextFormFieldHelper(
        label:bloc.info?.motherJobTitle ?? "عنوان شغل مادر",
        hint: bloc.info?.motherJobTitle ??"عنوان شغل مادر",
        keyboardType: TextInputType.text,
        onChangeValue: bloc.onMotherJobTitle,
        validator: NameValidator(),
        ),

        20.dpv,
        Text(
        'وضعیت آرامش ذهنی مادر را انتخاب کنید',
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<MentalPeaceStatus>(
        borderRadius: const BorderRadius.all(
        Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          bloc.info?.mentalPeace != null &&
        bloc.info!.mentalPeace! > 0 &&
        bloc.info!.mentalPeace! <= MentalPeaceStatus.values.length
              ?MentalPeaceStatus.values[bloc.info!.mentalPeace! -1].displayName : 'وضعیت آرامش ذهنی مادر را انتخاب کنید',
        style: context.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: .9,
        ),
        // value: bloc.signUpBy,
        items: MentalPeaceStatus.values.map((item) {
        return DropdownMenuItem<MentalPeaceStatus>(
        value: item,
        child: Text(item.displayName),
        );
        }).toList(),
        onChanged: (value) {
        bloc.onMentalPeaceStatusChange (value!.value);
        },
        ),
        ),
        20.dpv,
        Text(
        "وضعیت حمایت مادر را انتخاب کنید",
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<SupportStatus>(
        borderRadius: const BorderRadius.all(
        Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          bloc.info?.support != null &&
              bloc.info!.support! > 0 &&
              bloc.info!.support! <= SupportStatus.values.length?SupportStatus.values[bloc.info!.support! -1 ].displayName :"وضعیت حمایت مادر را انتخاب کنید",
        style: context.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: .9,
        ),
        // value: bloc.signUpBy,
        items: SupportStatus.values.map((item) {
        return DropdownMenuItem<SupportStatus>(
        value: item,
        child: Text(item.displayName),
        );
        }).toList(),
        onChanged: (value) {
        bloc.onSupportStatusChange (value!.value);
        },
        ),
        ),
        20.dpv,
        Text(
        "وضعیت سلامت مادر را انتخاب کنید",
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<HealthStatus>(
        borderRadius: const BorderRadius.all(
        Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text( bloc.info?.health != null &&
        bloc.info!.health! > 0 &&
        bloc.info!.health! <= HealthStatus.values.length
              ?HealthStatus.values[bloc.info!.health! -1].displayName : "وضعیت سلامت مادر را انتخاب کنید",
        style: context.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: .9,
        ),
        // value: bloc.signUpBy,
        items: HealthStatus.values.map((item) {
        return DropdownMenuItem<HealthStatus>(
        value: item,
        child: Text(item.displayName),
        );
        }).toList(),
        onChanged: (value) {
        bloc.onHealthStatusChange (value!.value);
        },
        ),
        ),
        // const FormTitleWithStar(title: "استان"),

          20.dpv,
          Text(
            'وضعیت تاهل را انتخاب کنید',
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          4.dpv,
          ValueListenableBuilder<int>(
              valueListenable: maritalStatusNotifier,
              builder: (context, maritalStatus, _) {
                return  ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<MaritalStatus>(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(WidgetSize.textFieldRadiusSize)),
                    hint: Text(
                      bloc.info?.maritalStatus != null &&
                          bloc.info!.maritalStatus! > 0 &&
                          bloc.info!.maritalStatus! <= MaritalStatus.values.length
                          ?MaritalStatus.values[bloc.info!.maritalStatus! -1].displayName :'وضعیت تاهل را انتخاب کنید',
                      style: context.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: .9,
                    ),
                    // value: bloc.signUpBy,
                    items: MaritalStatus.values.map((item) {
                      return DropdownMenuItem<MaritalStatus>(
                        value: item,
                        child: Text(item.displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      maritalStatusNotifier.value = value!.value;
                      bloc.onMaritalStatusChange (value!.value);
                    },
                  ),
                );}),
        10.dpv,
            ValueListenableBuilder<int>(
            valueListenable: maritalStatusNotifier,
            builder: (context, maritalStatus, _) {
              return  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [


        if (maritalStatusNotifier.value == MaritalStatus.Couple.value) ...[
        20.dpv,
        Text(
        'وضعیت تحصیلی پدر را انتخاب کنید',
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<EducationStatus>(
        borderRadius: const BorderRadius.all(
        Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          bloc.info?.fatherEducation != null &&
              bloc.info!.fatherEducation! > 0 &&
              bloc.info!.fatherEducation! <= EducationStatus.values.length

              ?EducationStatus.values[bloc.info!.fatherEducation! -1].displayName : 'وضعیت تحصیلی پدر را انتخاب کنید',
        style: context.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: .9,
        ),
        // value: bloc.signUpBy,
        items: EducationStatus.values.map((item) {
        return DropdownMenuItem<EducationStatus>(
        value: item,
        child: Text(item.displayName),
        );
        }).toList(),
        onChanged: (value) {

        bloc.onEducationFatherStatusChange(value!.value);
        },
        ),
        ),
        20.dpv,
        Text(
        'وضعیت شغلی پدر را انتخاب کنید'.tr,
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),
        4.dpv,
        ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<JobStatus>(
        borderRadius: const BorderRadius.all(
        Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          bloc.info?.fatherJobStatus != null &&
              bloc.info!.fatherJobStatus! > 0 &&
              bloc.info!.fatherJobStatus! <= JobStatus.values.length
              ?JobStatus.values[bloc.info!.fatherJobStatus! -1].displayName : 'وضعیت شغلی پدر را انتخاب کنید'.tr,
        style: context.textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: .9,
        ),
        // value: bloc.signUpBy,
        items: JobStatus.values.map((item) {
        return DropdownMenuItem<JobStatus>(
        value: item,
        child: Text(item.displayName),
        );
        }).toList(),
        onChanged: (value) {
        bloc.onJobFatherStatusChange (value!.value);
        },
        ),
        ),
        20.dpv,
        Text(
        "عنوان شغل پدر",
        style: context.textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        ),

        4.dpv,
        TextFormFieldHelper(
        label:bloc.info?.fatherJobTitle ?? "عنوان شغل پدر",
        hint: bloc.info?.fatherJobTitle ??"عنوان شغل پدر",
        keyboardType: TextInputType.text,
        onChangeValue: bloc.onFatherJobTitle,
        validator: NameValidator(),
        ),
        10.dpv,


        ],
        ]);
        }),

        20.dpv,
        ElevatedButton(
        onPressed: bloc.register.call(),
        child: bloc.uiState.isLoading
        ? const MyLoader(color: Colors.black)
            : Text("ثبت")),

        ],
        ),
        ),
        ),
        );
        }
        }

    );
  }
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

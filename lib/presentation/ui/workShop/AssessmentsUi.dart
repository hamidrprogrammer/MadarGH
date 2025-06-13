import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/MyTheme.dart';
import 'package:my_ios_app/data/serializer/assessment/QuestionsResponse.dart';
import 'package:my_ios_app/presentation/ui/assessment/AssessmentItemUi.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MamakTitle.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/uiModel/QuestionModel.dart';
import 'package:my_ios_app/presentation/viewModel/assessments/AssessmentsViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

import '../main/MyLoader.dart';

class ScheduleItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final String count;
  const ScheduleItem(
      {Key? key,
      required this.title,
      required this.iconPath,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SvgPicture.asset(
              this.iconPath,
              width: 24,
              height: 24,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              this.title,
              style: TextStyle(
                fontFamily: 'IRANSansXFaNum',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF353842),
              ),
            ),
          ]),
          Text(
            "${this.count} " + 'questionss'.tr,
            style: TextStyle(
              fontFamily: 'IRANSansXFaNum',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF353842),
            ),
          ),
        ],
      ),
    );
  }
}

class AssessmentsUi extends StatefulWidget {
  const AssessmentsUi({Key? key}) : super(key: key);

  @override
  State<AssessmentsUi> createState() => _AssessmentsUiState();
}

class _AssessmentsUiState extends State<AssessmentsUi> {
  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => AssessmentsViewModel(AppState.idle),
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
                    bloc.assessmentParamsModel!.course,
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
          body: SingleChildScrollView(
            child: Padding(
              padding: 8.dpe,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScheduleItem(
                      iconPath: "./assets/group-22-5.svg",
                      count: bloc.questionsWithCategory.length.toString(),
                      title: bloc.assessmentParamsModel!.course),
                  ConditionalUI<List<Question>>(
                    skeleton: const MyLoaderBig(),
                    state: bloc.apiState,
                    onSuccess: (data) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bloc.questionsWithCategory.length,
                        itemBuilder: (context, qIndex) {
                          var questionObject =
                              bloc.questionsWithCategory.elementAt(qIndex);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              4.dpv,
                              ListView.separated(
                                padding: 8.dpeh,
                                itemBuilder: (context, index) {
                                  return AssessmentItemUi(
                                      index: qIndex + 1,
                                      title: questionObject.title,
                                      item: questionObject.questions?[index]);
                                },
                                itemCount:
                                    questionObject.questions?.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => 20.dpv,
                              ),
                              4.dpv,
                              const Divider(),
                              4.dpv,
                            ],
                          );
                        },
                      );
                    },
                  ),
                  16.dpv,
                  ElevatedButton(
                    onPressed: bloc.submitQuestions,
                    child: bloc.sendDataState.isLoading
                        ? const MyLoader()
                        : Text(
                            'reply'.tr,
                            style: TextStyle(
                              fontFamily: 'IRANSansXFaNum',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class AssessmentItemUi extends StatefulWidget {
//   const AssessmentItemUi({
//     Key? key,
//     required this.item,
//     required this.questionModel,
//     required this.onOptionSelected,
//     required this.onChangeDescription,
//   }) : super(key: key);
//   final Question? item;
//   final QuestionModel questionModel;
//   final Function(String?, Option?) onOptionSelected;
//   final Function(String?, String) onChangeDescription;
//
//   // late Uint8List content;
//
//   @override
//   State<AssessmentItemUi> createState() => _AssessmentItemUiState();
// }
//
// class _AssessmentItemUiState extends State<AssessmentItemUi> {
//   int? index = 0;
//
//   @override
//   void initState() {
//     index = widget.item?.options?.indexWhere((element) =>
//         element.optionId?.toString() ==
//         widget.questionModel.assessmentQuestionOptionId);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         4.dpv,
//         if (widget.item?.questionPicture != null &&
//             widget.item?.questionPicture?.content != null)
//           FutureBuilder(
//             future:
//                 getBase64FromContent(widget.item?.questionPicture?.content!),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return ClipRRect(
//                   borderRadius: 16.bRadius,
//                   child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 150.0,
//                       child: Image.memory(
//                         base64Decode(widget.item?.questionPicture?.content!),
//                         fit: BoxFit.contain,
//                       )),
//                 );
//               }
//               return const SizedBox(
//                 height: 150,
//                 child: Center(child: MyLoader()),
//               );
//             },
//           ),
//         8.dpv,
//         Container(
//           padding: 16.dpe,
//           margin: 4.dpe,
//           decoration: BoxDecoration(
//             borderRadius: 8.bRadius,
//             color: Colors.grey.shade50,
//             border: Border.all(color: Colors.grey.shade100),
//           ),
//           child: Text(widget.item?.questionTitle ?? ''),
//         ),
//         Container(
//           padding: 16.dpe,
//           margin: 4.dpe,
//           decoration: BoxDecoration(
//             borderRadius: 8.bRadius,
//             color: Colors.blue.shade50,
//             border: Border.all(color: Colors.blue.shade100),
//           ),
//           child: ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.item?.options?.length,
//             itemBuilder: (context, index) => SizedBox(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Checkbox(
//                     value: widget.item?.options
//                             ?.elementAt(index)
//                             .optionId
//                             ?.toString() ==
//                         widget.questionModel.assessmentQuestionOptionId,
//                     onChanged: (value) {
//                       print(value);
//                       widget.onOptionSelected.call(
//                           widget.item?.questionId?.toString(),
//                           value == true
//                               ? widget.item?.options?.elementAt(index)
//                               : null);
//                     },
//                   ),
//                   Expanded(
//                     child: Text(
//                       widget.item?.options?[index].optionTitle ?? '',
//                       style: context.textTheme.titleSmall
//                           ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         8.dpv,
//         SizedBox(
//           height: 100,
//           child: TextFormFieldHelper(
//             hint: getDescriptionText(index ?? 0),
//             keyboardType: TextInputType.text,
//             label: getDescriptionText(index ?? 0),
//             onChangeValue: (value) {
//               widget.onChangeDescription
//                   .call(widget.item?.questionId?.toString(), value);
//             },
//             expand: true,
//             textAlign: TextAlign.start,
//           ),
//         ),
//       ],
//     );
//   }
//
//   String getDescriptionText(int index) {
//     if (index == -1) return 'پاسخ';
//     if (index == 0 || index == 1) {
//       return 'هدفگذاری';
//     }
//     return 'راهکار';
//   }
//
//   Future<Uint8List> getBase64FromContent(String content) async =>
//       base64Decode(widget.item?.questionPicture?.content!);
// }

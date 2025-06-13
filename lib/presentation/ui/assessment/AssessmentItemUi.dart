import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/assessment/QuestionsResponse.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/assessments/AssessmentsViewModel.dart';

class AssessmentItemUi extends StatefulWidget {
  AssessmentItemUi({
    Key? key,
    required this.item,
    required this.title,
    required this.index,
    this.content,
  }) : super(key: key);

  Question? item;
  final int index;
  final String title;

  Uint8List? content;

  @override
  State<AssessmentItemUi> createState() => _AssessmentItemUiState();
}

class _AssessmentItemUiState extends State<AssessmentItemUi> {
  int? selectedItem;

  @override
  void initState() {
   final content = widget.item?.questionPicture?.content;
if (content != null) {
  getContent(content);
}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        4.dpv,
        if (widget.content != null)
          Stack(
            alignment: Alignment
                .bottomRight, // Aligns the text to the bottom right corner
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    16), // Use your custom extension if available
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150.0,
                  child: Image.memory(
                    widget.content!,
                    fit: BoxFit
                        .cover, // Use BoxFit.cover for better aspect ratio handling
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                    8), // Add margin for spacing from the edges
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4), // Padding around the text
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 130, 130, 130).withOpacity(
                      0.5), // Semi-transparent background for better readability
                  borderRadius: BorderRadius.circular(
                      8), // Rounded corners for the text container
                ),
                child: Text(
                  widget.title, // Replace with your desired text
                  style: TextStyle(
                           fontFamily: 'IRANSansXFaNum',
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Adjust size as needed
                  ),
                ),
              ),
            ],
          ),
        8.dpv,
        Container(
          padding: 16.dpe,
          margin: 4.dpe,
          decoration: BoxDecoration(
            borderRadius: 8.bRadius,
          ),
          child: Text('${widget.index}.${widget.item?.questionTitle ?? ''}',
          style: TextStyle(
                           fontFamily: 'IRANSansXFaNum',
                    color: Colors.black, // Text color
                    fontWeight: FontWeight.bold,
                    fontSize: 13, // Adjust size as needed
                  ),),
        ),
        Container(
          padding: 16.dpe,
          margin: 4.dpe,
          decoration: BoxDecoration(
            borderRadius: 8.bRadius,
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: const Color.fromARGB(255, 205, 205, 205)),
          ),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.item?.options?.length,
            itemBuilder: (context, index) => SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: widget.item?.options
                            ?.elementAt(index)
                            .optionId
                            ?.toString() ??
                        '',
                    groupValue: selectedItem?.toString() ?? '',
                    onChanged: (value) {
                      context.read<AssessmentsViewModel>().onOptionSelected(
                            widget.item?.questionId?.toString(),
                            value != null
                                ? widget.item?.options?.firstWhere((option) =>
                                    option.optionId.toString() == value)
                                : null,
                          );
                      print(value);
                      var pasr = int.parse(value!);
                      setState(() {
                        selectedItem = pasr;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      widget.item?.options?[index].optionTitle ?? '',
                      style: TextStyle(
                           fontFamily: 'IRANSansXFaNum',
                    color: Colors.black, // Text color
                    fontWeight: FontWeight.bold,
                    fontSize: 13, // Adjust size as needed
                  ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        8.dpv,
        // SizedBox(
        //   height: 100,
        //   child: TextFormFieldHelper(
        //     hint: getDescriptionText(widget.item?.options?.indexWhere(
        //             (element) => element.optionId == selectedItem) ??
        //         0),
        //     keyboardType: TextInputType.text,
        //     label: getDescriptionText(widget.item?.options?.indexWhere(
        //             (element) => element.optionId == selectedItem) ??
        //         0),
        //     onChangeValue: (value) {
        //       context
        //           .read<AssessmentsViewModel>()
        //           .onChangeDesc(widget.item?.questionId?.toString(), value);
        //     },
        //     expand: true,
        //     textAlign: TextAlign.start,
        //   ),
        // ),
      ],
    );
  }

  String getDescriptionText(int index) {
    if (index == -1) return 'enter_target'.tr; //enter_target
    if (index == 0 || index == 1) {
      return 'enter_target'.tr;
    }
    return 'enter_suggestion'.tr; //enter_suggestion
  }

  Future<Uint8List> getBase64FromContent(String content) async =>
      base64Decode(widget.item!.questionPicture!.content!);

  void getContent(String content) async {
    widget.content = await getBase64FromContent(content);
    setState(() {});
  }
}

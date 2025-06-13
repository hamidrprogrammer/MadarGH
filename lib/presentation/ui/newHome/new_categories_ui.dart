import 'dart:convert';

import 'package:core/color/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/home/CategoryResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/home/CategoriesViewModel.dart';

class NewCategoriesUi extends StatelessWidget {
  const NewCategoriesUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => CategoriesViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<List<Category>>(
          state: state,
          onSuccess: (categories) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16), // Border radius for the card
              ),
              elevation: 4, // Elevation to give some shadow
              child: Container(
                padding: 16.dpe,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius:
                      BorderRadius.circular(16), // Same radius for consistency
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: categories
                      .map((category) => StaggeredGridTile.count(
                            crossAxisCellCount:
                                categories.indexOf(category) > 2 ? 3 : 2,
                            mainAxisCellCount: 2,
                            child: NewCategoryItemUi(
                              category: category,
                              onClick: (data) {
                                bloc.gotoDetail(data);
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
            );
          },
          skeleton: const MyLoaderBig(),
        );
      },
    );
  }
}

class NewCategoryItemUi extends StatelessWidget {
  const NewCategoryItemUi(
      {Key? key, required this.category, required this.onClick})
      : super(key: key);
  final Category category;
  final Function(String) onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call(category.id?.toString() ?? '0');
      },
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: 8.dpe,
          margin: 4.dpe,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: 8.bRadius,
            border: Border.all(
              color: const Color.fromARGB(
                  255, 121, 121, 121), // Specify the color of the border
              width: 0.5, // Specify the width of the border
            ),
          ),
          child: ProgramDay(
            day: 'چهار ش 13 تیر :',
            subject: category.title ?? '',
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            icon: 'assets/group_2110_x2.svg',
          )),
    );
  }
}

class ProgramButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF9E3840),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'شروع ارزیابی',
        style: TextStyle(
          fontFamily: 'IRANSansXFaNum',
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Colors.white,
          height: 1.5,
        ),
      ),
    );
  }
}

class ProgramDay extends StatelessWidget {
  final String day;
  final String subject;
  final Color backgroundColor;
  final String icon;

  ProgramDay({
    required this.day,
    required this.subject,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 28,
            height: 28,
          ),
          Text(
            day,
            style: TextStyle(
              fontFamily: 'IRANSansXFaNum',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF353842),
              height: 1.5,
            ),
          ),
          Spacer(),
          Text(
            subject,
            style: TextStyle(
              fontFamily: 'IRANSansXFaNum',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF353842),
              height: 1.5,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

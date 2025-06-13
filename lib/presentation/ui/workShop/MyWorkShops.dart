import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:my_ios_app/config/apiRoute/BaseUrls.dart';
import 'package:my_ios_app/config/uiCommon/MyTheme.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/data/serializer/child/WorkShopOfUserResponse.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/ui/child/ChildHorizontalListViewUi.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MamakTitle.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/uiModel/assessmeny/AssessmentParamsModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/workBook/MyWorkShopsViewModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../dialog/VideoPlayerDialog.dart';

class MyWorkShops extends StatefulWidget {
  const MyWorkShops({Key? key}) : super(key: key);

  @override
  _MyWorkShopsState createState() => _MyWorkShopsState();
}

class _MyWorkShopsState extends State<MyWorkShops> {
  List<Accordion> favorites = [];
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<List<Accordion>> getFavorites() async {
    // final prefs = await SharedPreferences.getInstance();
    // List<String> favorites = prefs.getStringList('favorites') ?? [];

    // Convert JSON strings back to Accordion objects
    return [];
  }

  Future<void> _loadFavorites() async {
    List<Accordion> loadedFavorites = await getFavorites();
    setState(() {
      favorites = loadedFavorites;
    });
  }

  Future<void> removeFavorite(Accordion accordion) async {
    // final prefs = await SharedPreferences.getInstance();
    List<String> favorites =  [];

    // Convert each favorite to an Accordion object and compare with the item to remove
    favorites.removeWhere((item) {
      Accordion favoriteAccordion = Accordion.fromJson(jsonDecode(item));
      return favoriteAccordion.id ==
          accordion.id; // Assuming Accordion has an 'id' property
    });

    // Save the updated list back to SharedPreferences
    // await prefs.setStringList('favorites', favorites);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8fc),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            Positioned.fill(
              top: kIsWeb ? 0 : 15,
              child: Image.asset(
                'assets/Rectangle21.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            AppBar(
              title: Text(
                'راهکار های من ',
                style: TextStyle(
                  fontFamily: 'IRANSansXFaNum',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ],
        ),
      ),
      body: (favorites == null || favorites.isEmpty)
          ? Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons8_folder.png',
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    "شما هنوز راهکاری را ذخیره نکرده اید.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF272930),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                var data = favorites[index];
                return InkWell(
                    onTap: () {
                      // Your tap functionality here
                      Get.toNamed(
                        AppRoute.workDetails,
                        arguments: data,
                      );
                    },
                    child: SavedItem(
                        item: data,
                        onRemove: () {
                          setState(() {
                            favorites.removeAt(
                                index); // Remove from UI after deletion
                          });
                        }));
              },
            ),
    );
  }
}

class SavedItem extends StatelessWidget {
  const SavedItem({Key? key, required this.item, required this.onRemove})
      : super(key: key);
  final Accordion item;
  final VoidCallback onRemove;
  Future<void> removeFavorite(Accordion accordion) async {
    // final prefs = await SharedPreferences.getInstance();
    List<String> favorites = [];

    // Convert each favorite to an Accordion object and compare with the item to remove
    favorites.removeWhere((item) {
      Accordion favoriteAccordion = Accordion.fromJson(jsonDecode(item));
      return favoriteAccordion.id ==
          accordion.id; // Assuming Accordion has an 'id' property
    });

    // Save the updated list back to SharedPreferences
    // await prefs.setStringList('favorites', favorites);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          // Return false to prevent back navigation
          return true;
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: screenWidth / 2 - 50,
                    child: Text(
                      item.learningOpportunity,
                      style: TextStyle(
                        fontFamily: 'IRANSansXFaNum',
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Color(0xFF272930),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset('assets/line-428.svg', height: 16),
                  SizedBox(width: 8),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Color(0xFF5F6286),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  await removeFavorite(item); // Remove from SharedPreferences
                  onRemove(); //
                },
                child: SvgPicture.asset('assets/tabler-icon-trash.svg',
                    width: 24, height: 24),
              )
            ],
          ),
        ));
  }
}

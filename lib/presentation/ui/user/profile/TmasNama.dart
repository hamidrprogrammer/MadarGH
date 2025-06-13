import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_ios_app/di/appModule.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/viewModel/app/ContactUsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../config/apiRoute/BaseUrls.dart';
import '../../main/MyLoader.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';
class ContactUsApp extends StatelessWidget {
  const ContactUsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContactUsPage();
  }
}
class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  ContactUsPageState createState() => ContactUsPageState();
}
class ContactUsPageState   extends State<ContactUsPage> {
  String? _selectedGender; // Store the selected gender

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
                    title: const Text(
                      'تماس با ما',
                      style: TextStyle(
                        fontFamily: 'IRANSansXFaNum',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: Colors.transparent,
                    // Make AppBar transparent
                    elevation: 0, // Remove shadow
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContactInfoCard(
                            imagePath: 'assets/ellipse-1201.svg',
                            iconPath:
                            'assets/huge-icon-communication-outline-calling.svg',
                            title: 'تلفن',
                            content: '0216463 داخلی 1320',
                          ),
                          ContactInfoCard(
                            imagePath: 'assets/ellipse-1201-2.svg',
                            iconPath: 'assets/huge-icon-user-outline-users-02.svg',
                            title: 'ایمیل',
                            content: 'info@mamakschool.ir',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),




                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'دسته بندی موضوع',
                                  style: TextStyle(
                                    fontFamily: 'IRANSansXFaNum',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: Color(0xFF353842),
                                  ),
                                ),
                                const SizedBox(height: 6),

                                CustomDropdown(
                                  onCategoryChanged: (int title) {
                                    int number = int.parse(title.toString());
                                    print(number);

                                    bloc.onSubChange(title);
                                  },
                                  apiUrl:
                                  'https://landing.mamakschool.ir/MamakTestBackend/api/ContentCategory/GetAllContentCategories?includeImage=true',
                                ),



                                const Text(
                                  'پیام شما',
                                  style: TextStyle(
                                    fontFamily: 'IRANSansXFaNum',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: Color(0xFF353842),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 150,
                                  // To simulate the text input area
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6F6F8),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: 'پیام خود را بنویسید',
                                        // Placeholder text
                                        border:
                                        OutlineInputBorder(), // Optional: to show a border like a text area
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines:
                                      null,
                                      // Makes the text field multi-line (textarea-like)
                                      minLines: 5,
                                      onChanged: bloc.onTextChange,

                                      style: const TextStyle(
                                        fontFamily: 'IRANSansXFaNum',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        color: Color(0xFF505463),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap:bloc.state.isLoading ? null: bloc.submitForm,
                            child:
                            Center(
                              child: Container(
                                width: 296.0,
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF9E3840),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: bloc.state.isLoading
                                      ? const MyLoader() :Text(
                                    'تایید و ارسال پیام',
                                    style: TextStyle(
                                      fontFamily: 'IRANSansXFaNum',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildTextInputField({required String title,
    required String hintText,
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

  Widget buildGenderRadioButton(String text, bool value,
      {required Null Function(bool? newValue) onChanged}) {
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

}

class ContactInfoCard extends StatelessWidget {
  final String imagePath;
  final String iconPath;
  final String title;
  final String content;

  ContactInfoCard({
    required this.imagePath,
    required this.iconPath,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            imagePath,
            width: 56.0,
            height: 56.0,
          ),
          const SizedBox(height: 8),
          SvgPicture.asset(
            iconPath,
            width: 24.0,
            height: 24.0,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'IRANSansXFaNum',
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: Color(0xFF696F82),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'IRANSansXFaNum',
              fontWeight: FontWeight.w600,
              fontSize: 11.0,
              color: Color(0xFF353842),
            ),
          ),
        ],
      ),
    );
  }
}
class CustomDropdown extends StatefulWidget {
  final String apiUrl;
  final Function(int) onCategoryChanged; // Callback function to notify the parent widget

  const CustomDropdown({Key? key, required this.apiUrl, required this.onCategoryChanged}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<dynamic> categories = [];
  String? selectedCategory;


  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(widget.apiUrl),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json; charset=utf-8',
          'culture': 'fa-IR',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          categories = data['resultsList'];
        });
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55, // ارتفاع مشخص
      child: DropdownButtonFormField<String>(
        isExpanded: true, // بسیار مهم برای نمایش کامل متن
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(horizontal: 16), // فاصله افقی
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        hint: Align(
          alignment: Alignment.centerRight, // چینش راست به چپ (مخصوص زبان فارسی)
          child: Text(
            'دسته بندی موضوع', // متن پیش‌فرض
            style: TextStyle(
              fontSize: 16, // اندازه متن
              height: 1.0, // فاصله خط برای وسط‌چین عمودی
              color: Colors.grey,
            ),
          ),
        ),
        value: selectedCategory, // مقدار انتخاب‌شده
        items: categories.map<DropdownMenuItem<String>>((category) {
          return DropdownMenuItem<String>(
            value: category['id'].toString(),
            child: Align(
              alignment: Alignment.centerRight, // متن راست‌چین
              child: Text(
                category['title'], // عنوان دسته‌بندی
                style: TextStyle(
                  fontSize: 16, // اندازه متن گزینه‌ها
                  height: 1.0, // وسط‌چین عمودی
                  overflow: TextOverflow.visible, // نمایش کامل متن
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
          });

          // Pass the selected category's title to the parent widget
          if (value != null) {
            final selectedCategoryTitle = categories.firstWhere(
                    (category) => category['id'].toString() == value)['id'];
            widget.onCategoryChanged(selectedCategoryTitle); // Notify the parent
          }
          print('Selected Category ID: $selectedCategory');
        },
        style: TextStyle(
          fontSize: 16,
          height: 1.0, // متن وسط عمودی
          color: Colors.black,
        ),
        dropdownColor: Colors.white, // رنگ منوی بازشو
      ),
    );
  }
}
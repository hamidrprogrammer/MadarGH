import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';
import 'package:my_ios_app/data/serializer/subscribe/AllSubscriptionResponse.dart';
import 'package:my_ios_app/data/serializer/subscribe/CurrentPackageResponse.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/register/RegisterUi.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/subscription/SubscriptionViewModel.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../main/MamakTitle.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:intl/intl.dart' as intl;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SubscriptionUI extends StatefulWidget {
  const SubscriptionUI({Key? key}) : super(key: key);

  @override
  _SliderListState createState() => _SliderListState();
}

class _SliderListState extends State<SubscriptionUI> {
  int activeIndex = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
        create: (context) => SubscriptionViewModel(AppState.idle),
        builder: (bloc, state) {
          return ConditionalUI<List<AllSubscriptionItem>>(
              state: bloc.uiState,
              onSuccess: (data) {
                if (bloc.selectedItem == null) {
                  bloc.selectedItem = data[0];
                  bloc.onChangeSelectedItem(data[0]);
                }
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
                          ),
                        ),
                        AppBar(
                          title: Text(
                            "subscription_package_title"
                                .tr, // Replaced Farsi text
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
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index, realIndex) {
                            final package = data[index];
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${package.title} ',
                                      style: TextStyle(
                                        fontFamily: 'IRANSansXFaNum',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(0xFF353842),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${NumberFormat('#,###,###').format(package.price)}  ${'rial'.tr}',
                                      style: TextStyle(
                                        fontFamily: 'IRANSansXFaNum',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xFF696F82),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 130,
                            pageSnapping: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            viewportFraction: 0.9,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            onPageChanged: (index, reason) {
                              activeIndex = index;
                              bloc.selectedItem = data[index];
                              bloc.onChangeSelectedItem(data[index]);
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: data.length,
                          effect: WormEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Color.fromARGB(255, 232, 3, 159),
                              dotWidth: 5,
                              dotHeight: 5),
                        ),
                        // Discount Code Input
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'add_discount_code_title'
                                      .tr, // Replaced Farsi text
                                  style: TextStyle(
                                    fontFamily: 'IRANSansXFaNum',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xFF353842),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:MediaQuery.of(context).size.width < 600
                                            ?
                                        MediaQuery.of(context).size.width-120:330,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: TextFormFieldHelper(
                                            label: 'discount_code'.tr,
                                            hint: 'discount_code'.tr,
                                            controller: _controller,
                                            keyboardType: TextInputType.text,
                                            onChangeValue: bloc.onChangeCode),
                                      ),
                                      Spacer(),
                                      InkWell(
                                          onTap: () {
                                            if (bloc.selectedItem!.discount ==
                                                null) {
                                              bloc.submitCode();
                                            } else {
                                              bloc.onChangeCode('');
                                              _controller.clear();

                                              bloc.codeController.text = "";
                                              bloc.selectedItem!.discount =
                                                  null;
                                            }
                                          },
                                          child: Container(
                                              width: 40,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: bloc.selectedItem!
                                                            .discount !=
                                                        null
                                                    ? Color.fromARGB(
                                                        255, 215, 63, 91)
                                                    : Color.fromARGB(
                                                        255, 187, 185, 185),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Center(
                                                child: bloc.selectedItem!
                                                            .discount !=
                                                        null
                                                    ? SvgPicture.asset(
                                                        'assets/vectors/vector_130_x2.svg',
                                                        width: 20,
                                                        height: 20,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      )
                                                    : SvgPicture.asset(
                                                        'assets/vectors/vector_112_x2.svg',
                                                        width: 20,
                                                        height: 20,
                                                        color: Color.fromARGB(
                                                            255, 215, 2, 112),
                                                      ),
                                              ))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Payment Details
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'payment_details_title'
                                      .tr, // Replaced Farsi text
                                  style: TextStyle(
                                    fontFamily: 'IRANSansXFaNum',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF0C0D0F),
                                  ),
                                ),
                                Divider(color: Color(0xFFD1D5DA)),
                                buildPaymentDetailRow(
                                  'package_price_title'
                                      .tr, // Replaced Farsi text
                                  "${NumberFormat('#,###,###').format(bloc.selectedItem!.price)} ${'rial'.tr}", // Replaced Farsi text
                                ),
                                Divider(color: Color(0xFFD1D5DA)),
                                buildPaymentDetailRow(
                                  'package_discount_title'.tr,
                                  bloc.selectedItem?.discount == null
                                      ? "0 ${'rial'.tr}"
                                      : "${NumberFormat('#,###,###').format(bloc.selectedItem!.price! - bloc.selectedItem!.discount!)} ${'rial'.tr}", // Replaced Farsi text
                                ),
                                Divider(color: Color(0xFFD1D5DA)),
                                buildPaymentDetailRow(
                                    'final_payment_title'
                                        .tr, // Replaced Farsi text
                                    bloc.selectedItem!.discount != null
                                        ? "${NumberFormat('#,###,###').format(bloc.selectedItem!.discount)} ${'rial'.tr}"
                                        : "${NumberFormat('#,###,###').format(bloc.selectedItem!.price)} ${'rial'.tr}"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Register Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: OutlinedButton(
                            onPressed: bloc.submitSubscribe,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF9E3840),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                            ),
                            child: Center(
                              child: bloc.adSubscribeState.isLoading
                                  ? const MyLoader()
                                  : Text(
                                      'submit'.tr,
                                      style: TextStyle(
                                        fontFamily: 'IRANSansXFaNum',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget buildPaymentDetailRow(String titleKey, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleKey.tr, // Use localization key
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF696F82),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF0C0D0F),
          ),
        ),
      ],
    );
  }
}

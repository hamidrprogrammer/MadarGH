import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/viewModel/user/InformationViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/ProfileViewModel.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ProfileViewModel(AppState.idle),
      builder: (blocU, state) {
        return CubitProvider(
          create: (context) => InformationViewModel(AppState.idle),
          builder: (bloc, state) {
            return FutureBuilder(
              future: bloc.fetchgetUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: MyLoaderBig(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}' ,style: TextStyle(fontFamily: 'IRANSansXFaNum',),));
                } else {
                  return Scaffold(
                    backgroundColor: Color(0xFFF8F8FC),
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
                              'my_payments'.tr, // Localized key
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
                    body: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: bloc.infoUser?.orders.length ?? 5,
                              itemBuilder: (context, index) {
                                final subscription =
                                    bloc.infoUser!.orders[index];

                                return Column(children: [
                                  TransactionItem(
                                      name:
                                          'invoice_number'.tr, // Localized key
                                      subscription: subscription.orderNumber),
                                  TransactionItem(
                                      name: 'amount'.tr, // Localized key
                                      subscription: subscription
                                          .totalPriceWithDiscount
                                          .toString()),
                                  TransactionItem(
                                      name: 'transaction_date'
                                          .tr, // Localized key
                                      subscription:
                                          subscription.paymentPersianDate),
                                  // Container(
                                  //   width: double.infinity,
                                  //   child: OutlinedButton(
                                  //     style: OutlinedButton.styleFrom(
                                  //       side: BorderSide(
                                  //           color: Color(0xFF9E3840)),
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: 8, horizontal: 16),
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius:
                                  //             BorderRadius.circular(8),
                                  //       ),
                                  //     ),
                                  //     onPressed: () {
                                  //       // Handle view invoice button press
                                  //     },
                                  //     child: Text(
                                  //       'view_invoice'.tr, // Localized key
                                  //       style: TextStyle(
                                  //         fontFamily: 'IRANSansXFaNum',
                                  //         fontWeight: FontWeight.w600,
                                  //         fontSize: 14,
                                  //         color: Color(0xFF9E3840),
                                  //         height: 1.5, // Line height
                                  //       ),
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   ),
                                  // ),
                                  Divider()
                                ]);
                              },
                            ),
                          ),
                          SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String subscription; // Adjust the type based on your data model
  final String name; // Adjust the type based on your data model

  const TransactionItem(
      {Key? key, required this.name, required this.subscription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'IRANSansXFaNum',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xFF353842),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Text(
              subscription, // Replace with the actual date property
              style: TextStyle(
                fontFamily: 'IRANSansXFaNum',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF353842),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

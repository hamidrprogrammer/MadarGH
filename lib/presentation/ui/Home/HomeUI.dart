import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/Notification/MyNotification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/apiRoute/BaseUrls.dart';
import 'package:my_ios_app/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:my_ios_app/presentation/ui/Home/HomeSliderUi.dart';
import 'package:my_ios_app/presentation/ui/Home/PackagesGridView.dart';
import 'package:my_ios_app/presentation/ui/app/home_intro_ui.dart';
import 'package:my_ios_app/presentation/ui/calnedar/default_calendar_ui.dart';
import 'package:my_ios_app/presentation/ui/category/CategoriesHorizontalListUi.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakLogo.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/home/HomeViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/main/MainViewModel.dart';
import 'package:my_ios_app/useCase/home/PackagesViewModel.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:my_ios_app/useCase/subscribe/GetRemainingDayUseCase.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => HomeViewModel(AppState.idle),
      builder: (bloc, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('mamak_plan'.tr,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const DefaultCalendarUi(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 2,
                child: const HomeSliderUi(),
              ),
              4.dp,
              SizedBox(
                height: (MediaQuery.of(context).size.width / 4) + 40,
                width: MediaQuery.of(context).size.width,
                child: const CategoriesHorizontalListUi(),
              ),
              const Divider(),
              CubitProvider(
                create: (context) => PackagesViewModel(AppState.idle),
                builder: (bloc, state) {
                  return ConditionalUI<List<SubscribeItem>>(
                    skeleton: Container(
                      margin: 8.dpe,
                      padding: 8.dpe,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: 8.bRadius,
                      ),
                    ),
                    state: bloc.packagesState,
                    onSuccess: (packages) => PackagesGridView(
                      packages: packages,
                      childPackage: bloc.childPackages,
                    ),
                  );
                },
              ),
              8.dpv,
              Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const SizedBox(
                  height: 300,
                  child: HomeIntroUi(),
                ),
              ),
              4.dpv,
              InkWell(
                onTap: () {
                  _launchUrl('${BaseUrls.storagePath}/RoadMap.pdf');
                },
                child: Container(
                  margin: 8.dpe,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            'download_mamak_plan'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                        8.dph,
                        const Expanded(child: MamakLogo()),
                      ],
                    ),
                  ),
                ),
              ),
              4.dpv,
              Padding(
                padding: 8.0.dpeh,
                child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<MainViewModel>()
                          .onIndexChange()
                          .call(HomeNavigationEnum.Subscription.value);
                    },
                    child: Text('subscribe_buy'.tr)),
              ),
              50.dpv
            ],
          ),
        );
      },
    );
  }
}

Future<void> _launchUrl(String url) async {
  // if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
  //   throw Exception('Could not launch $url');
  // }
}

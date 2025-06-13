import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/update/UpdateViewModel.dart';
// import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => UpdateViewModel(AppState.idle),
      builder: (bloc, state) {
        return Padding(
            padding: const EdgeInsets.all(8), child: WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            insetPadding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child:Text(
                    'update_msg'.tr,
                    style: context.textTheme.bodySmall,
                  ) ,)
                  ,
                  20.dpv,
                  ElevatedButton(
                      onPressed: () {
                        _launchUrl(link);
                      },
                      child: Text('update'.tr,style: TextStyle(color: Colors.white),)),
                  20.dpv,
                ],
              ),
            ),
          ),
        ));
      },
    );
  }

  Future<bool> _launchUrl(String link) async {
    return false;
  }
}

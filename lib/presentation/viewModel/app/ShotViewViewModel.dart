import 'dart:typed_data';

import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

class ShotViewerViewModel extends BaseViewModel{
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  Uint8List? bytes;

  ShotViewerViewModel(super.initialState){
    getExtra();
  }

  void getExtra(){
    var data = _navigationServiceImpl.getArgs();
    if(data != null && data is Uint8List){
      bytes = data;
      refresh();
    }
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

}
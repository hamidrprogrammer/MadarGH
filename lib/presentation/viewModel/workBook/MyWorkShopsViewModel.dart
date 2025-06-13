import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/child/GetWorkShopsOfChildUserUseCase.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class MyWorkShopsViewModel extends BaseViewModel
    implements MyNotificationListener {
  final MyNotification _notification = GetIt.I.get();
  WorkBookParamsModel model = WorkBookParamsModel();

  ChildsItem? selectedChild;
  Future<ChildsItem?> getChildItem() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = "prefs.getString('child_item')";

    if (jsonString != null) {
      List<ChildsItem> items = childsItemFromJson(jsonString);
      return items.isNotEmpty
          ? items.first
          : null; // Return the first item or null if the list is empty
    } else {
      return null; // Return null if no data is found
    }
  }

  MyWorkShopsViewModel(super.initialState, {this.selectedChild}) {
    getChildItem().then((child) {
      if (child != null) {
        if(child.id != null){
                  getWorkShopsByChildId(child.id.toString());

        }
      } else {
        print('No child item found.');
      }
    }).catchError((error) {
      print('Error retrieving child item: $error');
    });
    _notification.subscribeListener(this);
  }

  getWorkShopsByChildId(String childId) {
    if (!state.isLoading) {
      GetWorkShopsOfChildUserUseCase()
          .invoke(mainFlow, data: childId.toString());
    }
  }

  @override
  void onReceiveData(data) {
    print('data has been receive and is $data');
    getChildItem().then((child) {
      if (child != null) {
         if(child.id != null){
                  getWorkShopsByChildId(child.id.toString());

         }
      } else {
        if (data != null) {
          if (data is String) {
            getWorkShopsByChildId(data);
          }
          if (data is ChildsItem) {
            selectedChild = data;
            model.userChildId = (data).id.toString();
            getWorkShopsByChildId((data).id.toString());
          }
          if (data is bool && data == true) {
            getWorkShopsByChildId(model.userChildId);
          }
        }
      }
    }).catchError((error) {
      print('Error retrieving child item: $error');
    });
  }

  @override
  String tag() => 'MyWorkShopsViewModel';

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }

// gotoDetailView(num? id) {
//   if (id != null) {
//     model.workShopId = id.toString();
//     _navigationServiceImpl.navigateTo(AppRoute.workBookDetail, model);
//   }
// }
}

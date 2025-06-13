import 'package:core/Notification/MyNotification.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/child/GetChildsOfUserUseCase.dart';

class ChildSegmentViewModel extends BaseViewModel{
  ChildSegmentViewModel(super.initialState);

  AppState uiState = AppState.idle;

  final MyNotification _notification = GetIt.I.get();
  ChildsItem? selectedChild;


  void getChildOfUser() {
    GetChildOfUserUseCase().invoke(MyFlow(flow: (appState){
      if(appState.isSuccess){
        if(appState.getData is List<ChildsItem>){
          List<ChildsItem> child = appState.getData;
          if(child.isNotEmpty){
            selectedChild = child.first;
            _notification.publish('NewHomeViewModel', selectedChild);
          }

        }
      }
      uiState = appState;
      refresh();
    }));
  }
  void onChangeSelectedChild(ChildsItem childsItem){
    selectedChild = childsItem;
    _notification.publish('MyWorkShopsViewModel', selectedChild);
    _notification.publish('GetParticipatedWorkShopsOfChildUserViewModel', selectedChild);
    _notification.publish('EditChildDataViewModel', selectedChild);
    refresh();
  }

}
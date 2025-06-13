import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

class UpdateViewModel extends BaseViewModel{

  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();


  UpdateViewModel(super.initialState);



}
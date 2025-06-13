import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:provider/provider.dart';


class CubitProvider<T extends BaseViewModel> extends StatelessWidget {
  const CubitProvider({Key? key, required this.create, required this.builder})
      : super(key: key);
  final Create<T> create;
  final Widget Function(T bloc, AppState state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: create,
      child: BlocBuilder<T, AppState>(
        builder: (context, state) => builder.call(context.read<T>(), state),
      ),
    );
  }
}

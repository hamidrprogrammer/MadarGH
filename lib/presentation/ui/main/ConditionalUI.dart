import 'package:core/utils/imageLoader/ImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:shimmer/shimmer.dart';


class ConditionalUI<T> extends StatelessWidget {
  const ConditionalUI({
    Key? key,
    required this.state,
    required this.onSuccess,
    this.skeleton = const SizedBox(height: 200,child: Center(child: MyLoader()),),
    this.showError = true,
  }) : super(key: key);
  final bool showError;
  final AppState state;
  final Widget Function(T) onSuccess;
  final Widget skeleton;

  @override
  Widget build(BuildContext context) {
    switch (state.runtimeType) {
      case Success:
        return onSuccess.call(state.getData as T);
      case Loading:
        return skeleton;
      case Error:
        return showError
            ? MyErrorWidget(message: state.getErrorModel?.message ?? '')
            : const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}

class BaseSkeleton extends StatelessWidget {
  const BaseSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 15,
        ),
      ),
    );
  }
}

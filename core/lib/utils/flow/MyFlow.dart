class MyFlow<T> {
  const MyFlow({required this.flow});

  final Function(T) flow;

  void emit(T appState) {
    flow.call(appState);
  }

}

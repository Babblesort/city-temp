import 'package:flutter_bloc/flutter_bloc.dart';

class DiagnosticsObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }
}

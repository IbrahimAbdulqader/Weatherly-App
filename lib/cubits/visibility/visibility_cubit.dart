import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/visibility/visibility_states.dart';

class VisibilityCubit extends Cubit<VisibilityState> {
  VisibilityCubit() : super(VisibleState());

  void hide() => emit(InvisibleState());
  void show() => emit(VisibleState());
}

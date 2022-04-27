import 'package:movies_app/actions/index.dart';
import 'package:movies_app/models/index.dart';
import 'package:movies_app/reducer/auth_reducer.dart';
import 'package:movies_app/reducer/movie_reducer.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is! AppAction) {
    throw ArgumentError('All actions should implement AppAction.');
  }

  final AppState newState = _reducer(state, action);
  return newState;
}

Reducer<AppState> _reducer = combineReducers<AppState>(<Reducer<AppState>>[
  authReducer,
  movieReducer,
]);

import 'package:movies_app/data/auth_api.dart';
import 'package:movies_app/data/movie_api.dart';
import 'package:movies_app/epics/auth_epic.dart';
import 'package:movies_app/epics/movie_epic.dart';
import 'package:movies_app/models/index.dart';
import 'package:redux_epics/redux_epics.dart';

class AppEpic {
  AppEpic(this._movieApi, this._authApi);

  final MovieApi _movieApi;
  final AuthApi _authApi;

  Epic<AppState> getEpics() {
    return combineEpics(<Epic<AppState>>[
      AuthEpic(_authApi).getEpics(),
      MovieEpic(_movieApi).getEpics(),
    ]);
  }
}

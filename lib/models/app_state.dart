import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/models/app_user.dart';
import 'package:movies_app/models/movie.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(<Movie>[]) List<Movie> movies,
    @Default(true) bool isLoading,
    @Default(1) int pageNumber,
    AppUser? user,
  }) = AppState$;
}

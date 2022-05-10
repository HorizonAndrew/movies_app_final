part of 'index.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(<Movie>[]) List<Movie> movies,
    @Default(true) bool isLoading,
    @Default(1) int pageNumber,
    AppUser? user,
    @Default(<Comment>[]) List<Comment> comments,
    int? selectedMovieId,
    @Default(<String, AppUser>{}) Map<String /*uid*/, AppUser> users,
    @Default('') String genre,
  }) = AppState$;
}

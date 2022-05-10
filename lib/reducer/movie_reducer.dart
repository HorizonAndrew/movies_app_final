import 'package:flutter/foundation.dart';
import 'package:movies_app/actions/index.dart';
import 'package:movies_app/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> movieReducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, GetMovies>(_getMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, OnCommentsEvent>(_onCommentsEvent),
  TypedReducer<AppState, SetSelectedMovieId>(_setSelectedMovieId),
]);

AppState _getMovies(AppState state, GetMovies action) {
  if (kDebugMode) {
    print('state.genre: ${state.genre}');
  }
  return state.copyWith(isLoading: true);
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  if (kDebugMode) {
    print('state.genre: ${state.genre}');
  }
  return state.copyWith(
    isLoading: false,
    pageNumber: state.pageNumber + 1,
    genre: state.genre,
    movies: <Movie>[...state.movies, ...action.movies],
  );
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.copyWith(isLoading: false);
}

AppState _onCommentsEvent(AppState state, OnCommentsEvent action) {
  return state.copyWith(comments: <Comment>{...state.comments, ...action.comments}.toList());
}

AppState _setSelectedMovieId(AppState state, SetSelectedMovieId action) {
  return state.copyWith(selectedMovieId: action.movieId);
}

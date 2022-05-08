import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_app/actions/index.dart';
import 'package:movies_app/containers/home_page_container.dart';
import 'package:movies_app/containers/movies_container.dart';
import 'package:movies_app/containers/user_container.dart';
import 'package:movies_app/models/index.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    StoreProvider.of<AppState>(context, listen: false).dispatch(GetMovies(_onResult));
    _controller.addListener(_onScroll);
  }

  void _onResult(AppAction action) {
    if (action is GetMoviesSuccessful) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Page loaded')));
    } else if (action is GetMoviesError) {
      final Object error = action.error;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error happened $error')));
    }
  }

  void _onScroll() {
    final double extent = _controller.position.maxScrollExtent;
    final double offset = _controller.offset;
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    if (offset >= extent - (MediaQuery.of(context).size.height * 2) && !store.state.isLoading) {
      // if (offset >= extent - 300 && !store.state.isLoading) {
      StoreProvider.of<AppState>(context).dispatch(GetMovies(_onResult));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomePageContainer(
      builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Movies ${state.pageNumber - 1}'),
            leading: IconButton(
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(const Logout());
              },
              icon: const Icon(Icons.power_settings_new),
            ),
          ),
          body: MoviesContainer(
            builder: (BuildContext context, List<Movie> movies) {
              if (state.isLoading && movies.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return UserContainer(
                builder: (BuildContext context, AppUser? user) {
                  return ListView.builder(
                    controller: _controller,
                    itemCount: movies.length,
                    //physics: const ClampingScrollPhysics(),
                    //physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final Movie movie = movies[index];

                      final bool isFavorite = user!.favoriteMovies.contains(movie.id);

                      return GestureDetector(
                        onTap: () {
                          StoreProvider.of<AppState>(context).dispatch(SetSelectedMovieId(movie.id));
                          Navigator.pushNamed(context, '/comments');
                        },
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                SizedBox(
                                  height: 350,
                                  child: Image.network(movie.poster),
                                ),
                                IconButton(
                                  color: Colors.red,
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                  ),
                                  onPressed: () {
                                    StoreProvider.of<AppState>(context).dispatch(
                                      UpdateFavorites(
                                        movie.id,
                                        add: !isFavorite,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Text(movie.title),
                            Text('${movie.year}'),
                            Text(movie.genres.join(', ')),
                            Text('${movie.rating}')
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

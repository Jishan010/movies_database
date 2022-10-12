import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/src/di/locator.dart';
import 'package:movies_database/src/screens/search_movie.dart';
import '../blocs/movies/movies_event.dart';
import '../blocs/movies/movies_list_bloc.dart';
import '../blocs/movies/movies_state.dart';
import '../resources/remote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'fav_movies.dart';
import 'movie_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesListBloc(repository: getIt<RemoteRepository>())
        ..add(FetchMovies()),
      child: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: SafeArea(
          child: Scaffold(
            body: _selectedIndex == 0
                ? NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                            foregroundColor: Colors.white,
                            titleTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor: Colors.black26,
                            actions: [
                              IconButton(
                                  iconSize: 30,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchMovie()));
                                  },
                                  icon: const Icon(Icons.search))
                            ],
                            title: const Text(
                              'Watch Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            floating: true,
                            pinned: true,
                            bottom: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // Creates border
                                  color: Colors.green),
                              isScrollable: true,
                              dragStartBehavior: DragStartBehavior.start,
                              physics: const BouncingScrollPhysics(),
                              tabs: [
                                Tab(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text('Popular'),
                                  ),
                                ),
                                Tab(
                                    child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text('Top Rated'),
                                )),
                                Tab(
                                    child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text('Upcoming'),
                                )),
                                Tab(
                                    child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text('Now Playing'),
                                )),
                              ],
                            )),
                      ];
                    },
                    body: BlocBuilder<MoviesListBloc, MoviesState>(
                      builder: (context, state) {
                        if (state is MoviesLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is MoviesLoadedState) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.black87,
                            ),
                            child: MovieListScreen(
                              listOfmovies: state.listOfmovies,
                            ),
                          );
                        } else if (state is MoviesErrorState) {
                          return const Center(
                              child: Text('Error loading movies'));
                        } else {
                          return const Center(
                              child: Text('Error loading movies'));
                        }
                      },
                    ),
                  )
                : const FavMovies(),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.green,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/UI/views/login/login.dart';
import 'package:video_player/UI/views/movie_page/movie_detail.dart';
import 'package:video_player/controllers/movie_list_page_controller.dart';
import 'package:video_player/models/movies_list_model.dart';
import 'package:video_player/services/API/firebase_api.dart';
import 'package:video_player/services/API/movie_api.dart';

class MoviesListPage extends StatefulWidget {
  MoviesListPage({super.key});

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  MovieListPageController controller = MovieListPageController();

  @override
  void initState() {
    super.initState();
    // getMoviesList().then((value) {
    //   if (value is MoviesListModel) {
    //     controller.moviesList = value;
    //     setState(() {});
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/tmdb_logo.png",
          width: 100,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              },
              icon: const Row(
                children: [
                  Text("Logout"),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.logout),
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 25),
              Text('User: ${FirebaseAuth.instance.currentUser?.email}'),
              const SizedBox(height: 15),
              FutureBuilder(
                future: getMoviesList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data is MoviesListModel) {
                    if (snapshot.data != null) {
                      controller.moviesList = snapshot.data!;
                    }
                    return Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        for (int i = 0;
                            i < controller.moviesList.results!.length;
                            i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                        movieId: controller
                                                .moviesList.results?[i].id ??
                                            -1),
                                  ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(7),
                              child: Image.network(
                                "https://www.themoviedb.org/t/p/w220_and_h330_face${controller.moviesList.results?[i].posterPath}",
                                width: width * 0.42,
                              ),
                            ),
                          ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Something Went Wrong",
                        style: TextStyle(fontSize: 24),
                      ),
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 100),
                      child: const CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/UI/views/movie_page/video_player.dart';
import 'package:video_player/controllers/movie_details_controller.dart';
import 'package:video_player/models/movie_details_model.dart';
import 'package:video_player/models/video_details_model.dart';
import 'package:video_player/services/API/movie_api.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key, required this.movieId});
  int movieId;
  bool loader = false;

  MovieDetailController controller = MovieDetailController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getMovieDetails(movieId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data is MovieDetailsModel) {
                if (snapshot.data != null) {
                  controller.movieDetails = snapshot.data!;
                }
                // status code 200
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(7),
                          child: Image.network(
                            "https://www.themoviedb.org/t/p/w220_and_h330_face${controller.movieDetails.posterPath}",
                            height: 350,
                          ),
                        ),
                        Positioned(
                          top: 140,
                          left: width * 0.365,
                          child: GestureDetector(
                            onTap: () async {
                              VideoDetailsModel? video = await getVideoDetails(
                                  controller.movieDetails.id ?? -1);
                              String key = "";
                              if (video != null) {
                                video.results?.forEach((element) {
                                  if (element.type == "Trailer") {
                                    key = element.key ?? "";
                                  }
                                });
                                if (key != "")
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoPlayer(
                                          videoKey: key,
                                        ),
                                      ));
                              }
                            },
                            child: const CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "${controller.movieDetails.originalTitle}",
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 246, 106, 153)),
                            ),
                            StatefulBuilder(
                              builder: (context, _setState) => SizedBox(
                                width: 140,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    // if (!loader) {
                                    //   loader = true;
                                    //   _setState(() {});
                                    //   // await function();
                                    //   loader = false;
                                    //   _setState(() {});
                                    // }
                                    VideoDetailsModel? video =
                                        await getVideoDetails(
                                            controller.movieDetails.id ?? -1);
                                    String key = "";
                                    if (video != null) {
                                      video.results?.forEach((element) {
                                        if (element.type == "Trailer") {
                                          key = element.key ?? "";
                                        }
                                      });
                                      if (key != "")
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VideoPlayer(
                                                videoKey: key,
                                              ),
                                            ));
                                    }
                                  },
                                  child: loader
                                      ? const SizedBox(
                                          width: 25,
                                          height: 25,
                                          child:
                                              const CircularProgressIndicator(),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Play",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 246, 106, 153)),
                                            ),
                                            Icon(
                                              Icons.play_arrow,
                                              size: 35,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Overview :",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 246, 106, 153)),
                      ),
                      Text("${controller.movieDetails.overview}"),
                      const SizedBox(height: 10),
                      const Text(
                        "Popularity :",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 246, 106, 153)),
                      ),
                      Text("${controller.movieDetails.popularity}"),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Something Went Wrong",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: height / 3),
                  child: const CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

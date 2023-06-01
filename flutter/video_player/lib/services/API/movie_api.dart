import "package:http/http.dart" as http;
import "package:video_player/models/movie_details_model.dart";
import "dart:async";
import "dart:convert";

import "package:video_player/models/movies_list_model.dart";
import "package:video_player/models/video_details_model.dart";

Future<MoviesListModel?> getMoviesList() async {
  try {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a608dd06f460b5f250f532b3ec9beba0'));
    if (response.statusCode == 200) {
      MoviesListModel moviesList =
          MoviesListModel.fromJson(json.decode(response.body.toString()));
      return moviesList;
    }
  } catch (error) {
    print(error.toString());
  }
  return null;
}

// Future<MoviesListModel?> getMoviePoster(String path) async {
//   try {
//     final response = await http.get(
//         Uri.parse('https://www.themoviedb.org/t/p/w220_and_h330_face/$path'));
//     if (response.statusCode == 200) {
//       MoviesListModel moviesList =
//           MoviesListModel.fromJson(json.decode(response.body.toString()));
//       return moviesList;
//     }
//   } catch (error) {
//     print(error.toString());
//   }
//   return null;
// }

Future<MovieDetailsModel?> getMovieDetails(int id) async {
  try {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=a608dd06f460b5f250f532b3ec9beba0'));
    if (response.statusCode == 200) {
      MovieDetailsModel movieDetails =
          MovieDetailsModel.fromJson(json.decode(response.body.toString()));
      return movieDetails;
    }
  } catch (error) {
    print(error.toString());
  }
  return null;
}

Future<VideoDetailsModel?> getVideoDetails(int id) async {
  try {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=a608dd06f460b5f250f532b3ec9beba0'));
    if (response.statusCode == 200) {
      VideoDetailsModel videoDetails =
          VideoDetailsModel.fromJson(json.decode(response.body.toString()));
      return videoDetails;
    }
  } catch (error) {
    print(error.toString());
  }
  return null;
}

getMovieTrailer(String key) async {
  try {
    final response =
        await http.get(Uri.parse('https://www.youtube.com/watch?v=$key'));
    if (response.statusCode == 200) {
      // VideoDetailsModel videoDetails =
      //     VideoDetailsModel.fromJson(json.decode(response.body.toString()));
      // return videoDetails;
    }
  } catch (error) {
    print(error.toString());
  }
  return null;
}

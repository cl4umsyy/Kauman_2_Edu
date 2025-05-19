import 'package:get/get.dart';

class ProfileController extends GetxController {
  final username = 'Claumsyy'.obs;
  final bio = 'alright alright alright'.obs;
  
  // Movies data
  final favoriteMovies = [
    {
      'title': 'Apocalypse Now',
      'posterUrl': 'assets/1.png',
    },
    {
      'title': 'GoodFellas',
      'posterUrl': 'assets/2.png',
    },
    {
      'title': 'Oldboy',
      'posterUrl': 'assets/3.png',
    },
    {
      'title': 'City of God',
      'posterUrl': 'assets/4.png',
    },
  ].obs;
  
  final recentActivity = [
    {
      'title': 'Mickey 17',
      'posterUrl': 'assets/5.png',
      'rating': 4.5,
      'hasNotes': false,
    },
    {
      'title': '10 Things I Hate About You',
      'posterUrl': 'assets/6.png',
      'rating': 4.0,
      'hasNotes': true,
    },
    {
      'title': 'La Haine',
      'posterUrl': 'assets/7.png',
      'rating': 5.0,
      'hasNotes': true,
    },
    {
      'title': 'Nosferatu',
      'posterUrl': 'assets/8.png',
      'rating': 3.5,
      'hasNotes': true,
    },
  ].obs;
  
  // Placeholder for ratings distribution data
  final ratingsDistribution = [2, 8, 15, 25, 40].obs;



}
import 'package:flutter/material.dart';
import 'package:solar_system/helper/shr_helper.dart';
import 'package:solar_system/helper/solar_helper.dart';
import 'package:solar_system/modal/solar_modal.dart';

class HomeProvider extends ChangeNotifier {
  List<PlanetModel> planetList = [

  ];
  int selectedIndex = 0;
  List<String> favPlanets = [];
  SolarHelper helper = SolarHelper();
  ShrHelper shrHelper = ShrHelper();

  HomeProvider() {
    getPlanet();
    loadFav();
  }



  void planetIndex(int index) {
    if (index >= 0 && index < planetList.length) {
      selectedIndex = index;
      notifyListeners();
    }
  }

  Future<void> getPlanet() async {

    planetList = await helper.jsonPlanets();
    notifyListeners();
  }

  Future<void> loadFav() async {
    favPlanets = await shrHelper.getFavPlanets();
    notifyListeners();
  }

  Future<void> allFav(String planetName) async {
    if (favPlanets.contains(planetName)) {
      favPlanets.remove(planetName);
    } else {
      favPlanets.add(planetName);
    }

    await shrHelper.setFavPlanets(favPlanets);
    notifyListeners();
  }

  bool isFavourite(String planetName) {
    return favPlanets.contains(planetName);
  }
  List images = [
    'assets/images/Earth.png',
    'assets/images/Jupiter.png',
    'assets/images/Mars.png',
    'assets/images/Mercury.png',
    'assets/images/Neptune.png',
    'assets/images/Saturn.png',
    'assets/images/Sun.png',
    'assets/images/Uranus.png',
    'assets/images/Venus.png',
  ];
  }

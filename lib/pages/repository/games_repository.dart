
import 'package:gamelovers/models/game.dart';
class GamesRepository {
  static List<Game> items = [
      Game(
          name: "Hollow Knight",
          release: 2017,
          description:
              "Hollow Knight is a 2017 action-adventure game developed and published by Team Cherry, and was released for Microsoft Windows, macOS, and Linux in 2017, and later for the Nintendo Switch, PlayStation 4, and Xbox One in 2018.",
          genre: ["Action", "Adventure", "Indie"],
          image: "assets/hollow_knight.png"),
      Game(
          name: "Gris",
          release: 2018,
          description:
              "Gris is a 2018 platform-adventure game by Spanish indie developer Nomada Studio and published by Devolver Digital. The game was released for Nintendo Switch, macOS, and Microsoft Windows in December 2018, for iOS in August 2019, for PlayStation 4 in November 2019, and for Android in April 2020.",
          genre: ["Adventure", "Indie"],
          image: "assets/gris.png"),
      Game(
          name: "Celeste",
          release: 2018,
          description:
              "Celeste is a platforming video game by Canadian video game developers Maddy Makes Games, which was released in January 2018. The game was originally developed as a prototype in four days at a game jam, and later expanded into a full release.",
          genre: ["Platform", "Indie"],
          image: "assets/celeste.png"),
      Game(
          name: "Outer Wilds",
          release: 2019,
          description:
              "Outer Wilds is a 2019 action-adventure game developed by Mobius Digital and published by Annapurna Interactive for Microsoft Windows, Xbox One, and PlayStation 4. The game features the player character exploring a solar system stuck in a 22-minute time loop, which ends as the sun goes supernova.",
          genre: ["Action", "Adventure", "Indie"],
          image: "assets/outer_wilds.jpg"),
    ];
}
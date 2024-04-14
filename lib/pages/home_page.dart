import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gamelovers/models/game.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 late MatchEngine _matchEngine;
 List<SwipeItem> _swipeItems = <SwipeItem>[];
 int currentPicture = 0;
 int numberPictures = 2;

  List<Game> items = [
      Game(
        name: "Hollow Knight", 
        release: 2017, 
        description: "Hollow Knight is a 2017 action-adventure game developed and published by Team Cherry, and was released for Microsoft Windows, macOS, and Linux in 2017, and later for the Nintendo Switch, PlayStation 4, and Xbox One in 2018.", 
        genre: ["Action", "Adventure", "Indie"], 
        image: "assets/hollow_knight.png"
        ),
      Game(
        name: "Gris", 
        release: 2018, 
        description: "Gris is a 2018 platform-adventure game by Spanish indie developer Nomada Studio and published by Devolver Digital. The game was released for Nintendo Switch, macOS, and Microsoft Windows in December 2018, for iOS in August 2019, for PlayStation 4 in November 2019, and for Android in April 2020.",
        genre: ["Adventure", "Indie"], 
        image: "assets/gris.png"
        ),
      Game(
        name: "Celeste", 
        release: 2018, 
        description: "Celeste is a platforming video game by Canadian video game developers Maddy Makes Games, which was released in January 2018. The game was originally developed as a prototype in four days at a game jam, and later expanded into a full release.",
        genre: ["Platform", "Indie"], 
        image: "assets/celeste.png"
        ),
      Game(
        name: "Outer Wilds", 
        release: 2019, 
        description: "Outer Wilds is a 2019 action-adventure game developed by Mobius Digital and published by Annapurna Interactive for Microsoft Windows, Xbox One, and PlayStation 4. The game features the player character exploring a solar system stuck in a 22-minute time loop, which ends as the sun goes supernova.", 
        genre: ["Action", "Adventure", "Indie"], 
        image: "assets/outer_wilds.jpg"
        ),
  ];

  @override
  void initState() {
    for (int i = 0; i < items.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Game(name: items[i].name, release: items[i].release, description: items[i].description, genre: items[i].genre, image: items[i].image),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Curtiu ${items[i].name}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Você não curtiu ${items[i].name}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,  
            children: [
              const Icon(
                Icons.videogame_asset_outlined,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                'Gamelovers',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.purple.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )
                ),
              ),
            ]
          ),
        )
      ),
      body: SwipeCards(
        matchEngine: _matchEngine, 
        onStackFinished: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sem mais jogos para curtir!'), 
            duration: Duration(milliseconds: 500),
          )
          );
        }, 
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Hero(
                tag: "imageTag$i", 
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(items[i].image),
                        )
                      )
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            Colors.black,
                            Colors.transparent
                          ]
                        )
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (currentPicture != 0) {
                                setState(() {
                                  currentPicture = currentPicture - 1;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (currentPicture < (numberPictures - 1)) {
                                setState(() {
                                  currentPicture = currentPicture + 1;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 6,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: numberPictures,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int i) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  width: ((MediaQuery.of(context).size.width - (20 + ((numberPictures + 1) * 8))) / numberPictures),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.5
                                    ),
                                    color: currentPicture == i ? Colors.white : Colors.grey
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      items[i].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {

                                  }, 
                                  icon: const Icon(Icons.info, color: Colors.white,),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _matchEngine.currentItem?.nope();
                                  },
                                  splashColor: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.redAccent,
                                      )
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Image(image: AssetImage("assets/dislike.png")),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _matchEngine.currentItem?.like();
                                  },
                                  splashColor: Colors.lightGreenAccent,
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.lightGreenAccent,
                                      )
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Image(image: AssetImage("assets/undertale_heart.png")),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ), 
            ),
          );
        },
        likeTag: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green)
          ),
          child: const Text('Like'),
        ),
        nopeTag: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red)
          ),
          child: const Text('Nope'),
        ),        
      ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
       items: const [
        BottomNavigationBarItem(icon: Icon(Icons.videogame_asset_sharp,), label: 'Games',),
        BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.white,), label: 'Profile',)
      ],
    ),
   ); 
  }
}

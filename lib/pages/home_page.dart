import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  
 int currentPicture = 0;
 int numberPictures = 2;

  List<SwipeItem> items = [
    SwipeItem(
      content: "Hollow Knight",
      likeAction: () {
        print("Like");
      },
      nopeAction: () {
        print("Nope");
      },
      onSlideUpdate: (SlideRegion? region) async {
        print("Region $region");
      }
    ),
    SwipeItem(
      content: "The Legend of Zelda: Ocarina of Time",
      likeAction: () {
        print("Like");
      },
      nopeAction: () {
        print("Nope");
      },
      onSlideUpdate: (SlideRegion? region) async {
        print("Region $region");
      }
    ),
    SwipeItem(
      content: "Gris",
      likeAction: () {
        print("Like");
      },
      nopeAction: () {
        print("Nope");
      },
      onSlideUpdate: (SlideRegion? region) async {
        print("Region $region");
      }
    ),
  ];

  @override
  void initState () {
    _matchEngine = MatchEngine(swipeItems: items);
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
            content: Text('Stack Finished'), 
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
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/hollow_knight.png"),
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
                                      items[i].content,
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
                                        child: Icon(Icons.not_interested, color: Color.fromARGB(255, 255, 0, 0),),
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
                                        child: Icon(Icons.heart_broken_rounded, color: Colors.purple,),
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

import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'content.dart';

class SwipeCardsScreen extends StatefulWidget {
  const SwipeCardsScreen({Key? key}) : super(key: key);



  @override
  State<SwipeCardsScreen> createState() => _SwipeCardsState();
}

class _SwipeCardsState extends State<SwipeCardsScreen> {


  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
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
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("ryryery"),
        ),
        backgroundColor: Colors.white,
        body: Padding(padding:EdgeInsets.symmetric(vertical: 60,horizontal: 40),child:
        SwipeCards(
          matchEngine: _matchEngine!,
          itemBuilder: (BuildContext context, int index) {
            return
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _swipeItems[index].content.color,
                  borderRadius: BorderRadius.circular(12),

                ),
                child: Text(
                  _swipeItems[index].content.text,
                  style: TextStyle(fontSize: 100),
                ),
              );
          },
          onStackFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Stack Finished"),
              duration: Duration(milliseconds: 500),
            ));
          },
          itemChanged: (SwipeItem item, int index) {
            print("item: ${item.content.text}, index: $index");
          },
          leftSwipeAllowed: true,
          rightSwipeAllowed: true,
          upSwipeAllowed: true,
          fillSpace: true,
          likeTag: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green)
            ),
            child: Text('Like'),
          ),
          nopeTag: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red)
            ),
            child: Text('Nope'),
          ),
          superLikeTag: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.orange)
            ),
            child: Text('Super Like'),
          ),
        ),));
  }
}

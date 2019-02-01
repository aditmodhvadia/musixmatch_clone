import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clone MusixMatch',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: (){
              print('Back Pressed');
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: Colors.black,
            ),
          ),
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Song Name',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700)),
              ),
              Text(
                'Artist Name',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                textScaleFactor: 0.75,
                textAlign: TextAlign.left,
              )
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: (){
                  print('Queue pressed');
                },
                icon: Icon(
                  Icons.queue_music,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: (){
                  print('More pressed');
                },
                icon: Icon(
                  Icons.more_vert,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: new PlayerBody(),
      ),
    );
  }
}

class repeatShuffle extends StatefulWidget {
  @override
  _repeatShuffleState createState() => _repeatShuffleState();
}

class _repeatShuffleState extends State<repeatShuffle> {
  String repeat = 'Repeat All';
  int count = 0, shuffleCount = 1;
  Color repeatColor = Colors.black;
  Color shuffleColor = Colors.black38;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: InkWell(
            child: Text(repeat,
                style: TextStyle(
                    color: repeatColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400)),
            onTap: () {
              setState(() {
                count = (count + 1) % 3;
                if (count == 0) {
                  repeat = 'Repeat All';
                  repeatColor = Colors.black;
                } else if (count == 1) {
                  repeat = 'Repeat';
                  repeatColor = Colors.black;
                } else {
                  repeat = 'Repeat';
                  repeatColor = Colors.black38;
                }
              });
            },
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: InkWell(
            onTap: () {
              setState(() {
                shuffleCount = (shuffleCount + 1) % 2;
                if (shuffleCount == 0) {
                  shuffleColor = Colors.black;
                } else {
                  shuffleColor = Colors.black38;
                }
              });
            },
            child: Text(
              'Shuffle',
              style: TextStyle(color: shuffleColor, fontSize: 14.0),
            ),
          ),
        )
      ],
    );
  }
}

class PlayerBody extends StatelessWidget {
  const PlayerBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //image

        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2 +50.0,
                    child: Image.asset(
                      'lib/assets/album_art.png',
                      fit: BoxFit.fill,
                      color: Colors.black.withOpacity(0.80),
                      colorBlendMode: BlendMode.darken,
                    )
                )
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(right: 22.0, top: 14.0),
                  child: RaisedButton(
                    color: Colors.white,
                    elevation: 2.0,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () => print('Party button'),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.add_circle, color: Colors.purple, size: 24.0,),
                        Padding(padding: EdgeInsets.only(left: 2.0, right: 2.0)),
                        Text('Party', style: TextStyle(color: Colors.purple, fontSize: 16.0),),
                      ],
                    ),),
                ),
              ],
            ),
          ],
        ),

        //repeat and shuffle
        repeatShuffle(),

        //seekbar
        seekBar(),
        //indicators for song length
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: Row(
            children: <Widget>[
              Text('0:00'),
              Expanded(child: Container()),
              Text('3:50')
            ],
          ),
        ),

        Expanded(child: Container()),

        //Player buttons

        new PlayerButtons()
      ],
    );
  }
}

class seekBar extends StatefulWidget {
  @override
  _seekBarState createState() => _seekBarState();
}

class _seekBarState extends State<seekBar> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Slider(
        value: _value,
        activeColor: Colors.black,
        inactiveColor: Colors.grey.withOpacity(0.50),
        onChanged: (double Value) {
          setState(() {
            _value = Value;
          });
        },
        min: 0.0,
        max: 100.0,
      ),
    );
  }
}

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              onPressed: () => print('Weird Button pressed'),
              icon: Icon(
                Icons.dashboard,
                size: 28.0,
              ),
            ),
          ),
          new Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => print('Back Song pressed'),
              icon: Icon(
                Icons.skip_previous,
                size: 36.0,
              ),
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              print('Play Pressed');
            },
            shape: CircleBorder(),
            elevation: 10.0,
            highlightElevation: 5.0,
            fillColor: Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.play_arrow,
                size: 42.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: () => print('Next Song pressed'),
              icon: Icon(
                Icons.skip_next,
                size: 36.0,
              ),
            ),
          ),
          new Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () => print('Share pressed'),
              icon: Icon(
                Icons.share,
                size: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

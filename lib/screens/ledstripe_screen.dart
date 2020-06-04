import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RGBColor {
  final int r;
  final int g;
  final int b;
  RGBColor({this.r, this.g, this.b});
}

class LedStripeScreen extends StatefulWidget {
  @override
  _LedStripeScreenState createState() => _LedStripeScreenState();
}

class _LedStripeScreenState extends State<LedStripeScreen> {
  List<RGBColor> colors = [];
  RGBColor color;

  final dbRef = FirebaseDatabase.instance.reference().child('ledstripe');

  @override
  void initState() {
    colors.add(new RGBColor(r: 255, g: 0, b: 0));
    colors.add(new RGBColor(r: 255, g: 140, b: 0));
    colors.add(new RGBColor(r: 255, g: 215, b: 0));
    colors.add(new RGBColor(r: 0, g: 255, b: 0));
    colors.add(new RGBColor(r: 173, g: 255, b: 47));
    colors.add(new RGBColor(r: 0, g: 250, b: 154));
    colors.add(new RGBColor(r: 102, g: 205, b: 170));
    colors.add(new RGBColor(r: 0, g: 128, b: 128));
    colors.add(new RGBColor(r: 0, g: 255, b: 255));
    colors.add(new RGBColor(r: 0, g: 191, b: 255));
    colors.add(new RGBColor(r: 0, g: 0, b: 255));
    colors.add(new RGBColor(r: 255, g: 0, b: 255));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snap) {
          if (snap.hasData) {
            return new Container(
              padding: EdgeInsets.only(top: 10.0),
              child: new Column(
                children: [
                  new Container(
                    child: new GridView.count(
                      shrinkWrap: true,
                      mainAxisSpacing: 3.0,
                      crossAxisSpacing: 3.0,
                      crossAxisCount: 3,
                      children: [
                        new GestureDetector(
                          onTap: () => {
                            setState(() {
                              if (snap.data.snapshot.value["power"] == false) {
                                dbRef.child('power').set(true);
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text('The LedStripe enabled'),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              } else {
                                dbRef.child('power').set(false);
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text('The LedStripe disabled'),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              }
                            })
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: (snap.data.snapshot.value["power"]
                                  ? Colors.greenAccent[400]
                                  : Colors.red),
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 2,
                              ),
                            ),
                            child:
                                new Icon(Icons.power_settings_new, size: 32.0),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () => {
                            setState(() {
                              if (snap.data.snapshot.value["brightness"] > 15) {
                                dbRef.child('brightness').set(
                                    snap.data.snapshot.value["brightness"] -
                                        10);
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                          'Set the brghtness to ${snap.data.snapshot.value["brightness"] - 10}'),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                          'The brightness can be at least 15'),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              }
                            })
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 2,
                              ),
                            ),
                            child: new Icon(Icons.brightness_low, size: 32.0),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () => {
                            setState(() {
                              if (snap.data.snapshot.value["brightness"] <
                                  255) {
                                dbRef.child('brightness').set(
                                    snap.data.snapshot.value["brightness"] +
                                        10);
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                          'Set the brghtness to ${snap.data.snapshot.value["brightness"] + 10}'),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    content: new Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: new Text(
                                          'The brightness cant be over 255'),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              }
                            })
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 2,
                              ),
                            ),
                            child: new Icon(Icons.brightness_high, size: 32.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    child: new Flexible(
                      child: new GridView.count(
                        mainAxisSpacing: 3.0,
                        crossAxisSpacing: 3.0,
                        crossAxisCount: 3,
                        children: List.generate(
                          12,
                          (index) {
                            return new GestureDetector(
                              onTap: () => {
                                setState(() {
                                  color = this.colors[index];
                                  dbRef.child('color').child('r').set(color.r);
                                  dbRef.child('color').child('g').set(color.g);
                                  dbRef.child('color').child('b').set(color.b);
                                  Scaffold.of(context).showSnackBar(
                                    new SnackBar(
                                      content: new Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: new Text(
                                            'The color was successfully changed'),
                                      ),
                                      backgroundColor: Color.fromRGBO(
                                          this.colors[index].r,
                                          this.colors[index].g,
                                          this.colors[index].b,
                                          1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                        side: BorderSide(
                                          color: Theme.of(context).accentColor,
                                          width: 2,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                })
                              },
                              child: new Container(
                                decoration: new BoxDecoration(
                                  color: Color.fromRGBO(
                                      this.colors[index].r,
                                      this.colors[index].g,
                                      this.colors[index].b,
                                      1),
                                  borderRadius: BorderRadius.circular(32.0),
                                  border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 2,
                                  ),
                                ),
                                child: new Icon(
                                    (color == this.colors[index])
                                        ? Icons.done
                                        : null,
                                    size: 38.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (snap.hasError) {
            return new Center(
              child: new Column(
                children: [
                  new Center(
                    child: new Text('Error ${snap.error}'),
                  ),
                  new Center(
                    child: new CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }
          return new Center(
            child: new Column(
              children: [
                new Center(
                  child: new Text('Waiting for the data'),
                ),
                new Center(
                  child: new CircularProgressIndicator(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

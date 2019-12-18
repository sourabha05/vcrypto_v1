import 'package:flutter/material.dart';
import 'package:vcrypto_v1/cryptscreen.dart';
import 'cryptdata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() async{
//  List currencies = await getCurrencies();
//  print(currencies);
//  runApp(new MyApp(currencies));
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
//  final List _currencies;
//  MyApp(this._currencies);
//  final String name, priceUSD, change_1h, change_24h, change_7d;
//
//  const MyApp({Key key, this.name, this.priceUSD, this.change_1h, this.change_24h, this.change_7d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      theme: ThemeData(
          primarySwatch: Colors.brown
      ),
      routes: <String,WidgetBuilder>{
        '/cryptScreen': (BuildContext context) => new cryptScreen(),
        '/cryptdata': (BuildContext context) => new cryptdata()
      },
    );
  }
}

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iconAnimationController = new AnimationController(
        vsync: this,
        duration:
        new Duration(seconds: 2));

    _iconAnimation = new Tween(
        begin: 250.0, end: 40.0).animate(
        new CurvedAnimation(
            parent: _iconAnimationController,
            curve: new Interval(0.0,0.700)));
    _iconAnimation.addListener(()=>this.setState((){}));
    _iconAnimationController.forward();

    _iconAnimationController.addListener((){
      if(_iconAnimationController.isCompleted){
        Navigator.of(context).pushReplacementNamed('/cryptScreen');
      }
    });
  }

  Future<Null> _playAnimation() async{
    try{
      await _iconAnimationController.forward();
      await _iconAnimationController.reverse();
    }
    on TickerCanceled{}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(7, 43, 102, 40.0),
      body: new Center(
        child: new Container(
          padding: EdgeInsets.all(3.0),
          height: 40.0,
          width: _iconAnimation.value,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white30),
          child: _iconAnimation.value> 135.0 ? new Row(
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(left: 10.0)),
              new Icon(Icons.arrow_forward,size: 0.09*_iconAnimation.value,),
//              new Padding(
//                  padding: EdgeInsets.only(left: 10.0)),
//              new Container(
//                width: 2.0,
//                height: 30.0,
//                color: Colors.black54,
//              ),
              new Padding(
                  padding: EdgeInsets.only(left: 15.0)),
              new InkWell(
                child: Text("Welcome User",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 0.09*_iconAnimation.value),
                ),
                onTap: (){
                  _playAnimation();
                  // Navigator.of(context).pushNamed('/cryptScreen');
                },)
            ],
          ) : new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.black
            ),
          ),
        ),
      ),
    );
  }
}

//Future<List> getCurrencies() async {
//  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
//  http.Response response = await http.get(cryptoUrl);
//  return json.decode(response.body);
//}


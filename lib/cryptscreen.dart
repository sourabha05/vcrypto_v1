import 'package:flutter/material.dart';
//import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cryptdata.dart';



class cryptScreen extends StatefulWidget {
//  final List currencies;
//  cryptScreen(this.currencies);

  @override
  _cryptScreenState createState() => _cryptScreenState();
}

class _cryptScreenState extends State<cryptScreen> {

  Future<List> getCurrencies() async {
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(cryptoUrl);
    return json.decode(response.body);
  }


  void listData() async{
    getCurrencies().then((curr){
      setState(() {
        currencies = curr;
        listToggle = true;
      });
    });
    print(currencies);
  }


  List currencies;
  List<MaterialColor> _colors = [Colors.yellow,Colors.blue,Colors.indigo,Colors.green,Colors.red];

  String name;
  String priceUSD;
  String change_24h;
  String change_7d;
  String change_1h;

  bool listToggle = false;
//  curr() async{
//    currencies = await getCurrencies();
//  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData();
  }

//  Future<List> getCurrencies() async {
//    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
//    http.Response response = await http.get(cryptoUrl);
//    return json.decode(response.body);
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(45, 61, 59, 100.0),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(112, 212, 197, 100.0),
        title: Text("eCapital",style: TextStyle(color: Colors.white,fontFamily: 'DelishN'),),
        centerTitle: true,
        actions: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.search)
            ],
          )
        ],
      ),
      body: listToggle ? _cryptoWidget()
      : _workingWidget(),
    );
  }
  Widget _cryptoWidget()
  {
    return Column(
      children: <Widget>[
      new Flexible(
          child: new ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (BuildContext context, int index){
              final Map currency = currencies[index];
              final MaterialColor color = _colors[index % _colors.length];
              return _getListItemUi(currency, color);
            },
          ))
    ],
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color)
  {
    return new ListTile(
      leading: new CircleAvatar(
        radius: 30.0,
        backgroundColor: color,
        child: new Text(currency['name'][0],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'DelishN',fontSize: 30.0),),
      ),
      title: new Text(currency['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0,color: Colors.white,fontFamily: 'DelishN'),),
      subtitle: _getSubtitleText(currency['price_usd'], currency['percent_change_1h'], currency['percent_change_24h'], currency['percent_change_7d']),
      onTap: (){
//        Navigator.of(context).pushNamed('/cryptdata');
        setState(() {
          String cname = currency['name'];
          name = cname;
          String cpriceUSD = currency['price_usd'];
          priceUSD = cpriceUSD;
          String cchange_1h = currency['percent_change_1h'];
          change_1h = cchange_1h;
          String cchange_24h = currency['percent_change_24h'];
          change_24h = cchange_24h;
          String cchange_7d = currency['percent_change_7d'];
          change_7d = cchange_7d;
          cryptdata(name: cname,priceUSD: cpriceUSD,change_1h: cchange_1h,change_24h: cchange_24h,change_7d: cchange_7d);
        });
        },
      isThreeLine: true,
    );

  }

  Widget _getSubtitleText(String priceUSD, String percentageChange, String percentChange24, String percentChange7){
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'DelishN',fontSize: 15.0));
    String percentageChangeText = "$percentageChange%";
    String percentChange24Text = "$percentChange24";
    Container percentageChangeTextWidget;
    TextSpan percentChange24h;
    TextSpan percentChange7d;
    
    if(double.parse(percentageChange)>0){
      percentageChangeTextWidget = Container(
        child: new Row(
          children: <Widget>[
            new Text("+$percentageChange%",
                style: TextStyle(color: Colors.green,fontFamily: 'DelishN')),
            new Icon(Icons.arrow_drop_up,color: Colors.green,)
          ],
        ),
      );
    }else{
      percentageChangeTextWidget = Container(
        child: new Row(
          children: <Widget>[
            new Text("$percentageChange%",
                style: TextStyle(color: Colors.red,fontFamily: 'DelishN')),
            new Icon(Icons.arrow_drop_down,color: Colors.red,)
          ],
        ),
      );
    }
    if(double.parse(percentChange24)>0){
      percentChange24h = new TextSpan(
        text: "24 Hours: +$percentChange24%",style: TextStyle(color: Colors.green,fontFamily: 'DelishN')
      );
    }else{
      percentChange24h = new TextSpan(
          text: "24 Hours: $percentChange24%",style: TextStyle(color: Colors.red,fontFamily: 'DelishN')
      );
    }
    if(double.parse(percentChange7)>0){
      percentChange7d = new TextSpan(
          text: "1 Week: +$percentChange7%",style: TextStyle(color: Colors.green,fontFamily: 'DelishN')
      );
    }else{
      percentChange7d = new TextSpan(
          text: "1 Week: $percentChange7%",style: TextStyle(color: Colors.red,fontFamily: 'DelishN')
      );
    }

    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RichText(
                text: new TextSpan(
                  children: [
                    priceTextWidget
                  ]
                )),
            percentageChangeTextWidget,
        new Padding(
            padding: EdgeInsets.only(top: 2.0)),
        new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RichText(
                text: new TextSpan(
              children: [
                percentChange24h
              ]
            )),
            new Padding(padding: EdgeInsets.only(left: 20.0)),
            RichText(
                text: new TextSpan(
                    children: [
                      percentChange7d
                    ]
                ))
          ],
        ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: new Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.white30,
              ),
            )
          ],
        );
  }

  _workingWidget() {
    return Center(
      child: Text("Working...",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
    );
  }
}

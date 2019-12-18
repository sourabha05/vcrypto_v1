import 'package:flutter/material.dart';
import 'cryptscreen.dart';

class cryptdata extends StatefulWidget {
//  final List currencies;
//
//  cryptdata(this.currencies);
final String name;
final String priceUSD;
final String change_1h;
final String change_24h;
final String change_7d;
const cryptdata({Key key, this.name,this.priceUSD,this.change_1h,this.change_24h,this.change_7d}) : super(key: key);

  @override
  _cryptdataState createState() => _cryptdataState();
}

class _cryptdataState extends State<cryptdata> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(45, 61, 59, 100.0),
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('${widget.name}',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: cryptDataWidget(),
    );
  }

  cryptDataWidget() {
    return
//      Container(
//      child: ListView.builder(
//        itemCount: widget.currencies.length,
//          itemBuilder: (BuildContext context,int index){
//            final Map currency = widget.currencies[index];
//            return
//              getUi(currency);
//          }
//      ),
//    );
    getUi();
  }

  getUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Container(
            padding: EdgeInsets.all(25.0),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),
//                side: BorderSide(width: 2.0,color: Colors.green)
                )
            ),
              child: priceWidget("hello"),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: new Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.white30,
            ),
          )
      ],
    );
  }

 Widget priceWidget(String priceText) {
    TextSpan priceTextWidget = new TextSpan(text: "\$ $priceText\n", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'DelishN',fontSize: 25.0));
    return RichText(
        text: new TextSpan(
            children: [
              priceTextWidget
            ]
        )
    );
  }

}

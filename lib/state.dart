import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:indexed_list_view/indexed_list_view.dart';

void main(){
  runApp(SampleApp());
}

class SampleApp2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: (){},
          child: Text('Hello'),
          padding: EdgeInsets.all(3.0),
        ),
      ),
    );
  }

}

class SampleApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: SampleAppPage()
    );
  }

}

class SampleAppPage extends StatefulWidget{
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() {
    return _SampleAppPageState();
  }



}


class _SampleAppPageState extends State<SampleAppPage>{
  String textToShow = "I Like Flutter";
  bool showText = true;
  List data = [];
//  IndexedScrollController scrollController;
  void _toTop(){
//    scrollController.jumpToIndex(0);
//    setState(() {
//      textToShow = "Flutter is Asesome!";
//      showText = !showText;
//    });
  }

   _getChild(){
     List<Widget> widgets = [];
     for (int i = 0; i < 100; i++) {
       widgets.add(Padding(padding: EdgeInsets.all(10.0), child: Text("Row $i")));
     }
     return widgets;
  }

  _getview(){
    List<Widget> widgets = [];
    data.forEach((d){
     widgets.add(Padding(padding: EdgeInsets.all(10.0), child: Image.network(d["img"]))) ;
    });

    return widgets;
  }

  _loadData() async {
    String url = "http://service.picasso.adesk.com/v1/vertical/vertical?limit=100";
    http.Response response = await http.get(url);

    setState(() {
      data.addAll(json.decode(response.body)["res"]["vertical"]);
    });
  }


  @override
  void initState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
//    scrollController = IndexedScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(child:ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int position){
//          if(position == data.length -1){
//            _loadData();
//          }
          return Padding(padding: EdgeInsets.all(10.0), child: Image.network(data[position]["img"]));
        },
//        controller: scrollController,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _toTop,
        tooltip: 'Update Text',
       child: Icon(Icons.arrow_upward),),
    );
  }

}
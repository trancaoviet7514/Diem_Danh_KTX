//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Baby Names',
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() {
//    return _MyHomePageState();
//  }
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//
//  final myController = TextEditingController();
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Baby Name Votes')),
//      body: _buildBody(context),
//    );
//  }
//
//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('name').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//
//        return _buildList(context, snapshot.data.documents);
//      },
//    );
//  }
//
//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return Column(
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.only(top: 10.0,right: 10.0, left: 10.0),
//          child: Row(
//            children: <Widget>[
//              Expanded(
//                child: TextField(
//                  controller: myController,
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10.0),
//                    hintText: 'Thêm tên mới',
//                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
//                  ),
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.only(left: 10.0),
//                child: RaisedButton(
//                  child: Text('OK'),
//                  onPressed: (){
//                    Map<String, dynamic> data = new Map<String, dynamic>();
//                    data.putIfAbsent('name2',() {data['name'] = myController.text;});
//                    data.putIfAbsent('votes2',() {data['votes'] = 1;});
//                    Firestore.instance.collection('name').document(myController.text).setData(data);
//                    print(myController.text);
//                  },
//                ),
//              )
//            ],
//          ),
//        ),
//        Expanded(
//          child: ListView(
//            shrinkWrap: true,
//            padding: const EdgeInsets.only(top: 20.0),
//            children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//          ),
//        )
//      ],
//    );
//  }
//
//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Record.fromSnapshot(data);
//
//    return Padding(
//      key: ValueKey(record.name),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        child: ListTile(
//          title: Text(record.name),
//          trailing: Text(record.votes.toString()),
//          onTap: () => Firestore.instance.runTransaction((transaction) async {
//            final freshSnapshot = await transaction.get(record.reference);
//            final fresh = Record.fromSnapshot(freshSnapshot);
//            await transaction
//                .update(record.reference, {'votes': fresh.votes + 1});
//          }),
//        ),
//      ),
//    );
//  }
//}
//
//class Record {
//  final String name;
//  final int votes;
//  final DocumentReference reference;
//
//  Record.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['name'] != null),
//        assert(map['votes'] != null),
//        name = map['name'],
//        votes = map['votes'];
//
//  Record.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);
//
//  @override
//  String toString() => "Record<$name:$votes>";
//}

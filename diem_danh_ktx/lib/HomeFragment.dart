import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem_danh_ktx/DataIO.dart';
import 'package:flutter/material.dart';

class HomeFragment extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new HomeFragmentState();
  }
}

class HomeFragmentState extends State<HomeFragment> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('DSHD').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Tìm kiếm',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: RaisedButton(
                  child: Text('Tìm'),
                  onPressed: () {
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20.0),
            children: snapshot.map((data) => _buildListItem(context, data))
                .toList(),
          ),
        )
      ],
    );
  }
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    var dataPath = data.reference.path;
    var eventName = dataPath.substring(dataPath.indexOf('/') + 1);

    return Padding(
      key: ValueKey(eventName),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(eventName),
            ),
            GestureDetector(
              onTap: (){
                DataIO.writeData('Van-Nghe-20-11-2018', DataIO.user.UserName);
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.green,
                child: Text('Điểm danh ngay'),
              ),
            )
          ],
        )
      ),
    );
  }


}
class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
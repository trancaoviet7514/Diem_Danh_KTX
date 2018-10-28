import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem_danh_ktx/Utils/DataIO.dart';
import 'package:flutter/material.dart';

class VerifyQueueScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerifyQueueScreenState();
  }
}

class VerifyQueueScreenState extends State<VerifyQueueScreen> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Danh sách chờ duyệt'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('DSHD/Van-Nghe-20-11-2018/DSSV').snapshots(),
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
    var eventName = dataPath.substring(dataPath.lastIndexOf('/') + 1);

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
                  child: Text('Duyệt'),
                ),
              ),
              GestureDetector(
                onTap: (){
                  DataIO.writeData('Van-Nghe-20-11-2018', DataIO.user.UserName);
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.red,
                  child: Text('Từ chối'),
                ),
              )
            ],
          )
      ),
    );
  }
}
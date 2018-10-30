import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem_danh_ktx/Utils/Config.dart';
import 'package:diem_danh_ktx/Model/User.dart';
import 'package:flutter/cupertino.dart';

class DataIO {
  static User _user;
  static HashMap<String, User> mListUser = HashMap();

  static User get user => _user;
  static set user(User value) => _user = value;

  static void writeData(String EventName, String StudentId) {
    Map<String, bool> data = {'start':true};
    Firestore.instance.document('DSHD/'+ EventName + '/DSSV/' + StudentId).setData(data);
    if (Config.DEBUG == true) {
      print(StudentId);
    }
  }

  static void getAllUser() {
    Firestore.instance.collection('DSSV').snapshots().listen((querySnapshot) {
      querySnapshot.documents.forEach((change) {
        var dataPath = change.reference.path;
        var Key = dataPath.substring(dataPath.indexOf('/') + 1);
        var newuser = User(change.data.values.toList(growable: true)[1],change.data.values.toList(growable: true)[2],change.data.values.toList(growable: true)[0]);

        mListUser.putIfAbsent(Key, (){return newuser;});
      });
    });
  }

  static bool VerifyAccount(String UserName, String Password) {
    if (mListUser.containsKey(UserName)) {
      if (mListUser[UserName].Password == Password) {
        _user = mListUser[UserName];
        return true;
      }
    }
    return false;
  }

}
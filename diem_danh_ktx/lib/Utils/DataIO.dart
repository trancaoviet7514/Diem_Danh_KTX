import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem_danh_ktx/Utils/Config.dart';
import 'package:diem_danh_ktx/Model/User.dart';

class DataIO {
  static User _user;

  static User get user => _user;
  static set user(User value) => _user = value;

  static void writeData(String EventName, String StudentId) {
    Map<String, bool> data = {'start':true};
    Firestore.instance.document('DSHD/'+ EventName + '/DSSV/' + StudentId).setData(data);
    if (Config.DEBUG == true) {
      print(StudentId);
    }
  }

}
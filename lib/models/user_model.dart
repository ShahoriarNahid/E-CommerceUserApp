import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? name;
  String email;
  String? mobile;
  String? image;
  Timestamp userCreationTime;
  String? deviceToken;

  UserModel(
      {required this.uid,
        this.name,
        required this.email,
        this.mobile,
        this.image,
        required this.userCreationTime,
        this.deviceToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'uid' : uid,
      'name' : name,
      'mobile' : mobile,
      'email' : email,
      'image' : image,
      'deviceToken' : deviceToken,
      'userCreationTime' : userCreationTime,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'],
    name: map['name'],
    mobile: map['mobile'],
    email: map['email'],
    image: map['image'],
    deviceToken: map['deviceToken'],
    userCreationTime: map['userCreationTime'],
  );
}
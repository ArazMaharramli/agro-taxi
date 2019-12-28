import 'package:agrotaxi/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  UserModel sendBy;
  UserModel readBy;
  String messageText;
  Timestamp sendDate;
  Timestamp readDate;
  bool isReceivedMessage;

  MessageModel(
      {this.messageText,
      this.readDate,
      this.sendBy,
      this.readBy,
      this.sendDate,
      this.isReceivedMessage});


  MessageModel.fromJson(json)
      : this.readBy = new UserModel.fromJson(json["ReadBy"]),
        this.messageText = json["MessageText"],
        this.sendDate = json["SendDate"],
        this.isReceivedMessage = json["IsReceivedMessage"];


  Map<String, dynamic> toMap() {
    return {
      "ReadBy": this.readBy ==null? null :this.readBy.toMap(),
      "MessageText": this.messageText,
      "SendDate": this.sendDate??null,
      "ReadDate":this.readDate??null,
      "IsReceivedMessage": this.isReceivedMessage,
    };
  }
}

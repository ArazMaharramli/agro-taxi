import 'package:agrotaxi/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageProvider {
  Future<bool> sendMessage(MessageModel _messageModel) async {
    try {
      var doc = await Firestore.instance
          .collection("Messages")
          .document(_messageModel.sendBy.phoneNumber)
          .get();
      Map<String, dynamic> newData = {
        "HasNewMessage": true,
        "IsAccomplished": false,
        "MessageCount": 1,
        "MessageSenderDetails": _messageModel.sendBy.toMap(),
        "Messages": []
      };
      if (doc.exists) {
        newData["MessageCount"] = doc.data["Messages"].length + 1;
        newData["Messages"] = FieldValue.arrayUnion([_messageModel.toMap()]);

        await Firestore.instance
            .collection("Messages")
            .document(_messageModel.sendBy.phoneNumber)
            .updateData(newData);
        print(_messageModel.messageText + "  is written to firestore");
      } else {
        newData["Messages"] = [_messageModel.toMap()];
        await Firestore.instance
            .collection("Messages")
            .document(_messageModel.sendBy.phoneNumber)
            .setData(newData);
      }

      return true;
    } catch (e) {
      print("MessageProvider sendMessage method error ${e.toString()}");
      return false;
    }
  }

  Future<List<MessageModel>> getMessages(String phoneNumber) async {
    var messagesDoc =
        await Firestore.instance.collection("Messages").document(phoneNumber).get();
    if (messagesDoc.exists && messagesDoc.data.isNotEmpty) {
      List<MessageModel> messages =
          List.generate(messagesDoc.data["Messages"].length, (index) {
        return new MessageModel.fromJson(messagesDoc.data["Messages"][index]);
      });
      return messages;
    }
    return [];
  }
}

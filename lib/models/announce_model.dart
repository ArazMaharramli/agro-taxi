import 'package:agrotaxi/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnounceModel {
  String announceName;
  String message;
  UserModel announcerDetails;
  Timestamp creationDate;
  PriceSuggestionListModel priceSuggestions = new PriceSuggestionListModel();

  String docId;
  int index;

  AnnounceModel({
    this.announceName,
    this.message,
    this.priceSuggestions,
    this.announcerDetails,
    this.docId,
    this.index,
    this.creationDate
  });

  AnnounceModel.formJson(json) {
    announceName = json["AnnounceName"];
    message = json["Message"];
    creationDate = json["CreationDate"];
    announcerDetails = UserModel.fromJson(json["AnnouncerDetails"]);
    priceSuggestions =
        PriceSuggestionListModel.fromJson(json["PriceSuggestions"]);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "AnnounceName": announceName,
      "AnnouncerDetails": announcerDetails.toMap(),
      "Message": message,
      "PriceSuggestions": priceSuggestions.toMap(),
      "CreationDate": creationDate,
    };
    return map;
  }
}

class PriceSuggestionListModel {
  List<PriceSuggestionModel> suggestions;
  PriceSuggestionListModel({this.suggestions}) {
    suggestions = [];
  }

  PriceSuggestionListModel.fromJson(json) {
    // Map data = json.decode(json);
    for (var item in json) {
      suggestions.add(PriceSuggestionModel.fromJson(item));
    }
  }
  List toMap() {
    return suggestions.length == 0
        ? []
        : List.generate(
            suggestions.length, (index) => suggestions[index].toMap());
  }
}

class PriceSuggestionModel {
  UserModel user;
  String suggestion;
  Timestamp postedAt;

  PriceSuggestionModel({this.user, this.suggestion, this.postedAt});
  PriceSuggestionModel.fromJson(Map json) {
    if (json.containsKey('User')) {
      user = UserModel.fromJson(json['User']);
    }

    if (json.containsKey('Suggestion')) {
      suggestion = json['Suggestion'];
    } else {
      suggestion = "000";
    }
    postedAt = json['PostedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      "User": user.toMap(),
      "Suggestion": suggestion,
      "PostedAt": postedAt
    };
  }
}

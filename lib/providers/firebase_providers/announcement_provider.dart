import 'package:agrotaxi/models/announce_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementProvider {
  //void-i deyismek lazimdi
  Future<AnnounceModel> getAnnouncementDetails(docId) async {
    var announcementDoc = await Firestore.instance
        .collection("Announcements")
        .document(docId)
        .get();
    return AnnounceModel.formJson(announcementDoc.data);
  }

  Future<String> createAnnouncement({AnnounceModel model}) async {
    model.creationDate = Timestamp.now();
    DocumentReference doc =
        await Firestore.instance.collection("Announcements").add(model.toMap());
    print("new announcement docID : " + doc.documentID);
    return doc?.documentID;
  }
}

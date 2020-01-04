import 'package:agrotaxi/custom_widgets/announcement_widget.dart';
import 'package:agrotaxi/models/announce_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnnouncementsPage extends StatefulWidget {
  AnnouncementsPage();
  @override
  State<StatefulWidget> createState() {
    return _AnnouncementsPageState();
  }
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final modalBottomSheetFormKey = new GlobalKey<FormState>();

  AnnounceModel announceModel = new AnnounceModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection("Announcements")
            .orderBy("CreationDate", descending: true)
            .snapshots(),
        // initialData: initialData ,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Column(
              children: [
                LinearProgressIndicator(),
              ],
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return AnnouncementWidget(
                model:
                    AnnounceModel.formJson(snapshot.data.documents[index].data),
              );
            },
          );
        },
      ),
    );
  }

  void add(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        // useRootNavigator: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height - 50,
            child: Form(
              key: modalBottomSheetFormKey,
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 30, top: 30),
                        child: Text(
                          "Yeni Elan",
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    // obscureText: true,
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: "Elan adı",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(20),
                          //   topRight: Radius.circular(20),
                          // ),
                          ),
                    ),
                    onSaved: (value) {
                      announceModel.announceName = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    minLines: 5,
                    maxLines: 5,
                    maxLength: 50,
                    //   obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Mesajınız",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.00, 10.00, 20.00, 10.00),
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(20),
                          //   topRight: Radius.circular(20),
                          // ),
                          ),
                    ),
                    onSaved: (value) {
                      announceModel.message = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.blue,
                        child: Text(
                          "Paylaş",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          // setState(() {
                          //   modalBottomSheetSubmitted = true;
                          // });
                          modalBottomSheetFormKey.currentState.save();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

import 'dart:math';
import 'package:agrotaxi/models/announce_model.dart';
import 'package:flutter/material.dart';

class AnnouncementWidget extends StatelessWidget {
  AnnouncementWidget({Key key, this.model}) : super(key: key);
  final AnnounceModel model;
  // = new AnnounceModel(
  //   announceName: "Test",
  //   message: "salam test test test test",
  //   announcerDetails: new UserModel(
  //     fullname: "test1 test2",
  //     phoneNumber: "+987123456789",
  //     city: "city1",
  //     profilePictureUrl:
  //         "https://i.guim.co.uk/img/uploads/2018/05/18/Stuart_Heritage,_L.png?width=300&quality=85&auto=format&fit=max&s=3e76a4d353fbc6d67f8f32cd2005d577",
  //     rating: 3,
  //   ),
  // );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 250,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.primaries.elementAt(Random().nextInt(15)),
            child: Text(
              model.message,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: model.announcerDetails.profilePictureUrl == null
                  ? Icon(Icons.ac_unit)
                  : Image.network(
                      model.announcerDetails.profilePictureUrl,
                      fit: BoxFit.cover,
                    ),
            ),
            title: Text(model.announcerDetails.fullname),
            subtitle: Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.announcerDetails.rating??0,
                itemBuilder: (BuildContext context, int index) {
                  return Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

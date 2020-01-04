
import 'package:agrotaxi/models/announce_model.dart';
import 'package:agrotaxi/providers/firebase_providers/announcement_provider.dart';
import 'package:agrotaxi/routers/user_init.dart';
import 'package:flutter/material.dart';

class AddAnnouncementWidget extends StatelessWidget {
  
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final AnnouncementProvider _announcementProvider = new AnnouncementProvider();
  final AnnounceModel _model = new AnnounceModel();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          TextFormField(
            autofocus: true,
            minLines: 4,
            maxLength: 1000,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: "Elan mətni",
              contentPadding: EdgeInsets.fromLTRB(10.00, 10.00, 10.00, 0.00),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Zəhmət olmasa elan mətnini daxil edin";
              }
              return null;
            },
            onSaved: (value) {
              _model.message = value;
            },
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              print("createAnnouncement");
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                UserInit().getUserDetails().then((userModel){
                  _model.announcerDetails = userModel;
                  _model.announceName = "";
                  _model.priceSuggestions=new PriceSuggestionListModel();
                  _announcementProvider.createAnnouncement(model: _model).then((onValue){
                    Navigator.of(context).pop();
                  });
                });
                
              }
            },
            child: Text(
              "Paylaş",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        ],
      ),
    );
  }
}

class UserModel {
  String fullname;
  String profilePictureUrl;
  String city;
  String phoneNumber;
  int rating;
  String uid;
  UserModel(
      {this.fullname,
      this.profilePictureUrl,
      this.city,
      this.phoneNumber,
      this.rating,
      this.uid});

  Map<String, dynamic> toMap() {
    return {
      "FullName": this.fullname,
      "ProfilePictureUrl": this.profilePictureUrl,
      "City": this.city,
      "PhoneNumber": this.phoneNumber,
      "Rating": rating!=null? rating :0,
    };
  }

  UserModel.fromJson(json){
    if (json != null) {
        this.fullname = json["FullName"];
        this.city = json["City"];
        this.phoneNumber = json["PhoneNumber"];
        this.uid = json["Uid"];
      }
  }
      
}

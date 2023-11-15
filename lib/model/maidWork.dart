class maidWork {
  int? idUser;
  String? username;
  String? fname;
  String? lname;
  String? nickname;
  String? profile;
  String? phone;
  String? roomnumber;
  String? roomsize;
  String? maidSumrating;
  String? password;
  String? idCard;
  String? birthday;
  String? address;
  int? typeId;
  String? typeName;
  String? typeDescription;
  int? idType;

  maidWork(
      {this.idUser,
      this.username,
      this.fname,
      this.lname,
      this.nickname,
      this.profile,
      this.phone,
      this.roomnumber,
      this.roomsize,
      this.maidSumrating,
      this.password,
      this.idCard,
      this.birthday,
      this.address,
      this.typeId,
      this.typeName,
      this.typeDescription,
      this.idType});

  maidWork.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    username = json['username'];
    fname = json['fname'];
    lname = json['lname'];
    nickname = json['nickname'];
    profile = json['profile'];
    phone = json['phone'];
    roomnumber = json['roomnumber'];
    roomsize = json['roomsize'];
    maidSumrating = json['maid_sumrating'];
    password = json['password'];
    idCard = json['id_card'];
    birthday = json['birthday'];
    address = json['address'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    typeDescription = json['type_description'];
    idType = json['id_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['username'] = this.username;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['nickname'] = this.nickname;
    data['profile'] = this.profile;
    data['phone'] = this.phone;
    data['roomnumber'] = this.roomnumber;
    data['roomsize'] = this.roomsize;
    data['maid_sumrating'] = this.maidSumrating;
    data['password'] = this.password;
    data['id_card'] = this.idCard;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['type_description'] = this.typeDescription;
    data['id_type'] = this.idType;
    return data;
  }
}
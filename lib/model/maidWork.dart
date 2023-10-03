class maidWork {
  int? idWorktime;
  Null? status;
  String? day;
  int? idTimeworktype;
  int? idUser;
  String? username;
  String? fname;
  String? lname;
  String? phone;
  Null? roomnumber;
  Null? roomsize;
  Null? maidRating;
  String? password;
  String? idCard;
  int? age;
  String? address;
  int? typeId;
  int? idWorktimetype;
  String? startWork;
  String? endWork;
  String? descriptionWork;

  maidWork(
      {this.idWorktime,
      this.status,
      this.day,
      this.idTimeworktype,
      this.idUser,
      this.username,
      this.fname,
      this.lname,
      this.phone,
      this.roomnumber,
      this.roomsize,
      this.maidRating,
      this.password,
      this.idCard,
      this.age,
      this.address,
      this.typeId,
      this.idWorktimetype,
      this.startWork,
      this.endWork,
      this.descriptionWork});

  maidWork.fromJson(Map<String, dynamic> json) {
    idWorktime = json['id_worktime'];
    status = json['status'];
    day = json['day'];
    idTimeworktype = json['id_timeworktype'];
    idUser = json['id_user'];
    username = json['username'];
    fname = json['fname'];
    lname = json['lname'];
    phone = json['phone'];
    roomnumber = json['roomnumber'];
    roomsize = json['roomsize'];
    maidRating = json['maid_rating'];
    password = json['password'];
    idCard = json['id_card'];
    age = json['age'];
    address = json['address'];
    typeId = json['type_id'];
    idWorktimetype = json['id_worktimetype'];
    startWork = json['start_work'];
    endWork = json['end_work'];
    descriptionWork = json['description_work'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_worktime'] = this.idWorktime;
    data['status'] = this.status;
    data['day'] = this.day;
    data['id_timeworktype'] = this.idTimeworktype;
    data['id_user'] = this.idUser;
    data['username'] = this.username;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['phone'] = this.phone;
    data['roomnumber'] = this.roomnumber;
    data['roomsize'] = this.roomsize;
    data['maid_rating'] = this.maidRating;
    data['password'] = this.password;
    data['id_card'] = this.idCard;
    data['age'] = this.age;
    data['address'] = this.address;
    data['type_id'] = this.typeId;
    data['id_worktimetype'] = this.idWorktimetype;
    data['start_work'] = this.startWork;
    data['end_work'] = this.endWork;
    data['description_work'] = this.descriptionWork;
    return data;
  }
}
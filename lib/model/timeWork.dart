class TimeWork {
  int? idWorktime;
  String? status;
  String? day;
  int? idTimeworktype;
  int? idUser;

  TimeWork(
      {this.idWorktime,
      this.status,
      this.day,
      this.idTimeworktype,
      this.idUser});

  TimeWork.fromJson(Map<String, dynamic> json) {
    idWorktime = json['id_worktime'];
    status = json['status'];
    day = json['day'];
    idTimeworktype = json['id_timeworktype'];
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_worktime'] = this.idWorktime;
    data['status'] = this.status;
    data['day'] = this.day;
    data['id_timeworktype'] = this.idTimeworktype;
    data['id_user'] = this.idUser;
    return data;
  }
}
class TimeWork {
  int? idWorktime;
  Null? status;
  String? day;
  int? idTimeworktype;
  int? idUser;
  int? idWorktimetype;
  String? startWork;
  String? endWork;
  String? descriptionWork;

  TimeWork(
      {this.idWorktime,
      this.status,
      this.day,
      this.idTimeworktype,
      this.idUser,
      this.idWorktimetype,
      this.startWork,
      this.endWork,
      this.descriptionWork});

  TimeWork.fromJson(Map<String, dynamic> json) {
    idWorktime = json['id_worktime'];
    status = json['status'];
    day = json['day'];
    idTimeworktype = json['id_timeworktype'];
    idUser = json['id_user'];
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
    data['id_worktimetype'] = this.idWorktimetype;
    data['start_work'] = this.startWork;
    data['end_work'] = this.endWork;
    data['description_work'] = this.descriptionWork;
    return data;
  }
}
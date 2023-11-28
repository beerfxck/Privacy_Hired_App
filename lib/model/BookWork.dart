class BookWork {
  int? bookingId;
  String? bookingDate;
  int? workHour;
  String? startWork;
  String? descriptmaid;
  int? servicePrice;
  String? paymentslip;
  String? maidRating;
  int? status;
  int? userBooking;
  int? maidbooking;
  int? idMaidwork;
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
  int? idStatus;
  String? statusName;
  String? statusDescription;

  BookWork(
      {this.bookingId,
      this.bookingDate,
      this.workHour,
      this.startWork,
      this.descriptmaid,
      this.servicePrice,
      this.paymentslip,
      this.maidRating,
      this.status,
      this.userBooking,
      this.maidbooking,
      this.idMaidwork,
      this.idUser,
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
      this.idStatus,
      this.statusName,
      this.statusDescription});

  BookWork.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingDate = json['booking_date'];
    workHour = json['work_hour'];
    startWork = json['start_work'];
    descriptmaid = json['descriptmaid'];
    servicePrice = json['service_price'];
    paymentslip = json['paymentslip'];
    maidRating = json['maid_rating'];
    status = json['status'];
    userBooking = json['user_booking'];
    maidbooking = json['maidbooking'];
    idMaidwork = json['id_maidwork'];
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
    idStatus = json['id_status'];
    statusName = json['status_name'];
    statusDescription = json['status_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_date'] = this.bookingDate;
    data['work_hour'] = this.workHour;
    data['start_work'] = this.startWork;
    data['descriptmaid'] = this.descriptmaid;
    data['service_price'] = this.servicePrice;
    data['paymentslip'] = this.paymentslip;
    data['maid_rating'] = this.maidRating;
    data['status'] = this.status;
    data['user_booking'] = this.userBooking;
    data['maidbooking'] = this.maidbooking;
    data['id_maidwork'] = this.idMaidwork;
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
    data['id_status'] = this.idStatus;
    data['status_name'] = this.statusName;
    data['status_description'] = this.statusDescription;
    return data;
  }
}
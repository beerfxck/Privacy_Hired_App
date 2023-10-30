class BookWork {
  String? bookingDate;
  int? workHour;
  String? startWork;
  String? descriptmaid;
  int? servicePrice;
  String? paymentslip;
  int? maidRating;
  String? status;
  int? userBooking;
  int? maidbooking;

  BookWork(
      {this.bookingDate,
      this.workHour,
      this.startWork,
      this.descriptmaid,
      this.servicePrice,
      this.paymentslip,
      this.maidRating,
      this.status,
      this.userBooking,
      this.maidbooking});

  BookWork.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}
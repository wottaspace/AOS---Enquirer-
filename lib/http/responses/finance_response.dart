class FinanceResponse {
  FinanceResponse({
    required this.funded,
    required this.paidTransactions,
    required this.totalJobs,
    required this.totalPaid,
    required this.unpaidTransactions,
  });

  String funded;
  List<PaidTransaction> paidTransactions;
  String totalJobs;
  String totalPaid;
  List<UnpaidTransaction> unpaidTransactions;

  factory FinanceResponse.fromJson(Map<String, dynamic> json) => FinanceResponse(
        funded: json["funded"],
        paidTransactions: List<PaidTransaction>.from(json["paid_transactions"].map((x) => PaidTransaction.fromJson(x))),
        totalJobs: json["total_jobs"],
        totalPaid: json["total_paid"],
        unpaidTransactions: List<UnpaidTransaction>.from(json["unpaid_transactions"].map((x) => UnpaidTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "funded": funded,
        "paid_transactions": List<dynamic>.from(paidTransactions.map((x) => x.toJson())),
        "total_jobs": totalJobs,
        "total_paid": totalPaid,
        "unpaid_transactions": List<dynamic>.from(unpaidTransactions.map((x) => x.toJson())),
      };
}

class PaidTransaction {
  PaidTransaction({
    required this.amountPaid,
    required this.applicationId,
    required this.businessName,
    required this.jobId,
    required this.jobType,
    required this.memberName,
    required this.month,
    required this.paymentDate,
    required this.paymentStatus,
    required this.profilePic,
    required this.stars,
    required this.transactionId,
  });

  String amountPaid;
  int applicationId;
  String businessName;
  int jobId;
  String jobType;
  String memberName;
  String month;
  String paymentDate;
  String paymentStatus;
  String profilePic;
  int stars;
  int transactionId;

  factory PaidTransaction.fromJson(Map<String, dynamic> json) => PaidTransaction(
        amountPaid: json["amount_paid"],
        applicationId: json["application_id"],
        businessName: json["business_name"],
        jobId: json["job_id"],
        jobType: json["job_type"],
        memberName: json["member_name"],
        month: json["month"],
        paymentDate: json["payment_date"],
        paymentStatus: json["payment_status"],
        profilePic: json["profile_pic"],
        stars: json["stars"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount_paid": amountPaid,
        "application_id": applicationId,
        "business_name": businessName,
        "job_id": jobId,
        "job_type": jobType,
        "member_name": memberName,
        "month": month,
        "payment_date": paymentDate,
        "payment_status": paymentStatus,
        "profile_pic": profilePic,
        "stars": stars,
        "transaction_id": transactionId,
      };
}

class UnpaidTransaction {
  UnpaidTransaction({
    required this.amountPaid,
    required this.applicationId,
    required this.businessName,
    required this.jobId,
    required this.jobType,
    required this.memberName,
    required this.month,
    required this.paymentStatus,
    required this.profilePic,
    required this.stars,
    required this.transactionId,
  });

  String amountPaid;
  int applicationId;
  String businessName;
  int jobId;
  String jobType;
  String memberName;
  String month;
  String paymentStatus;
  String profilePic;
  String stars;
  int transactionId;

  factory UnpaidTransaction.fromJson(Map<String, dynamic> json) => UnpaidTransaction(
        amountPaid: json["amount_paid"],
        applicationId: json["application_id"],
        businessName: json["business_name"],
        jobId: json["job_id"],
        jobType: json["job_type"],
        memberName: json["member_name"],
        month: json["month"],
        paymentStatus: json["payment_status"],
        profilePic: json["profile_pic"],
        stars: json["stars"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount_paid": amountPaid,
        "application_id": applicationId,
        "business_name": businessName,
        "job_id": jobId,
        "job_type": jobType,
        "member_name": memberName,
        "month": month,
        "payment_status": paymentStatus,
        "profile_pic": profilePic,
        "stars": stars,
        "transaction_id": transactionId,
      };
}

import 'dart:convert';

class QrCode {
  late String qrId;
  late String qrUrl;
  late String userId;
  late DateTime createdAt;
  QrCode({required this.qrId,required this.qrUrl,required this.userId,required this.createdAt});
  QrCode.fromJson(Map<String, dynamic> json) {
    qrId = json['qrId'];
    qrUrl = json['qrUrl'];
    userId = json['userId'];
    createdAt = json['createdAt'];

  }
}


QrCode Qrjson(String str) =>
    QrCode.fromJson(json.decode(str));
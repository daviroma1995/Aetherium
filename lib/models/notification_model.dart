// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String title;
  String body;
  String senderId;
  String receiverId;
  String senderImage;
  String senderName;
  String desc;
  String status;
  Timestamp createdAt;
  String type;
  String appointmentId;
  String clientId;
  // Client sender;
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.senderId,
    required this.receiverId,
    required this.senderImage,
    required this.senderName,
    required this.desc,
    required this.status,
    required this.createdAt,
    required this.type,
    required this.appointmentId,
    required this.clientId,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? senderId,
    String? receiverId,
    String? senderImage,
    String? senderName,
    Timestamp? createdAt,
    String? type,
    String? desc,
    String? status,
    String? appointmentId,
    String? clientId,
    // Client? sender,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      senderImage: senderImage ?? this.senderImage,
      senderName: senderName ?? this.senderName,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      desc: desc ?? this.desc,
      status: status ?? this.desc,
      appointmentId: appointmentId ?? this.appointmentId,
      clientId: clientId ?? this.clientId,
      // sender: sender ?? this.sender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderImage': senderImage,
      'senderName': senderName,
      'createdAt': createdAt,
      'type': type,
      'desc': desc,
      'status': status,
      'client_id': receiverId,
      'appointmentId': appointmentId,
      // 'sender': sender.toJson(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] as String,
      body: map['body'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      senderImage: map['senderImage'] as String,
      senderName: map['senderName'] as String,
      createdAt: map['createdAt'] as Timestamp,
      type: map['type'] as String,
      desc: map['desc'] as String,
      status: map['status'] as String,
      appointmentId: map['appointmentId'] as String,
      clientId: map['client_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, body: $body, senderId: $senderId, receiverId: $receiverId, senderImage: $senderImage, senderName: $senderName, createdAt: $createdAt, type: $type,)'; // sender: $sender)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.senderImage == senderImage &&
        other.senderName == senderName &&
        other.createdAt == createdAt &&
        other.type == type;
    // other.sender == sender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        senderImage.hashCode ^
        senderName.hashCode ^
        createdAt.hashCode ^
        type.hashCode;
    // sender.hashCode;
  }
}

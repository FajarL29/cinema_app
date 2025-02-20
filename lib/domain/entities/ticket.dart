//import 'package:uuid/uuid.dart';

import 'dart:convert';

class TicketEntity {
  final String id;
  final String seat;
  final DateTime date;
  final double price;
  final String title;
  final String urlimage;
  final int idmovie;

  const TicketEntity({
    required this.id,
    required this.seat,
    required this.date,
    required this.price,
    required this.title,
    required this.urlimage,
    required this.idmovie,
  });

  // Convert TicketEntity to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seat': seat,
      'date': date.toIso8601String(),
      'price': price,
      'title': title,
      'urlimage': urlimage,
      'idmovie': idmovie,
    };
  }

// Convert Map to TicketEntity
  factory TicketEntity.fromMap(Map<String, dynamic> map) {
    return TicketEntity(
      id: map['id'],
      seat: map['seat'],
      date: DateTime.parse(map['date']),
      price: map['price'],
      title: map['title'],
      urlimage: map['urlimage'],
      idmovie: map['idmovie'],
    );
  }
  String toJson() => json.encode(toMap());

  factory TicketEntity.fromJson(String source) =>
      TicketEntity.fromMap(json.decode(source));
}
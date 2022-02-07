import 'package:app_book_septianton/models/message.dart';

class Room {
  int? id;
  List<Message> messages;
  Room({required this.id, required this.messages});
}

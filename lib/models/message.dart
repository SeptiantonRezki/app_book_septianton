enum statusClient { sender, receiver }

class Message {
  int idMessage;
  int? idMessageRoom;
  int idSender;
  int idReceiver;
  String nameReceiver;
  String message;
  DateTime timeMessage;
  Message({
    required this.idMessage,
    required this.idMessageRoom,
    required this.idSender,
    required this.idReceiver,
    required this.nameReceiver,
    required this.message,
    required this.timeMessage,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idMessage: json["id_message"],
      idMessageRoom: json["id_message_room"],
      idSender: json["id_sender"],
      idReceiver: json["id_receiver"],
      nameReceiver: json["name"] ?? "",
      message: json["message"],
      timeMessage: DateTime.parse(json["time"]),
    );
  }
  factory Message.initial() {
    return Message(
      idMessage: 0,
      idMessageRoom: 0,
      idSender: 0,
      idReceiver: 0,
      nameReceiver: "",
      message: "",
      timeMessage: DateTime.now(),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:app_book_septianton/models/book.dart';
import 'package:app_book_septianton/models/message.dart';
import 'package:app_book_septianton/models/room.dart';
import 'package:http/http.dart' as http;

const _url = "http://192.168.56.1:55521/api/v1";
// const _url = "http://208.87.132.73:55521/api/v1";

var _headers = {'Content-Type': 'application/json'};
Future<Room> getMessages(
    {required int idClient,
    required int idReciever,
    int? idMessageRoom}) async {
  List<Message> messages = [];
  int? room;
  try {
    var url = Uri.parse("$_url/message/");
    var request = http.Request('GET', url);
    if (idMessageRoom == null) {
      request.body = json.encode({
        "id_sender": idClient,
        "id_receiver": idReciever,
      });
    } else {
      request.body = json.encode({
        "id_sender": idClient,
        "id_receiver": idReciever,
        "id_message_room": idMessageRoom,
      });
    }
    request.headers.addAll(_headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode(await response.stream.bytesToString());
      room = responseData["room"];
      for (var item in responseData["data"]) {
        messages.add(Message.fromJson(item));
      }
    }
  } catch (e) {
    print(e.toString());
  }
  Room roomChat = Room(id: room, messages: messages);
  return roomChat;
}

Future<List<Message>> getMessagesSender({required int idSender}) async {
  List<Message> messages = [];
  try {
    var url = Uri.parse("$_url/user/$idSender/messages");
    var request = http.Request('GET', url);
    request.headers.addAll(_headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode(await response.stream.bytesToString());
      for (var item in responseData["data"]) {
        messages.add(Message.fromJson(item));
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return messages;
}

Future<List<int>> getPeopleInRoomConversation(
    {required int idConversation}) async {
  List<int> peoplesId = [];
  try {
    var url = Uri.parse("$_url/conversation/$idConversation/peoples");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      for (var item in responseData["data"]) {
        peoplesId.add(item["id_people"]);
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return peoplesId;
}

Future<Message?> sendMessageAPI({
  required int idSender,
  required int idReceiver,
  required String message,
  required int? idMessageRoom,
}) async {
  try {
    // localhost:55521/api/v1/message/
    var url = Uri.parse("$_url/message/");
    var request = http.Request('POST', url);
    if (idMessageRoom == null) {
      request.body = json.encode({
        "id_sender": idSender,
        "id_receiver": idReceiver,
        "message": message
      });
    } else {
      request.body = json.encode({
        "id_sender": idSender,
        "id_receiver": idReceiver,
        "id_message_room": idMessageRoom,
        "message": message
      });
    }
    request.headers.addAll(_headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode(await response.stream.bytesToString());
      Message newMessage = Message.fromJson(responseData["data"]);
      return newMessage;
    }
  } catch (e) {
    print(e.toString());
  }
}

// void main(List<String> args) async {
//   // var messages =
//   //     await getMessages(idClient: 1, idReciever: 2, idConversation: 1);
//   var message = await sendMessageAPI(
//       idSender: 1, idReceiver: 2, message: "Hallo ??", idMessageRoom: null);
//   print(message.message);
//   // for (var item in messages.messages) {
//   //   print(item.idMessage);
//   //   print(item.idMessageRoom);
//   //   print(item.idReceiver);
//   //   print(item.idSender);
//   //   print(item.message);
//   //   print(item.timeMessage);
//   // }
// }

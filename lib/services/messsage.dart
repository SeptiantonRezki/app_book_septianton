import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const _url = "http://192.168.56.1:5021/api/v1";

Future<List<Map<String, dynamic>>> getMessages(
    {required int idClient, required int idConversation}) async {
  List<Map<String, dynamic>> messages = [];
  try {
    var url = Uri.parse("$_url/conversation/$idConversation/messages");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      for (var item in responseData["data"]) {
        if (item["id_sender"] == idClient) {
          messages.add({"status": "sender", "message": item["message"]});
        } else {
          messages.add({"status": "receiver", "message": item["message"]});
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return messages;
}

// void main(List<String> args) async {
//   var messages = await getMessages(idClient: 1, idConversation: 1);
//   for (var item in messages) {
//     print(item);
//   }
// }

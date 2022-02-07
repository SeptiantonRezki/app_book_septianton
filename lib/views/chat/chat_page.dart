import 'dart:convert';

import 'package:app_book_septianton/models/message.dart';
import 'package:app_book_septianton/models/room.dart';
import 'package:app_book_septianton/services/messsage.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final int idSender;
  final int idReceiver;
  final int? idMessageRoom;
  final String nameReceiver;
  const ChatPage(
      {required this.idSender,
      required this.idReceiver,
      required this.idMessageRoom,
      required this.nameReceiver,
      Key? key})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  int? stateIdMessageRoom;
  List<Message> messages = [];
  @override
  void initState() {
    super.initState();
    // socket = IO.io('http://208.87.132.73:3021/', <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": false
    // });
    socket = IO.io('http://192.168.56.1:3021/', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });

    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
    socket.emit("addUser", widget.idSender);
  }

  // getPeoples() async {
  //   getPeopleInRoomConversation(idConversation: idMessageRoom!);
  // }

  sendMessage(String message) async {
    print(message);
    // send message to socket io
    socket.emit("sendMessage", {
      "senderId": widget.idSender,
      "receiverId": [widget.idReceiver],
      "message": message,
    });
    print(
      utf8.encode(message),
    );
    try {
      // sending message to server to save
      Message? newMessage = await sendMessageAPI(
        idSender: widget.idSender,
        idReceiver: widget.idReceiver,
        message: message,
        idMessageRoom: widget.idMessageRoom,
      );
      // setState message in views
      if (newMessage != null) {
        setState(() {
          messages.add(newMessage);
          print(newMessage);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        VNavigation.gotoNavigation(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.nameReceiver),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<Room>(
              future: getMessages(
                idClient: widget.idSender,
                idReciever: widget.idReceiver,
                idMessageRoom: widget.idMessageRoom,
              ),
              builder: (BuildContext context, AsyncSnapshot<Room> snapshot) {
                Widget child;
                if (snapshot.hasData) {
                  messages = snapshot.data!.messages;
                  stateIdMessageRoom = snapshot.data!.id;
                  child = Stack(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, i) {
                            if (messages[i].idSender == widget.idSender) {
                              return ChatFromSender(
                                  message: messages[i].message);
                            } else if (messages[i].idSender !=
                                widget.idSender) {
                              return ChatFromReceiver(
                                  message: messages[i].message);
                            }
                            return Container();
                          },
                        ),
                      ),
                      FormSendMessage(
                        idMessageRoom: stateIdMessageRoom,
                        sendMessage: sendMessage,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  child = Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        )
                      ],
                    ),
                  );
                } else {
                  child = Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(height: 10),
                        Text("Loading...")
                      ],
                    ),
                  );
                }
                return child;
              }),
        ),
      ),
    );
  }
}

class FormSendMessage extends StatefulWidget {
  final int? idMessageRoom;
  final Function sendMessage;
  const FormSendMessage(
      {required this.idMessageRoom, required this.sendMessage, Key? key})
      : super(key: key);

  @override
  State<FormSendMessage> createState() => _FormSendMessageState();
}

class _FormSendMessageState extends State<FormSendMessage> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Row(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await widget.sendMessage(message.text.toString());
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}

class ChatFromSender extends StatelessWidget {
  final String message;
  const ChatFromSender({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatFromReceiver extends StatelessWidget {
  final String message;

  const ChatFromReceiver({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

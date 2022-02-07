// list chat conversation id user
// conversation people, cari semua conversation dengan id user
// list conversation tersebut di chat

// LIST ALL CHAT MASUK => SEMUA ROOM ID USER
import 'package:app_book_septianton/models/message.dart';
import 'package:app_book_septianton/services/messsage.dart';
import 'package:app_book_septianton/utils/builder.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  final int idSender;
  const ChatList({required this.idSender, Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  TextEditingController idSenderController = TextEditingController();
  int idSender = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: idSenderController,
            onEditingComplete: () {
              print("editing complete");
              print(int.parse(idSenderController.text.toString()));
              setState(() {
                idSender = int.parse(idSenderController.text.toString());
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<Message>>(
            future: getMessagesSender(idSender: idSender),
            builder:
                (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
              Widget child;
              if (snapshot.hasData) {
                List<Message> messages = snapshot.data!;
                child = ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, i) {
                      return ItemChatSender(
                        nama: messages[i].nameReceiver,
                        idSender: idSender,
                        idReceiver: messages[i].idReceiver,
                        idMessageRoom: messages[i].idMessageRoom,
                        lastMessage: messages[i].message, // first message
                      );
                    });
              } else if (snapshot.hasError) {
                child = hasError();
              } else {
                child = loading();
              }
              return child;
            },
          ),
        ],
      ),
    );
  }
}

// LIST ITEM PESAN YANG TELAH DIKIRIMKAN
class ItemChatSender extends StatefulWidget {
  final String nama;
  final int idSender;
  final int idReceiver;
  final int? idMessageRoom;
  final String lastMessage;
  const ItemChatSender({
    required this.nama,
    required this.idSender,
    required this.idReceiver,
    required this.idMessageRoom,
    required this.lastMessage,
    Key? key,
  }) : super(key: key);

  @override
  _ItemChatSenderState createState() => _ItemChatSenderState();
}

class _ItemChatSenderState extends State<ItemChatSender> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        VNavigation.gotoChat(context, widget.idSender, widget.idReceiver,
            widget.idMessageRoom, widget.nama);
      },
      child: ListTile(
        title: Text(widget.nama),
        subtitle: Text(widget.lastMessage),
      ),
    );
  }
}

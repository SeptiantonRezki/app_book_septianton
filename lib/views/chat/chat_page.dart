import 'package:app_book_septianton/services/messsage.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: getMessages(idClient: 1, idConversation: 1),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  Widget child;
                  if (snapshot.hasData) {
                    var messages = snapshot.data!;
                    child = Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, i) {
                          if (messages[i]["status"] == "sender") {
                            return ChatFromSender(
                                message: messages[i]["message"]);
                          } else if (messages[i]["status"] == "receiver") {
                            return ChatFromReceiver(
                                message: messages[i]["message"]);
                          }
                          return Container();
                        },
                      ),
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
          const FormSendMessage(),
        ],
      ),
    );
  }
}

class FormSendMessage extends StatelessWidget {
  const FormSendMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
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
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
            ),
          ],
        ),
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

import 'package:app_book_septianton/views/book/book_page.dart';
import 'package:app_book_septianton/views/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const HomePageSampe(),
      // home: const ChatPage(),
      home: const BookPage(),
    );
  }
}

class HomePageSampe extends StatefulWidget {
  const HomePageSampe({Key? key}) : super(key: key);

  @override
  _HomePageSampeState createState() => _HomePageSampeState();
}

class _HomePageSampeState extends State<HomePageSampe> {
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    connectIO();
    // IO.Socket socket = IO.io('http://192.168.56.1:5000');
    // socket.connect();
    // socket.onConnect((_) {
    //   print('connect');
    //   socket.emit('msg', 'test');
    // });
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
  }

  void connectIO() {
    socket = IO.io('http://192.168.56.1:5000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket.connect();
    socket.onConnect((data) => print("Connected"));
    print(socket.connected);
    // event
    socket.emit("/test", "Hello world");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home page"),
      ),
    );
  }
}

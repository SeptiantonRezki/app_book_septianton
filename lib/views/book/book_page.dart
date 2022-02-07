import 'package:app_book_septianton/views/auth/auth_page.dart';
import 'package:app_book_septianton/views/book/author/author_list.dart';
import 'package:app_book_septianton/views/book/book_bookmart.dart';
import 'package:app_book_septianton/views/book/book_list.dart';
import 'package:app_book_septianton/views/book/book_search.dart';
import 'package:app_book_septianton/views/chat/chat_list.dart';
import 'package:app_book_septianton/views/user/user_page.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List views = [];
  int view = 0;
  changeView(int page) {
    setState(() {
      view = page;
    });
  }

  @override
  void initState() {
    super.initState();
    views = [
      const BookList(),
      const AuthorList(),
      const BookSearch(),
      const BookBookmart(),
      // const AuthPage(),
      const ChatList(idSender: 1),
      // const UserPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: views.elementAt(view),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        changeView(0);
                      },
                      icon: const Icon(Icons.home),
                      tooltip: 'Author',
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        changeView(1);
                      },
                      icon: const Icon(Icons.add_moderator_sharp),
                      tooltip: 'Author',
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        changeView(2);
                      },
                      icon: const Icon(Icons.search),
                      tooltip: 'Author',
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        changeView(3);
                      },
                      icon: const Icon(Icons.bookmark),
                      tooltip: 'Bookmark',
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        changeView(4);
                      },
                      icon: const Icon(Icons.login),
                      tooltip: 'Bookmark',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app_book_septianton/models/book.dart';
import 'package:app_book_septianton/services/book.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class BookDetail extends StatefulWidget {
  final int id;
  const BookDetail({required this.id, Key? key}) : super(key: key);
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final bool _pinned = false;
  final bool _snap = false;
  final bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        VNavigation.gotoNavigation(context);
        return false;
      },
      child: Scaffold(
        body: FutureBuilder<Book>(
          future: getBook(id: widget.id),
          builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
            List<Widget> children;
            Book book = snapshot.data ?? Book.initial();
            if (snapshot.hasData) {
              children = <Widget>[
                const Text("Judul",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(book.title, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                //
                const Text("Pengarang",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(book.author, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                //
                const Text("Kota Terbit",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(book.country, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                //
                const Text("Bahasa",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(book.language, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                //
                const Text("Jumlah Halaman",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(book.pages.toString(),
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                //
                const Text("Tahun terbit",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(book.year.toString(),
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: _pinned,
                  snap: _snap,
                  floating: _floating,
                  expandedHeight: 500.0,
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.network(
                        book.imageLink,
                        fit: BoxFit.fitHeight,
                      ))
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

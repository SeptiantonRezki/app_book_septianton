import 'package:app_book_septianton/models/book.dart';
import 'package:app_book_septianton/services/book.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class BookSearch extends StatefulWidget {
  const BookSearch({Key? key}) : super(key: key);

  @override
  _BookSearchState createState() => _BookSearchState();
}

class _BookSearchState extends State<BookSearch> {
  List<Book> books = [];

  getBooksFromAPI({String search = ""}) {
    getBooks(search: search, limit: "no-limit")!.then((value) {
      setState(() {
        books = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getBooksFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        VNavigation.gotoNavigation(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Autocomplete<Book>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return books
                    .where((Book continent) => continent.title
                        .toLowerCase()
                        .startsWith(textEditingValue.text.toLowerCase()))
                    .toList();
              },
              displayStringForOption: (Book option) => option.title,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: TextField(
                    onChanged: (e) {
                      getBooksFromAPI(search: e);
                    },

                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                    // style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
              onSelected: (Book selection) {
                // print('Selected: ${selection.title}');
                VNavigation.gotoDetailBook(context, selection.id);
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<Book> onSelected,
                  Iterable<Book> options) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + 0),
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 100, left: 0, right: 0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Book option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                              VNavigation.gotoDetailBook(context, option.id);
                            },
                            child: ListTile(
                              title: Text(option.title,
                                  style: const TextStyle(color: Colors.black)),
                              subtitle: Text(option.author,
                                  style: const TextStyle(color: Colors.grey)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

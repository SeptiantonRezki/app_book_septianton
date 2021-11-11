import 'package:app_book_septianton/models/author.dart';
import 'package:app_book_septianton/services/book.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class AuthorList extends StatefulWidget {
  const AuthorList({Key? key}) : super(key: key);

  @override
  _AuthorListState createState() => _AuthorListState();
}

class _AuthorListState extends State<AuthorList> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;
    return SingleChildScrollView(
      child: FutureBuilder<List<Author>>(
        future: getAuthors(),
        builder: (BuildContext context, AsyncSnapshot<List<Author>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              const Text("Author"),
              const SizedBox(height: 10),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: widthScreen / heightScreen * 5,
                mainAxisSpacing: 18,
                crossAxisSpacing: 14,
                shrinkWrap: true,
                children: snapshot.data!.map((e) {
                  return SizedBox(
                    height: 20,
                    child: GestureDetector(
                      onTap: () {
                        VNavigation.gotoAuthorBooks(context, e.name);
                      },
                      child: Container(
                        color: Colors.blue,
                        child: ListTile(
                            title: Text(
                              e.name,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              "books : ${e.books.toString()}",
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  );
                }).toList(),
              ),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

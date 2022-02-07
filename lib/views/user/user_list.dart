import 'package:app_book_septianton/models/user.dart';
import 'package:app_book_septianton/services/user.dart';
import 'package:app_book_septianton/utils/builder.dart';
import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            List<User> users = snapshot.data!;
            child = ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (BuildContext context, i) {
                  return ListTile(
                    onTap: () {
                      VNavigation.gotoChat(
                          context, 1, users[i].id, users[i].id, "sample");
                    },
                    title: Text(users[i].name),
                    subtitle: Text("status..."),
                    leading: Text("tes"),
                    trailing: Text("tes"),
                  );
                });
          } else if (snapshot.hasError) {
            child = hasError();
          } else {
            child = loading();
          }
          return child;
        });
  }
}

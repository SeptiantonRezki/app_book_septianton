import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        VNavigation.gotoNavigation(context);
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                VNavigation.gotoLogin(context);
              },
              child: const Text("Login Page"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                VNavigation.gotoRegister(context);
              },
              child: const Text("Register Page"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: idController, keyboardType: TextInputType.number),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                int myInt = int.parse(idController.text);
                assert(myInt is int);
                VNavigation.gotoChat(context, myInt, 2, 1, "sample");
              },
              child: const Text("Chat Page"),
            ),
          ],
        ),
      ),
    );
  }
}

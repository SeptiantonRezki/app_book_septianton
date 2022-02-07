import 'package:app_book_septianton/utils/v_navigation.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
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
            TextFormField(
              controller: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Register")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                VNavigation.gotoNavigation(context);
              },
              child: const Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}

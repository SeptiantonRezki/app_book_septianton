import 'package:app_book_septianton/models/user.dart';
import 'package:flutter/material.dart';

Widget widgetBuilder(
    AsyncSnapshot<List<User>> snapshot, Widget customWidgetReturn) {
  Widget child;
  if (snapshot.hasData) {
    child = Container();
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
}

Widget hasError() {
  Widget child = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Something Error'),
        )
      ],
    ),
  );
  return child;
}

Widget loading() {
  Widget child = Center(
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
  return child;
}

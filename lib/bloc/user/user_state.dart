part of 'user_bloc.dart';
// https://bloclibrary.dev/#/flutterweathertutorial
// https://github.com/felangel/bloc/tree/master/examples/flutter_weather

// TEST DARI CLASS (SEPERTI CLASS.FROMJSON), 2. KEMUDIANR REPO KITA TEST (YANG MENRIMA DATA DARI API)
// 3. TEST WIDGET

// kenapa menggunakan EXPORT di flutter => lebih clean saat nantinya IMPORT banyak FILE || barrel file

// SALAHKU DIISINI
// 1. Seharusnya user hanya masuk sebuah model
// 2. Yang menjadi bloc adalah event => seperti log in / sign up => class LoginState extends Equatable {} dan class SignUpState extends Equatable {}
// 3. Yang menjadi repositoy adalah yang konek ke api => Kelas yang menhadle errornya dan function yang get data api
// contoh :
// CLASS
// class LogInWithGoogleFailure implements Exception {} HANDLE GAGAL
// class LogOutFailure implements Exception {} HANDLE GAGAL
// class AuthenticationRepository {} HANDLE BERHASIL
// FUNCTION
// Future<void> logInWithEmailAndPassword({ }){}
// Future<void> logInWithGoogle() async {}

// repo folder sejajar dengan test dan lib yaitu bernama packages
// repository hanya peduli APA dan tidak peduli dengan BAGAIMAN, hanya call function yang sudah ada pada  final MetaWeatherApiClient _weatherApiClient;
// contoh nama kelas class WeatherRepository

// bagaiamana menggunakan //   json_serializable: ^4.0.0
//   mocktail: ^0.2.0 => BIAR CODING RAPI DAN LEBIH BISA DI BACA DAN AUTO GENERATE

// hydrated_bloc => untuk mempertahnakan state ketika user aplikasi di close
// equatable membandingkan Orang(name: "Anton") == Orang(name: "Anton") => TRUE
// path provider ????
// memisahkan repo

// name: flutter_weather
// description: A new Flutter project.
// version: 1.0.0+1
// publish_to: none

// environment:
//   sdk: ">=2.13.0 <3.0.0"

// dependencies:
//   flutter:
//     sdk: flutter
//   equatable: ^2.0.3
//   flutter_bloc: ^8.0.0
//   flutter_services_binding: ^0.1.0
//   google_fonts: ^2.1.0
//   hydrated_bloc: ^8.0.0
//   json_annotation: ^4.0.0
//   path_provider: ^2.0.3
//   weather_repository:
//     path: packages/weather_repository

// dev_dependencies:
//   flutter_test:
//     sdk: flutter
//   bloc_test: ^9.0.0
//   build_runner: ^1.10.0
//   json_serializable: ^4.0.0
//   mocktail: ^0.2.0

// flutter:
//   uses-material-design: true
//   assets:
//     - assets/

@immutable
abstract class UserState extends Equatable {
  // const UserState(
  //   this.id,
  //   this.name,
  // );

  // final int id;
  // final String name;
}

class UserInitial extends UserState {
  // const UserInitial();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

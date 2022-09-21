import 'package:blitz_score/utilities/player_utils.dart';
import 'package:flutter/material.dart';
import 'screens/score_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var playerUtils = PlayerUtils();
  bool databaseIsEmpty = await playerUtils.isEmpty();
  runApp(MyApp(databaseIsEmpty: databaseIsEmpty));
}

class MyApp extends StatelessWidget {
  final bool databaseIsEmpty;
  const MyApp({Key? key, required this.databaseIsEmpty}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          ),
        ),
      ),
      home: ScorePage(databaseIsEmpty: databaseIsEmpty),
    );
  }
}

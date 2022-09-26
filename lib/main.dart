import 'package:blitz_score/l10n/l10n.dart';
import 'package:blitz_score/screens/score_page.dart';
import 'package:blitz_score/utilities/player_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          ),
        ),
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: ScorePage(databaseIsEmpty: databaseIsEmpty),
    );
  }
}

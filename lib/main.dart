import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'Constants/colors.dart';
import 'Screens/home_page.dart';
import 'provider/note_provider.dart';
import 'services/sqlite.dart';

void main() async {
  // this is for safearea to be with specific color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(200, 184, 163, 1)));
  // entry point of the app
  WidgetsFlutterBinding
      .ensureInitialized(); // force initialization ans must use while suing async in main
  await SQLite.init(); // initialize the sqlite database

  runApp(//root of the app
      MultiProvider(providers: [
    //multiprovider this is a widget that provides data to multiple widgets
    ChangeNotifierProvider<NoteProvider>(
      //type of provider that mange the the state
      create: (_) => NoteProvider(),
    ),
  ], child: const MyApp())); //myapp here is child of multiprovider widget so it has access to the state
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  //build fuction that responsible for building the widgets
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: meduimBrown,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                foregroundColor: Colors.white, backgroundColor: darkBrown),
            cardTheme: CardTheme.of(context).copyWith(
              color: lightBrown.withOpacity(0.6),
            )), //i used copywith to change just the color proberite and keep the another proberites of the cardtheme
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (BuildContext context) => const HomeScreen(),
          // AddNoteScreen.id: (context) => const AddNoteScreen(),
        });
  }
}
//done

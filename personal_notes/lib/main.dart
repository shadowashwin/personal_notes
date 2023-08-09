import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personal_notes/model/notes_model.dart';
import 'package:rive/rive.dart';
import 'package:path_provider/path_provider.dart';
import 'HomeScreen.dart';
import 'package:personal_notes/colors.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>("notes");

  runApp( const NotesMaker());
}

class NotesMaker extends StatelessWidget{
  const NotesMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes_Maker",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
         primarySwatch: Colors.orange
      ),
      home: const SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: mq.size.height * 1,
        width: mq.size.width * 1,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splashscreen.png'),fit: BoxFit.cover)),
        child: Stack(
          children:  [
            const RiveAnimation.asset('assets/rive_animation/writing-girl.riv'),
            Column(
              children: [
                SizedBox(
                  height: mq.size.height * 0.66,
                ),
                Container(
                  height: mq.size.height * 0.2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/diarydigest.png")),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}










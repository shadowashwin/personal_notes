import 'dart:ui';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/boxes/boxes.dart';
import 'package:personal_notes/model/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'Show_EditData.dart';
import 'dataentry.dart';
import 'error_message/error_warning.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Diary Digest",
            style: TextStyle(
                color: Colors.orangeAccent, fontFamily: "logo", fontSize: 25)),
      ),
      body: Container(
          // color: Colors.blue,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7],
            colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
          )),
          height: mq.size.height * 1,
          width: mq.size.width * 1,
          child: ValueListenableBuilder<Box<NotesModel>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                var data = box.values.toList().cast<NotesModel>();
                return ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: GlassmorphicContainer(
                          margin: EdgeInsets.only(top: mq.size.height * 0.01),
                          height: mq.size.height * 0.12,
                          width: mq.size.width * 0.95,
                          borderRadius: 15,
                          linearGradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white38.withOpacity(0.2)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderGradient: LinearGradient(colors: [
                            Colors.white24.withOpacity(0.2),
                            Colors.white70.withOpacity(0.2)
                          ]),
                          border: 2,
                          blur: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].title.toString().toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: mq.size.width * 0.05,
                                    ),
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.008,
                                  ),
                                  Text(
                                    data[index].description.toString(),
                                    style: TextStyle(
                                        overflow: TextOverflow.visible,
                                        color: Colors.white70,),
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      // SizedBox(
                                      //   width: mq.size.width * 0.39,
                                      // ),
                                      // InkWell(
                                      //   onTap: () => editDialogue(data[index],data[index].title.toString(),data[index].title.toString()),
                                      //     child: const Icon(Icons.edit)),
                                      // SizedBox(
                                      //   width: mq.size.width * 0.05,
                                      // ),
                                      InkWell(
                                          onTap: () => delete(data[index]),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Show_EditData(index)));
                              },
                            ),
                          ),
                        ),
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          // _showMyDialogue();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DataEntry()));
        },
        // hoverColor: Colors.transparent,
        // splashColor: Colors.transparent,
        child: const Icon(Icons.add, color: Colors.deepOrange),
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  // Future<void> editDialogue(NotesModel notesModel,String title,String description) async {
  //
  //   titlecontroller.text = title;
  //   descriptioncontroller.text = description;
  //
  //   return showDialog(
  //       context: context,
  //       builder: (context){
  //         return AlertDialog(
  //           title: const Text("Edit notes"),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 TextFormField(
  //                   controller: titlecontroller,
  //                   decoration: const InputDecoration(
  //                       hintText: 'Enter Title',
  //                       border: OutlineInputBorder()
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20,),
  //                 TextFormField(
  //                   controller: descriptioncontroller,
  //                   decoration: const InputDecoration(
  //                       hintText: 'Enter Description',
  //                       border: OutlineInputBorder()
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(onPressed: (){
  //               Navigator.pop(context);
  //             },child: const Text("Cancel")),
  //
  //             TextButton(onPressed: () async {
  //
  //               notesModel.title = titlecontroller.text.toString();
  //               notesModel.description = descriptioncontroller.text.toString();
  //               notesModel.save();
  //               titlecontroller.clear();
  //               descriptioncontroller.clear();
  //               Navigator.pop(context);
  //             }, child: const Text('Edit'))
  //           ],
  //         );
  //       }
  //   );
  // }
}

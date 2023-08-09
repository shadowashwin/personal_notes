import 'dart:ui';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'boxes/boxes.dart';
import 'error_message/error_warning.dart';
import 'model/notes_model.dart';

class DataEntry extends StatefulWidget {
  const DataEntry({Key? key}) : super(key: key);

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {

  SpeechToText speechToText = SpeechToText();

  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  var title = "Title";
  var isListening = false;
  var text = "";

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async{
            if(!isListening){
              var available = await speechToText.initialize();
              if(available){
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      text = result.recognizedWords;
                      // descriptioncontroller.text = descriptioncontroller.text + text;
                    },
                  );
                });

              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            child: Icon(
              isListening ? Icons.mic_none : Icons.mic,
              color: Colors.deepOrange,
              size: 30,
            ),
          ),
        ),
      ),
      body: Container(
        width: mq.size.width * 1,
        height: mq.size.height * 1,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.7],
          colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
        )),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    right: mq.size.width * 0.02, left: mq.size.width * 0.02),
                width: mq.size.width * 1,
                height: mq.size.height * 0.13,
                decoration: const BoxDecoration(color: Colors.white
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.grey.shade600,
                    //       spreadRadius: 1,
                    //       blurRadius: 15,
                    //       offset: const Offset(0, 15)
                    //   )
                    // ]
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mq.size.height * 0.04,
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Icon(Icons.close,
                              color: Colors.deepOrange,
                              size: mq.size.width * 0.09),
                          onTap: () => _cancel(),
                        ),
                        const Spacer(),
                        InkWell(
                          child: Icon(Icons.check,
                              color: Colors.green, size: mq.size.width * 0.09),
                          onTap: () {
                            _saveData();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mq.size.height * 0.004,
                    ),
                    InkWell(
                      child: Center(
                        child: Text(title,
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: mq.size.width * 0.08,
                            )),
                      ),
                      onTap: () {
                        _showMyDialogue();
                      },
                    )
                  ],
                )),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    left: mq.size.width * 0.03, right: mq.size.width * 0.02),
                padding: EdgeInsets.only(
                    right: mq.size.width * 0.02, left: mq.size.width * 0.02),
                width: mq.size.width * 1,
                // height: mq.size.height * 0.87,
                child: SingleChildScrollView(
                  child: Center(
                    child: TextFormField(
                      minLines: 2,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      controller: descriptioncontroller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Description',
                          hintStyle: TextStyle(color: Colors.white60)
                          // border: OutlineInputBorder()
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialogue() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add title"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titlecontroller,
                    decoration: const InputDecoration(
                        hintText: 'Enter Title', border: OutlineInputBorder()),
                  ),
                  // const SizedBox(height: 20,),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.orange),
                  )),
              TextButton(
                  onPressed: () {
                    title = titlecontroller.text;
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.orange),
                  ))
            ],
          );
        });
  }

  Future<void> _cancel() async {
    Navigator.pop(context);
  }

  Future<void> _saveData() async {
    final data = NotesModel(
        title: titlecontroller.text, description: descriptioncontroller.text);
    final box = Boxes.getData();
    if (titlecontroller.text.trim() == "") {
      Message.errororwarning("Title error!!", "Title is empty");
    } else if (descriptioncontroller.text.trim() == "") {
      print("fuck");
      // Message.errororwarning("Description error!!", "Description is empty");
    }
    Message.errororwarning("Title error!!", "Title is empty");
    box.add(data);
    data.save();
    titlecontroller.clear();
    descriptioncontroller.clear();
    Navigator.pop(context);
  }
}

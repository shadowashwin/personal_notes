import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/notes_model.dart';

class Show_EditData extends StatefulWidget {

  var index;
  Show_EditData(this.index);

  @override
  State<Show_EditData> createState() => _Show_EditDataState(index);
}

class _Show_EditDataState extends State<Show_EditData> {

  var index;
  _Show_EditDataState(this.index);

  final TextEditingController descriptioncontoller = TextEditingController();
  final TextEditingController titlecontroller = TextEditingController();

  late Box<NotesModel> homebox;

  @override
  void initState(){
    super.initState();
    homebox = Hive.box("notes");

  }


  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    final note_data = homebox.getAt(index) as NotesModel;
    descriptioncontoller.text = note_data.description.toString();
    titlecontroller.text = note_data.title.toString();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.7],
              colors: [Colors.orangeAccent,Colors.deepOrangeAccent],
            )),
        child: Column(
          children: [
            // (descriptioncontoller.text.isEmpty) ? Text("Enter the description") : Text("${descriptioncontoller.value.text}"),
            Container(
                padding: EdgeInsets.only(right: mq.size.width * 0.02, left: mq.size.width * 0.02),
                width: mq.size.width * 1,
                height: mq.size.height * 0.13,
                decoration: const BoxDecoration(
                    color: Colors.white,
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
                              size: mq.size.width * 0.09
                          ),
                          onTap: () => _cancel(),
                        ),
                        const Spacer(),
                        InkWell(
                          child: Icon(Icons.check,
                              color: Colors.green,
                              size: mq.size.width * 0.09
                          ),
                          onTap: () {
                            note_data.title = titlecontroller.text.toString();
                            note_data.description = descriptioncontoller.text.toString();
                            note_data.save();
                            titlecontroller.clear();
                            descriptioncontoller.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                        height: mq.size.height * 0.004,
                    ),

                    InkWell(
                      child: Center(
                        child: Text(note_data.title.toString(),
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: mq.size.width * 0.08,)),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: const Text("Edit title"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: titlecontroller,
                                        decoration: const InputDecoration(
                                            hintText: 'Enter Title',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey, width: 0.0),
                                            ),
                                  //           focusedBorder: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(25.0),
                                  //   borderSide:  BorderSide(color: Colors.pinkAccent ),
                                  //
                                  // ),
                                        ),
                                      ),
                                      // const SizedBox(height: 20,),

                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  },child: const Text("Cancel")),

                                  TextButton(onPressed: (){
                                    note_data.title = titlecontroller.text;
                                    Navigator.pop(context);
                                  }, child: const Text('Ok'))
                                ],
                              );
                            }
                        );
                      },
                    )
                  ],
                )
            ),


            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(right: mq.size.width * 0.02, left: mq.size.width * 0.02, top: mq.size.width * 0.02),
                padding: EdgeInsets.only(right: mq.size.width * 0.02, left: mq.size.width * 0.02),
                width: mq.size.width * 1,
                // height: mq.size.height * ,
                child: TextFormField(
                  minLines: 1,
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  controller: descriptioncontoller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(color: Colors.white60),
                    border: InputBorder.none,
                    // border: OutlineInputBorder()
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

  Future<void> _cancel() async {
    Navigator.pop(context);
  }


}


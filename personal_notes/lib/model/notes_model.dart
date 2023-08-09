import 'package:hive/hive.dart';
part 'notes_model.g.dart';   //flutter packages pub run build_runner build   IN TERMINAL


@HiveType(typeId: 0)
class NotesModel extends HiveObject{

  @HiveField(0,defaultValue: "title_")
  String title;
  
  @HiveField(1)
  String description;

  NotesModel({ required this.title, required this.description });


}
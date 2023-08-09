
import 'package:hive/hive.dart';
import 'package:personal_notes/model/notes_model.dart';

class Boxes{

  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');

}
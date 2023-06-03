import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  Todo({this.title = "", this.description = ""});
}

import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/todo.dart';

final todoBoxProvider = FutureProvider<Box<Todo>>(
  (ref) => Hive.openBox<Todo>("todos"),
);

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/providers/todo_box_provider.dart';
import '../models/todo.dart';

final todoProvider = FutureProvider<List<Todo>>((ref) async {
  final box = await ref.watch(todoBoxProvider.future);
  return box.values.toList();
});

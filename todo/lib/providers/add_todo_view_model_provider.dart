import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/providers/todo_box_provider.dart';
import 'package:todo/providers/todo_provider.dart';
import '../models/todo.dart';

final addTodoViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => WriteToDoModel(ref));

class WriteToDoModel extends ChangeNotifier {
  final Ref _ref;

  WriteToDoModel(this._ref);

  Todo todo = Todo();

  bool get isEditing => todo.key != null;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void init(Todo todo) {
    if (this.todo.key == null) {
      this.todo = todo;
    }
  }

  Future<void> write() async {
    loading = true;
    try {
      final box = await _ref.read(todoBoxProvider.future);
      if (isEditing) {
        await box.put(todo.key, todo);
      } else {
        await box.add(todo);
      }
      _ref.refresh(todoProvider);
    } catch (e) {
      loading = false;
      return Future.error(e);
    }
  }
}

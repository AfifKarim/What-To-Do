import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/todo_box_provider.dart';
import '../providers/todo_provider.dart';

final repositoryProvider = Provider((ref) => Repository(ref));

class Repository {
  final Ref _ref;
  Repository(this._ref);
  Future<void> deleteTodo(dynamic key) async {
    final box = await _ref.read(todoBoxProvider.future);
    await box.delete(key);
    _ref.refresh(todoProvider);
  }
}

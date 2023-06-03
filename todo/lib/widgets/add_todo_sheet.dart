import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/todo.dart';
import '../providers/add_todo_view_model_provider.dart';

class TodoSheet extends HookConsumerWidget {
  const TodoSheet({super.key,this.todo});

  final Todo? todo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final model = ref.watch(addTodoViewModelProvider);
    if(todo != null){
      model.init(todo!);
    }
    final formKey = useRef(GlobalKey<FormState>());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: formKey.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${model.isEditing ? "Edit": "Create"} To Do",
                style: style.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                "Title",
                style: style.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: model.todo.title,
                onSaved: (value) => model.todo.title = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(),
              ),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: style.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: model.todo.description,
                onSaved: (value) => model.todo.description = value!,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              model.loading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : MaterialButton(
                color: scheme.primaryContainer,
                textColor: scheme.onPrimaryContainer,
                onPressed: () async {
                  if (formKey.value.currentState!.validate()) {
                    formKey.value.currentState!.save();
                    try {
                      await model.write();
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

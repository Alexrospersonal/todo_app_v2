import 'package:flutter/material.dart';
import 'package:todo_app_v2/home/cubit/home_cubit.dart';

class FloatingNavButton extends StatelessWidget {
  const FloatingNavButton({
    required this.tab,
    required this.callback,
    super.key,
  });

  final HomeTab tab;

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      height: 54,
      width: 54,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            strokeAlign: 0,
            width: 6,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        onPressed: callback,
        child: Icon(
          tab == HomeTab.list || tab == HomeTab.calendar
              ? Icons.add
              : Icons.done,
        ),
      ),
    );
  }
}

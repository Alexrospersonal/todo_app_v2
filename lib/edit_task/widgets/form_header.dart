import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/home/cubit/home_cubit.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        GestureDetector(
          onTap: () => context.read<HomeCubit>().setTab(HomeTab.list),
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.error,
            size: 24,
          ),
        ),
      ],
    );
  }
}

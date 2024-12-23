import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todo_app_v2/theme/theme.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditTaskBloc, EditTaskState, AccentColor>(
      selector: (state) => state.color,
      builder: (context, selectedColor) {
        final colors = AccentColor.values.map(
          (e) => ColorPickerItem(
            selectedColor: selectedColor,
            color: e,
          ),
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 67,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: RadialGradient(
                  colors: [
                    selectedColor.color,
                    Theme.of(context).colorScheme.secondaryContainer,
                  ],
                  radius: 1.3,
                  center: Alignment.centerRight,
                ),
              ),
            ),
            ...colors,
          ],
        );
      },
    );
  }
}

class ColorPickerItem extends StatelessWidget {
  const ColorPickerItem({
    required this.color,
    required this.selectedColor,
    super.key,
  });

  final AccentColor color;
  final AccentColor selectedColor;

  @override
  Widget build(BuildContext context) {
    final isSelected = color == selectedColor;

    return GestureDetector(
      onTap: () =>
          context.read<EditTaskBloc>().add(EditTaskColorChanged(color: color)),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.transparent,
            width: isSelected ? 2 : 0,
          ),
          color: color.color,
        ),
      ),
    );
  }
}

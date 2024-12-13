import 'package:flutter/material.dart';
import 'package:todo_app_v2/edit_task/widgets/form_header.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/theme/theme.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListView();
  }
}

class ListView extends StatefulWidget {
  const ListView({super.key});

  @override
  State<ListView> createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
  final _formKey = GlobalKey<FormState>();

  final categories = [
    (1, '🌞TODAY'),
    (2, '🏠HOME'),
    (3, '🏋🏼GYM'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormHeader(
            title: l10n.createTaskTitle,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              hintText: 'Enter a name',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  26,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: (value) {},
                  value: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.secondaryContainer,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    isCollapsed: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(
                        26,
                      ),
                    ),
                  ),
                  items: categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category.$1,
                          child: Text(category.$2),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                // width: 20,
                height: 34,
                child: IconButton.filled(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.account_tree_rounded),
                ),
              ),
              SizedBox(
                // width: 20,
                height: 34,
                child: IconButton.filled(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.calendar_month_sharp),
                ),
              ),
              SizedBox(
                // width: 20,
                height: 34,
                child: IconButton.filled(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.star_rounded),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 67,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: RadialGradient(
                    colors: [
                      AccentColor.blue.color,
                      Theme.of(context).colorScheme.secondaryContainer,
                    ],
                    radius: 1.3,
                    center: Alignment.centerRight,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 2,
                    ),
                    color: AccentColor.main.color,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2,
                    ),
                    color: AccentColor.blue.color,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 0,
                    ),
                    color: AccentColor.green.color,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 0,
                    ),
                    color: AccentColor.orange.color,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 0,
                    ),
                    color: AccentColor.red.color,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 0,
                    ),
                    color: AccentColor.pink.color,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 0,
                    ),
                    color: AccentColor.purple.color,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 0,
                    ),
                    color: AccentColor.seaGreen.color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

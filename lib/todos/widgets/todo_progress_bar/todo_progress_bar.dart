import 'package:flutter/material.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todo_app_v2/todos/widgets/widgets.dart';

class TodoProgressBar extends StatefulWidget {
  const TodoProgressBar({super.key});

  @override
  State<TodoProgressBar> createState() => _TodoProgressBarState();
}

class _TodoProgressBarState extends State<TodoProgressBar> {
  bool isOpen = false;
  double progressInPersent = 0.7;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Container(
              height: 5,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    blurRadius: 1,
                    //   spreadRadius: -20,
                  ),
                  BoxShadow(
                    color: glowColor,
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isOpen
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          if (details.primaryDelta! < 0) {
                            setState(() {
                              isOpen = false;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: [
                              ExpandedCircleProgressBar(
                                percent: progressInPersent,
                              ),
                              const Expanded(
                                child: ExpandedDiagramWeekDetails(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app_v2/home/cubit/home_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.tab,
    required this.leftBtnCallback,
    required this.rightBtnCallback,
    super.key,
  });

  final HomeTab tab;
  final VoidCallback leftBtnCallback;
  final VoidCallback rightBtnCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [BoxShadow()]),
      margin: EdgeInsets.fromLTRB(16, 0, 16, Platform.isAndroid ? 16 : 0),
      child: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        height: 54,
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: leftBtnCallback,
                    child: Icon(
                      tab == HomeTab.list || tab == HomeTab.calendar
                          ? Icons.home_filled
                          : Icons.arrow_back_ios,
                      size: 34,
                    ),
                  ),
                  InkWell(
                    onTap: rightBtnCallback,
                    child: Icon(
                      tab == HomeTab.list || tab == HomeTab.calendar
                          ? Icons.calendar_month
                          : Icons.remove_circle_outline,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

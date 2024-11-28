import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_v2/home/bloc/home_bloc.dart';
import 'package:todo_app_v2/home/models/title_date_format_extension.dart';
import 'package:todo_app_v2/home/widgets/widget.dart';
import 'package:todo_app_v2/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

// TODO: додати кнопки у вигляді острову
// TODO: додати можливіст заміни контейнерів для списку та календаря
// TODO: додати стан в Блок щоб залежно він стану мінявся функціонал в нижнього меню
// TODO: рефактор коду
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  bool _isoOpenMenu = false;

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _scalAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _blurAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(
        title: DateFormat().formatDateForTitle(DateTime.now()),
        leading: GestureDetector(
          onTap: () {
            if (!_isoOpenMenu) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            setState(() {
              _isoOpenMenu = !_isoOpenMenu;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: AnimatedIcon(
              size: 48,
              icon: AnimatedIcons.menu_close,
              progress: _animation,
            ),
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.displaySmall,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(_animation.value * 270, 0),
                child: Transform.scale(
                  scale: _scalAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: _blurAnimation.value * 15,
                  sigmaY: _blurAnimation.value * 15,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                width: 270,
                left: _isoOpenMenu ? 0 : -270,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
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
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [BoxShadow()]),
        margin: EdgeInsets.fromLTRB(16, 0, 16, Platform.isAndroid ? 16 : 0),
        child: BottomAppBar(
          padding: EdgeInsets.symmetric(horizontal: 50),
          height: 54,
          elevation: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.home_filled,
                        size: 34,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.calendar_month,
                        size: 34,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

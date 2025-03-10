import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_v2/edit_task/view/view.dart';
import 'package:todo_app_v2/home/cubit/home_cubit.dart';
import 'package:todo_app_v2/home/models/title_date_format_extension.dart';
import 'package:todo_app_v2/home/widgets/widgets.dart';
import 'package:todo_app_v2/todos/todos.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  bool _isSettingsOpen = false;
  int prevStateIdx = -1;

  late AnimationController _animationController;
  late AnimationController _tabAnimationController;
  late Animation<double> _animation;
  late Animation<double> _tabAnimation;
  late Animation<double> _scalAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    _tabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

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

    _tabAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _tabAnimationController,
        curve: Curves.easeOut,
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
    _tabAnimationController.dispose();
    super.dispose();
  }

  List<Widget> getNestedTabs() {
    return <Widget>[
      AnimatedNestedContainer(
        translateAnimValue: _tabAnimation.value,
        child: const TodosPage(),
      ),
      AnimatedNestedContainer(
        translateAnimValue: _tabAnimation.value,
        child: Container(color: Colors.red),
      ),
      AnimatedNestedContainer(
        translateAnimValue: _tabAnimation.value,
        child: const ColoredBox(
          color: Color.fromARGB(255, 83, 83, 83),
          child: EditTaskPage(),
        ),
      ),
    ];
  }

  void updateTab(HomeTab tab) {
    // _tabAnimationController.reset();
    context.read<HomeCubit>().setTab(tab);
  }

  void showAndHideSideMenu() {
    if (!_isSettingsOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      _isSettingsOpen = !_isSettingsOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = getNestedTabs();
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    final tabIdx = selectedTab.index;

    _tabAnimationController.forward();

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.tab.index != prevStateIdx) {
          _tabAnimationController
            ..reset()
            ..forward();
          prevStateIdx = state.tab.index;
        }
      },
      listenWhen: (previous, current) => current != previous,
      child: Scaffold(
        appBar: CustomAppBar(
          title: DateFormat().formatDateForTitle(context, DateTime.now()),
          leading: GestureDetector(
            onTap: showAndHideSideMenu,
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
                MainStackContainer(
                  selectedTabIndex: tabIdx,
                  translateAnimValue: _animation.value,
                  scaleAnimValue: _scalAnimation.value,
                  opacityAnimValue: _opacityAnimation.value,
                  children: tabs,
                ),
                if (_isSettingsOpen)
                  BluringFilter(blurAnimationValue: _blurAnimation.value),
                SideBodyContainer(
                  isOpen: _isSettingsOpen,
                  child: const SidePanel(),
                ),
              ],
            ),
          ),
        ),
        // TODO: Додати можливість при створенні нового завдання, вибір категорії по замовчуванні
        //  змінити навігацію та прочитаи про неї
        floatingActionButton: FloatingNavButton(
          tab: selectedTab,
          callback: () => Navigator.of(context).push(EditTaskPage.route()),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavBar(
          tab: selectedTab,
          leftBtnCallback: () => updateTab(HomeTab.list),
          rightBtnCallback: () => updateTab(HomeTab.calendar),
        ),
      ),
    );
  }
}

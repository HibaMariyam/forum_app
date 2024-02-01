import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/common/cubit/main_cubit.dart';
import 'package:forum_app/features/create/views/create_view.dart';
import 'package:forum_app/features/home/views/home_view.dart';
import 'package:forum_app/features/profile/views/profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pages = [Homeview(), ProfileView(), CreateView()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) {
                  context.read<MainCubit>().setIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
              ]),
        );
      },
    );
  }
}

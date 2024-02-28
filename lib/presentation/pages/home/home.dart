import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';

import '../../../injector.dart';

class HomeWrapperProvider extends StatelessWidget {
  const HomeWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: const HomePage(title: "Flutter Demo Home Page 3"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String theme = "";

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  void getCurrentTheme() async {
    final currentTheme = await BlocProvider.of<HomeCubit>(context).getCurrentTheme();
    setState(() {
      theme = currentTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current Theme: $theme'),
            Switch(
              value: theme == 'light' ? false : true,
              onChanged: (value) {
                BlocProvider.of<HomeCubit>(context).toggleTheme();
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

}
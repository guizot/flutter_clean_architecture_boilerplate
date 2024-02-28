import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:provider/provider.dart';

import '../../../injector.dart';
import '../../core/services/theme_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<ThemeService> (
          builder: (context, ThemeService notifier, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Current Theme: ${notifier.themeMode.brightness}'),
                Switch(
                  value: notifier.themeMode.brightness == Brightness.light ? false : true,
                  onChanged: (value) {
                    BlocProvider.of<HomeCubit>(context).toggleTheme(notifier);
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                )
              ],
            );
          },
        )
      ),
    );
  }

}


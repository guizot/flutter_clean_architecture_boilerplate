import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/constant/routes_values.dart';
import 'package:flutter_clean_architecture/presentation/core/enums/navigation_enum.dart';
import 'package:flutter_clean_architecture/presentation/core/handler/navigation_handler.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/activity_stack_cubit.dart';

class ActivityStackWrapperProvider extends StatelessWidget {
  const ActivityStackWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ActivityStackCubit>(),
      child: const ActivityStackPage(title: "Activity Stack"),
    );
  }
}

class ActivityStackPage extends StatefulWidget {
  const ActivityStackPage({super.key, required this.title});
  final String title;

  @override
  State<ActivityStackPage> createState() => _ActivityStackPageState();
}

class _ActivityStackPageState extends State<ActivityStackPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
      builder: (context, ThemeService themeService, LanguageService languageService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => NavigationHandler().pop(context: context),
                  child: const Text('Pop'),
                ),
                ElevatedButton(
                  onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackA),
                  child: const Text('Navigate Push Screen A'),
                ),
                ElevatedButton(
                  onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackA),
                  child: const Text('Replace Current Stack With Screen A'),
                ),
                ElevatedButton(
                  onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackA),
                  child: const Text('Remove All Stack and Navigate A'),
                ),
                ElevatedButton(
                  onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackA),
                  child: const Text('Pop Current Stack and Navigate A'),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}


class ActivityStackA extends StatelessWidget {
  const ActivityStackA({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen A')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context),
              child: const Text('Pop'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackB),
              child: const Text('Navigate Push Screen B'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackB),
              child: const Text('Replace Current Stack With Screen B'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackB),
              child: const Text('Remove All Stack and Navigate B'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackB),
              child: const Text('Pop Current Stack and Navigate B'),
            )
          ],
        ),
      ),
    );
  }
}

class ActivityStackB extends StatelessWidget {
  const ActivityStackB({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen B')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context),
              child: const Text('Pop'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackC),
              child: const Text('Navigate Push Screen C'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackC),
              child: const Text('Replace Current Stack With Screen C'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackC),
              child: const Text('Remove All Stack and Navigate C'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackC),
              child: const Text('Pop Current Stack and Navigate C'),
            )
          ],
        ),
      ),
    );
  }
}

class ActivityStackC extends StatelessWidget {
  const ActivityStackC({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen C')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context),
              child: const Text('Pop'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackD),
              child: const Text('Navigate Push Screen D'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackD),
              child: const Text('Replace Current Stack With Screen D'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackD),
              child: const Text('Remove All Stack and Navigate D'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackD),
              child: const Text('Pop Current Stack and Navigate D'),
            )
          ],
        ),
      ),
    );
  }
}

class ActivityStackD extends StatelessWidget {
  const ActivityStackD({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen D')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context),
              child: const Text('Pop'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackE),
              child: const Text('Navigate Push Screen E'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackE),
              child: const Text('Replace Current Stack With Screen E'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackE),
              child: const Text('Remove All Stack and Navigate E'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackE),
              child: const Text('Pop Current Stack and Navigate E'),
            )
          ],
        ),
      ),
    );
  }
}

class ActivityStackE extends StatelessWidget {
  const ActivityStackE({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen E')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context),
              child: const Text('Pop'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackA),
              child: const Text('Pop Until Stack find Screen A'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackB),
              child: const Text('Pop Until Stack find Screen B'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackC),
              child: const Text('Pop Until Stack find Screen C'),
            ),
            ElevatedButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackD),
              child: const Text('Pop Until Stack find Screen D'),
            )
          ],
        ),
      ),
    );
  }
}
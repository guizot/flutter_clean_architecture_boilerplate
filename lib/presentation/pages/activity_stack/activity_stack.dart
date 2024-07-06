import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/constant/routes_values.dart';
import 'package:flutter_clean_architecture/presentation/core/enums/navigation_enum.dart';
import 'package:flutter_clean_architecture/presentation/core/handler/navigation_handler.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_button.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormButton(
                    onPressed: () => NavigationHandler().pop(context: context),
                    label: 'Pop'
                ),
                const SizedBox(height: 16.0),
                FormButton(
                    onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackA),
                    label: 'Navigate Push Screen A'
                ),
                const SizedBox(height: 16.0),
                FormButton(
                    onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackA),
                    label: 'Replace Current Stack With Screen A'
                ),
                const SizedBox(height: 16.0),
                FormButton(
                    onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackA),
                    label: 'Remove All Stack and Navigate A'
                ),
                const SizedBox(height: 16.0),
                FormButton(
                    onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackA),
                    label: 'Pop Current Stack and Navigate A'
                ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context),
              label: 'Pop'
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackB),
              label: 'Navigate Push Screen B'
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackB),
              label: 'Replace Current Stack With Screen B'
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackB),
              label: 'Remove All Stack and Navigate B'
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackB),
              label: 'Pop Current Stack and Navigate B'
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context),
              label: 'Pop',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackC),
              label: 'Navigate Push Screen C',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackC),
              label: 'Replace Current Stack With Screen C',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackC),
              label: 'Remove All Stack and Navigate C',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackC),
              label: 'Pop Current Stack and Navigate C',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context),
              label: 'Pop',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackD),
              label: 'Navigate Push Screen D',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackD),
              label: 'Replace Current Stack With Screen D',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackD),
              label: 'Remove All Stack and Navigate D',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackD),
              label: 'Pop Current Stack and Navigate D',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context),
              label: 'Pop',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, route: RoutesValues.stackE),
              label: 'Navigate Push Screen E',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateReplace, route: RoutesValues.stackE),
              label: 'Replace Current Stack With Screen E',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.navigateRemove, route: RoutesValues.stackE),
              label: 'Remove All Stack and Navigate E',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().navigate(context: context, navigation: NavigateEnum.popPush, route: RoutesValues.stackE),
              label: 'Pop Current Stack and Navigate E',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context),
              label: 'Pop',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackA),
              label: 'Pop Until Stack find Screen A',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackB),
              label: 'Pop Until Stack find Screen B',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackC),
              label: 'Pop Until Stack find Screen C',
            ),
            const SizedBox(height: 16.0),
            FormButton(
              onPressed: () => NavigationHandler().pop(context: context, navigation: PopEnum.popUntil, route: RoutesValues.stackD),
              label: 'Pop Until Stack find Screen D',
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/coachmark_cubit.dart';

class CoachMarkWrapperProvider extends StatelessWidget {
  const CoachMarkWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CoachMarkCubit>(),
      child: const CoachMarkPage(title: "Coach Mark"),
    );
  }
}

class CoachMarkPage extends StatefulWidget {
  const CoachMarkPage({super.key, required this.title});
  final String title;

  @override
  State<CoachMarkPage> createState() => _CoachMarkPageState();
}

class _CoachMarkPageState extends State<CoachMarkPage> {

  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

  GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();

  @override
  void initState() {
    Future.delayed(Duration.zero, () => {
      createTutorial(),
      showTutorial()
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      key: keyButton1,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      height: 100,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          child: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                            showTutorial();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(
                      key: keyButton2,
                      onPressed: () {},
                      child: const Text("2"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        key: keyButton3,
                        onPressed: () {},
                        child: const Text("3"),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        key: keyButton4,
                        onPressed: () {},
                        child: const Text("4"),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        key: keyButton5,
                        onPressed: () {},
                        child: const Text("5"),
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Stack(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                            child: SizedBox(
                              key: keyBottomNavigation1,
                              height: 40,
                              width: 40,
                            ),
                          )),
                      Expanded(
                          child: Center(
                            child: SizedBox(
                              key: keyBottomNavigation2,
                              height: 40,
                              width: 40,
                            ),
                          )),
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            key: keyBottomNavigation3,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.business),
                      label: 'Business',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.school),
                      label: 'School',
                    ),
                  ],
                  // currentIndex: _selectedIndex,
                  selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
                  onTap: (index) {},
                ),
              ],
            ),
          );
        }
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Theme.of(context).colorScheme.inversePrimary,
      skipWidget: Text(
        "SKIP GAN!",
        style: TextStyle(
          color: Theme.of(context).colorScheme.background,
          fontWeight: FontWeight.bold
        ),
      ),
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {

    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation1",
        keyTarget: keyBottomNavigation1,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Home is here!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation2",
        keyTarget: keyBottomNavigation2,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Business is here!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation3",
        keyTarget: keyBottomNavigation3,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "School is here!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tutorialCoachMark.goTo(0);
                    },
                    child: const Text('Go to index 0'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.previous();
                    },
                    child: const Icon(Icons.chevron_left),
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: keyButton4,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Multiples content",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          TargetContent(
              align: ContentAlign.top,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 5",
        keyTarget: keyButton5,
        contents: [
          TargetContent(
              align: ContentAlign.right,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Title lorem ipsum",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
      )
    );

    targets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: keyButton3,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    tutorialCoachMark.previous();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      "https://juststickers.in/wp-content/uploads/2019/01/flutter.png",
                      height: 200,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Image Load network",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.Circle,
      )
    );

    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: keyButton2,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Multiples contents",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Multiples contents",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ))
        ],
        shape: ShapeLightFocus.Circle,
      ),
    );

    return targets;
  }

}
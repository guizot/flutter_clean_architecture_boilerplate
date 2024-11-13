import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/services/screen_size_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/screen_cubit.dart';

class ScreenWrapperProvider extends StatelessWidget {
  const ScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ScreenCubit>(),
      child: const ScreenPage(title: "Screen Size"),
    );
  }
}

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key, required this.title});
  final String title;

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  List<Map<String, String>> menus = [
    {
      'title': 'Dashboard',
      'icon': 'assets/icons/hris/dashboard.svg',
    },
    {
      'title': 'Attendance',
      'icon': 'assets/icons/hris/attendance.svg',
    },
    {
      'title': 'Correction',
      'icon': 'assets/icons/hris/correction.svg',
    },
    {
      'title': 'Leave',
      'icon': 'assets/icons/hris/leave.svg',
    },
    {
      'title': 'Overtime',
      'icon': 'assets/icons/hris/overtime.svg',
    },
    {
      'title': 'Claim',
      'icon': 'assets/icons/hris/claim.svg',
    },
    {
      'title': 'Business Trip',
      'icon': 'assets/icons/hris/business_trip.svg',
    },
    {
      'title': 'Organization',
      'icon': 'assets/icons/hris/organization.svg',
    },
    {
      'title': 'Announcement',
      'icon': 'assets/icons/hris/announcement.svg',
    },
    {
      'title': 'Terms & Policy',
      'icon': 'assets/icons/hris/terms_policy.svg',
    },
    {
      'title': 'Employees',
      'icon': 'assets/icons/hris/employees.svg',
    },
    {
      'title': 'Subscriptions',
      'icon': 'assets/icons/hris/subscriptions.svg',
    },
  ];

  Widget titlePage() {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/hris/attendance.svg',
              height: 22,
              width: 22,
            ),
            const SizedBox(width: 24),
            const Text(
              "Attendance",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),
            )
          ],
        ),
        const SizedBox(height: 24)
      ],
    );
  }

  Widget breadCrumbPage() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Attendance",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ),
                )
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16)
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 24),
              child: const Row(
                children: [
                  Text(
                    "Attendance Date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16)
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 24),
              child: const Row(
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16)
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 24),
              child: const Row(
                children: [
                  Text(
                    "All Employees",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24)
      ],
    );
  }

  Widget contentPage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16)
        ),
        child: listPage(),
      ),
    );
  }


  Widget listPage() {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: listLeft()
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        flex: 1,
                      child: listRight()
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        flex: 1,
                      child: listRight()
                    ),
                  ],
                )
            ),
            Divider(height: 1, color: Theme.of(context).hoverColor)
          ],
        );
      }
    );
  }

  Widget listLeft() {
    return Row(
      children: [
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16)
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Text(
            "Solomon Angelo Herdjawan",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          )
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xff175BDA),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Text(
            "ATD",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.surface
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
              color: const Color(0xff175BDA),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Text(
            "1 Hour 37 Minute",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.surface,
              overflow: TextOverflow.ellipsis
            ),
          ),
        )
      ],
    );
  }

  Widget listRight() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(16)
          ),
          child: const Text(
            "09:10",
            style: TextStyle(
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
                color: const Color(0xffEBF0FF),
                borderRadius: BorderRadius.circular(16)
            ),
            child: const Text(
              "Jl. Buaran Raya, Gang Manggis No. 34, Grogol, Petamburan",
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        )
      ],
    );
  }


  Widget sideBarPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/icons/hris/logo.png',
          width: 120,
        ),
        const SizedBox(height: 36),
        Expanded(
          child: ListView.builder(
          itemCount: menus.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          menus[index]['icon'] ?? "",
                          semanticsLabel: menus[index]['title'] ?? "",
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          menus[index]['title'] ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                )
            );
          })
        )
      ],
    );
  }

  Widget sideBarPage2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/hris/logo_only.png',
          width: 30,
        ),
        const SizedBox(height: 36),
        Expanded(
          child: ListView.builder(
            itemCount: menus.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SvgPicture.asset(
                    menus[index]['icon'] ?? "",
                    semanticsLabel: menus[index]['title'] ?? "",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(height: 36),
                ],
              );
            }
          )
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    var ss = sl<ScreenSizeService>()..init(context);
    return Consumer2<ThemeService, LanguageService> (
      builder: (context, ThemeService themeService, LanguageService languageService, child) {
        return Scaffold(
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Row(
              children: [
                Visibility(
                  visible: ss.sidebarShowHide,
                  child: Container(
                    width: ss.sidebarWidth,
                    height: ss.screenSize.height,
                    padding: const EdgeInsets.all(36),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface
                    ),
                    child: ss.sidebarTitleShowHide ? sideBarPage() : sideBarPage2()
                  )
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor
                    ),
                    padding: const EdgeInsets.all(36),
                    child: Column(
                      children: [
                        titlePage(),
                        breadCrumbPage(),
                        contentPage()
                      ],
                    ),
                  )
                )
              ],
            )
          )
        );
      }
    );
  }

// child: GridView.builder(
//   itemCount: 25,
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: ss.gridCrossAxisCount,
//     crossAxisSpacing: 16.0,
//     mainAxisSpacing: 16.0,
//   ),
//   itemBuilder: (BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.0),
//         border: Border.all(color: Colors.grey),
//       ),
//       child: Center(
//         child: Text(
//             'Item ${index+1}',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700
//             )
//         ),
//       ),
//     );
//   },
// )

}
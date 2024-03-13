import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/movie.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/languages/languages.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_state.dart';
import 'package:flutter_image/network.dart';
import '../../../data/models/user.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/utils/color_utils.dart';
import 'cubit/github_cubit.dart';
import 'cubit/github_state.dart';

class GithubDetailWrapperProvider extends StatelessWidget {
  const GithubDetailWrapperProvider({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GithubCubit>(),
      child: GithubDetailPage(title: "Github Detail", id: id),
    );
  }
}

class GithubDetailPage extends StatefulWidget {
  const GithubDetailPage({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  State<GithubDetailPage> createState() => _GithubDetailPageState();
}

class _GithubDetailPageState extends State<GithubDetailPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  stretch: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(widget.title),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    ),
                  ),
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .inversePrimary,

                ),
                SliverToBoxAdapter(
                    child: Container(
                      child: const Column(
                        children: [
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                          Text("TESTING"),
                        ],
                      ),
                    )
                )
              ],
            )
          );
        }
    );
  }

}


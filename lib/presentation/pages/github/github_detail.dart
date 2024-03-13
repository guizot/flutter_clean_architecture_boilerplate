import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
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

  UserDetail? detail;

  @override
  void initState() {
    getUserDetail();
    super.initState();
  }

  void getUserDetail() async {
    UserDetail? detail = await BlocProvider.of<GithubCubit>(context).detailUser(widget.id);
    if(detail != null) {
      setState(() {
        this.detail = detail;
      });
    }
  }

  SliverToBoxAdapter loadList(BuildContext context, GithubCubitState state) {
    if (state is GithubInitial) {
      return SliverToBoxAdapter(
          child: Container()
      );
    }
    else if (state is GithubStateLoading) {
      return const SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading..')
              ],
            ),
          )
      );
    }
    else if (state is GithubStateLoaded) {
      return SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
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
        );
    }
    else if (state is GithubStateError) {
      return SliverToBoxAdapter(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              )
          )
      );
    }
    return SliverToBoxAdapter(
        child: Container()
    );
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
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      detail?.name ?? "",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
                      ),
                    ),
                    background: detail != null ? Image.network(
                      detail!.avatarUrl!,
                      fit: BoxFit.cover,
                    ) : Container(),
                  ),
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .inversePrimary,
                ),
                BlocBuilder<GithubCubit, GithubCubitState>(
                  builder: (context, state) {
                    return loadList(context, state);
                  },
                )
              ],
            )
          );
        }
    );
  }

}
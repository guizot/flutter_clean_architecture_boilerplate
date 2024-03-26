import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/user_github.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/utils/platform_utils.dart';
import '../../core/utils/string_utils.dart';
import 'cubit/github_cubit.dart';
import 'cubit/github_state.dart';
import 'dart:io' show Platform;

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
  bool isFavorite = false;

  @override
  void initState() {
    getUserDetail();
    super.initState();
  }

  /// REGION: REMOTE DATA SOURCE
  void getUserDetail() async {
    UserDetail? detail = await BlocProvider.of<GithubCubit>(context).detailUser(widget.id);
    if(detail != null) {
      getUserLocal(detail.id!);
      setState(() {
        this.detail = detail;
      });
    }
  }

  /// REGION: LOCAL DATA SOURCE
  void getUserLocal(int key) async {
    UserGithub? user = BlocProvider.of<GithubCubit>(context).getUserLocal(key);
    if(user != null) {
      setState(() {
        isFavorite = true;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  void saveUserLocal() async {
    if(detail != null) {
      await BlocProvider.of<GithubCubit>(context).saveUserLocal(detail!);
      getUserLocal(detail!.id!);
    }
  }

  void deleteUserLocal() async {
    if(detail != null) {
      await BlocProvider.of<GithubCubit>(context).deleteUserLocal(detail!.id!);
      getUserLocal(detail!.id!);
    }
  }

  Widget getObjectDetail() {
    List<Widget> keys = [];
    if(detail != null) {
      detail!.toJson().forEach((final String key, final value) {
        keys.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${StringUtils().convertToTitleCase(key)} :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary.toMaterialColor().shade800
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${value != "" ? value : "-"}",
                style: const TextStyle(
                    fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(height: 10),
            ],
          )
        );
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: keys
    );
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
              child: getObjectDetail()
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

  bool isCenterTitle() {
    if(PlatformUtils.isWeb) {
      return true;
    } else {
      if(Platform.isIOS) {
        return true;
      } else if(Platform.isAndroid) {
        return false;
      }
    }
    return false;
  }

  EdgeInsets? isTitlePadding() {
    if(PlatformUtils.isWeb) {
      return const EdgeInsets.symmetric(vertical: 16);
    } else {
      if(Platform.isIOS) {
        return const EdgeInsets.symmetric(vertical: 16);
      } else if(Platform.isAndroid) {
        return null;
      }
    }
    return null;
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
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
                      )
                    ),
                    background: detail != null
                        ? Image.network(
                            detail!.avatarUrl!,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                    centerTitle: isCenterTitle(),
                    titlePadding: isTitlePadding(),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          size: 26,
                          color: isFavorite ? Colors.red : null,
                        ),
                        tooltip: isFavorite ?  'Dislike' : 'Favorite',
                        onPressed: isFavorite ? deleteUserLocal : saveUserLocal,
                      ),
                    )
                  ],
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
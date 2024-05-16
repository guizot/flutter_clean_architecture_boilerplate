import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/list_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../core/services/screen_size_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/webview_cubit.dart';

class WebViewWrapperProvider extends StatelessWidget {
  const WebViewWrapperProvider({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WebViewCubit>(),
      child: WebViewPage(title: "Web View", url: url),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ss = sl<ScreenSizeService>()..init(context);
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Text("URL ${widget.url}")
            )
          );
        }
    );
  }

}
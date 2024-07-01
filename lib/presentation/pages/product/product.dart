import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/product_cubit.dart';

class ProductWrapperProvider extends StatelessWidget {
  const ProductWrapperProvider({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductCubit>(),
      child: ProductPage(title: "Product Detail", id: id),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
      builder: (context, ThemeService themeService, LanguageService languageService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(
            child: Text('Product ID: ${widget.id}'),
          ),
        );
      }
    );
  }

}
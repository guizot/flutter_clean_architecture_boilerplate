import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/mixins/share_mixin.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/staggered_cubit.dart';

class StaggeredWrapperProvider extends StatelessWidget {
  const StaggeredWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StaggeredCubit>(),
      child: const StaggeredPage(title: "Staggered List View"),
    );
  }
}

class StaggeredPage extends StatefulWidget {
  const StaggeredPage({super.key, required this.title});
  final String title;

  @override
  State<StaggeredPage> createState() => _StaggeredPageState();
}

class _StaggeredPageState extends State<StaggeredPage> with ShareMixin, TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<String> items = const [
    "https://www.humanesociety.org/sites/default/files/styles/400x400/public/2018/06/cat-217679.jpg",
    "https://www.lismore.nsw.gov.au/files/assets/public/v/1/1.-households/4.-pets-amp-animals/images/kitten.jpg?dimension=pageimage&w=480",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cat_November_2010-1a.jpg/1200px-Cat_November_2010-1a.jpg",
    "https://www.thesprucepets.com/thmb/OoMBiCxD3B02Jx-WO9dmY0DAaaI=/4000x0/filters:no_upscale():strip_icc()/cats-recirc3_2-1f5de201af94447a9063f83249260aff.jpg",
    "https://static.standard.co.uk/2023/10/26/12/Battersea%20-%20Black%20Cat%20photo.jpg?width=1200&height=1200&fit=crop",
    "https://images.theconversation.com/files/560110/original/file-20231117-29-fv986f.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5048%2C2524&q=45&auto=format&w=1356&h=668&fit=crop",
    "https://www.animalfriends.co.uk/siteassets/media/images/article-images/cat-articles/51_afi_article1_the-secret-language-of-cats.png",
    "https://images.theconversation.com/files/540798/original/file-20230802-25-fqa49r.jpg?ixlib=rb-4.1.0&q=30&auto=format&w=754&h=1131&fit=crop&dpr=2",
    "https://www.animalfriends.co.uk/siteassets/media/images/article-images/cat-articles/51_afi_article2_the-secret-language-of-cats.png",
    "https://images.ctfassets.net/sfnkq8lmu5d7/5mgJCck3rmJqcxvCZsRjEc/85861078a90a3c39a6c0adf8a351f8ab/2023-07-25_What_Colors_Do_Cats_See?w=676&h=900&q=70&fm=webp",
    "https://ontariospca.ca/wp-content/uploads/2021/10/pexels-alex-andrews-821736-e1634240525391.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              bottom: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.tab,
                controller: tabController,
                tabs: <Widget>[
                  Tab(
                    icon: const Icon(Icons.view_comfy_sharp),
                    child: Container(
                      width: 75,
                      alignment: Alignment.center,
                      child: const Text("Staggered"),
                    ),
                  ),
                  Tab(
                    icon: const Icon(Icons.view_quilt_sharp),
                    child: Container(
                      width: 75,
                      alignment: Alignment.center,
                      child: const Text("Quilted"),
                    ),
                  ),
                  Tab(
                    icon: const Icon(Icons.grid_view_sharp),
                    child: Container(
                      width: 75,
                      alignment: Alignment.center,
                      child: const Text("Grid"),
                    ),
                  ),
                  Tab(
                    icon: const Icon(Icons.view_column_sharp),
                    child: Container(
                    width: 75,
                      alignment: Alignment.center,
                    child: const Text("Aligned"),
                  ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: <Widget>[
                MasonryGridView.count(
                  padding: const EdgeInsets.all(16.0),
                  clipBehavior: Clip.none,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            items[index],
                            scale: 1,
                            fit: BoxFit.cover,
                          ),
                        )
                    );
                  },
                ),
                GridView.custom(
                  padding: const EdgeInsets.all(16.0),
                  clipBehavior: Clip.none,
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: [
                      const QuiltedGridTile(2, 2),
                      const QuiltedGridTile(1, 1),
                      const QuiltedGridTile(1, 1),
                      const QuiltedGridTile(1, 2),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate((context, index) => GridTile(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          items[index],
                          scale: 1,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    childCount: items.length
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  clipBehavior: Clip.none,
                  child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: items.map((item) => (
                          StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item,
                                  scale: 1,
                                  fit: BoxFit.cover,
                                ),
                              )
                          )
                      )).toList()
                  ),
                ),
                AlignedGridView.count(
                  padding: const EdgeInsets.all(16.0),
                  clipBehavior: Clip.none,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            items[index],
                            scale: 1,
                            fit: BoxFit.cover,
                          ),
                        )
                    );
                  },
                ),
              ],
            )
          );
        }
    );
  }

}

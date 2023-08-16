import 'package:flutter/material.dart';
import 'package:flutter_tab_scrollable_example/data.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(
    length: categories.length,
    vsync: this,
  );

  final GlobalKey<RectGetterState> listViewKey = RectGetter.createGlobalKey();
  final Map<int, GlobalKey<RectGetterState>> _keys = {};
  final AutoScrollController scrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return RectGetter(
      key: listViewKey,
      child: NotificationListener<UserScrollNotification>(
        onNotification: onScrollNotification,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            buildSliverTabBar(),
            buildVerticalSliverList(context),
          ],
        ),
      ),
    );
  }

  Widget buildItem(int index, BuildContext context) {
    var item = items[index];
    if ((index == 0 || item.categoryId != items[index - 1].categoryId)) {
      _keys[item.categoryId] = RectGetter.createGlobalKey();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((index == 0 || item.categoryId != items[index - 1].categoryId))
          RectGetter(
            key: _keys[item.categoryId]!,
            child: AutoScrollTag(
              key: ValueKey(item.categoryId),
              index: item.categoryId,
              highlightColor: Colors.red,
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Chip(
                  padding: EdgeInsets.zero,
                  label: Text(
                    "${item.categoryId.toString()} ${categories.firstWhere((element) => element.categoryId == item.categoryId).name}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    item.image,
                    width: 120,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 120,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.description,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSliverTabBar() {
    return SliverAppBar(
      pinned: true,
      title: const Text("AppBar"),
      bottom: TabBar(
        isScrollable: true,
        controller: tabController,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        indicatorWeight: 3.0,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: categories.map((e) => Tab(child: Text(e.name))).toList(),
        onTap: (index) {
          var categoryId = categories[index].categoryId;
          animateAndScrollTo(categoryId);
        },
      ),
    );
  }

  Widget buildVerticalSliverList(BuildContext context) {
    return SliverToBoxAdapter(
      child: ScrollablePositionedList.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => buildItem(
          index,
          context,
        ),
      ),
    );
  }

  void animateAndScrollTo(int index) async {
    tabController.animateTo(index);
    await scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  bool onScrollNotification(UserScrollNotification notification) {
    List<int> visibleItems = getVisibleItemsIndex();
    if (visibleItems.isNotEmpty) {
      tabController.animateTo(visibleItems.first);
    }
    return false;
  }

  List<int> getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;
    _keys.forEach((index, key) {
      // TODO: on closest to top
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom <
          rect.top + MediaQuery.of(context).viewPadding.top + 100) return;

      items.add(index);
    });
    return items;
  }
}

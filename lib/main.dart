import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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

class Product {
  final String name;
  final String description;
  final String image;
  final int categoryId;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.categoryId,
  });
}

class ProductCategory {
  int categoryId;
  String name;

  ProductCategory({
    required this.name,
    required this.categoryId,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum VerticalScrollPosition { begin, middle, end }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Map<int, GlobalKey<RectGetterState>> _keys = {};
  final VerticalScrollPosition verticalScrollPosition =
      VerticalScrollPosition.begin;
  final AutoScrollController scrollController = AutoScrollController();

  final List<ProductCategory> categories = [
    ProductCategory(
      categoryId: 0,
      name: "Cool cat",
    ),
    ProductCategory(
      categoryId: 1,
      name: "Sad cat",
    ),
    ProductCategory(
      categoryId: 2,
      name: "Mad cat",
    ),
    ProductCategory(
      categoryId: 3,
      name: "Bad cat",
    ),
    ProductCategory(
      categoryId: 4,
      name: "Sweet cat",
    ),
  ];

  final List<Product> items = [
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 0,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 0,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 0,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 1,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 1,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 1,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 1,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 1,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 1,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 2,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 2,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 2,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 2,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 2,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 3,
    ),
    Product(
        name: generateRandomString(),
        description: generateRandomString(len: 100),
        image:
            "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
        categoryId: 3),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 4,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 4,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 4,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 4,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 4,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 4,
    ),
    Product(
      name: generateRandomString(),
      description: generateRandomString(len: 100),
      image: "https://loremflickr.com/320/240?random=${Random().nextInt(100)}",
      categoryId: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(context),
    );
  }

  late final TabController tabController = TabController(
    length: categories.length,
    vsync: this,
  );

  var listViewKey = RectGetter.createGlobalKey();

  Widget buildBody(BuildContext context) {
    return RectGetter(
      key: listViewKey,
      child: NotificationListener<UserScrollNotification>(
        onNotification: onScrollNotification,
        child: CustomScrollView(
          controller: scrollController,
          // scrollDirection: Axis.vertical,
          // TODO: Shit solution
          // cacheExtent: 10000,
          slivers: [
            buildSliverTabBar(),
            buildVerticalSliverList(context),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    tabController.addListener(() {
      if (VerticalScrollableTabBarStatus.isOnTap) {
        VerticalScrollableTabBarStatus.isOnTap = false;
        animateAndScrollTo(VerticalScrollableTabBarStatus.isOnTapIndex);
      }
    });
    super.initState();
  }

  Widget buildItem(int index, BuildContext context) {
    var item = items[index];
    if ((index == 0 || item.categoryId != items[index - 1].categoryId)) {
      _keys[item.categoryId] = RectGetter.createGlobalKey();
    }
    Widget widget = Column(
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
    return widget;
  }

  Widget buildSliverTabBar() {
    return SliverAppBar(
      pinned: true,
      title: Text("AppBar"),
      bottom: TabBar(
        isScrollable: true,
        controller: tabController,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        indicatorWeight: 3.0,
        tabs: categories.map((e) => Tab(child: Text(e.name))).toList(),
        onTap: (index) {
          var _index = categories[index].categoryId;
          VerticalScrollableTabBarStatus.setIndex(_index);
        },
      ),
    );
  }

  Widget buildVerticalSliverList(BuildContext context) {
    // TODO: Shit solution too, but whats the other way to scroll
    return SliverToBoxAdapter(
      child: Column(
        children: List.generate(
          items.length,
          (index) => buildItem(index, context),
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

String generateRandomString({int len = 10}) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}


class VerticalScrollableTabBarStatus {
  static bool isOnTap = false;
  static int isOnTapIndex = 0;

  static void setIndex(int index) {
    VerticalScrollableTabBarStatus.isOnTap = true;
    VerticalScrollableTabBarStatus.isOnTapIndex = index;
  }
}

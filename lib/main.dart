import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'models/workout_category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                  child: Text(
                    "My Training Plan",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 24,
              )),
              SliverToBoxAdapter(child: const HorizontalCalendar()),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 24,
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle("Today's session"),
                      const SizedBox(
                        height: 16,
                      ),
                      const FeaturedSession(),
                      const SizedBox(
                        height: 24,
                      ),
                      const SectionTitle("Explore"),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              WorkoutCategoriesGrid()
            ],
          )),
          CustomBottomAppBar()
        ],
      ),
    ));
  }
}

class CalendarItem extends StatelessWidget {
  final int day;
  final bool selected;

  const CalendarItem({super.key, required this.day, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: selected
          ? BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(100))
          : null,
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : null),
        ),
      ),
    );
  }
}

class WorkoutCategoriesGrid extends StatelessWidget {
  final List<WorkoutCategory> _categories = [
    WorkoutCategory(
        10, "assets/images/gorilla-freak-wt5jg8_WrJg-unsplash.jpg", "Back"),
    WorkoutCategory(
        10, "assets/images/jonathan-borba-lrQPTQs7nQQ-unsplash.jpg", "Core"),
    WorkoutCategory(
        10, "assets/images/alora-griffiths-TuzrzArccvc-unsplash.jpg", "Legs"),
    WorkoutCategory(
        10, "assets/images/chander-r-AtfA8NDgpKA-unsplash.jpg", "Running"),
    WorkoutCategory(
        10, "assets/images/kike-vega-F2qh3yjz6Jk-unsplash.jpg", "Yoga")
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 24, right: 24),
      sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => InkWell(
              onTap: () {},
              child: Ink(
                padding: EdgeInsets.all(16),
                decoration: boxDecorationWithImage(
                    AssetImage(_categories[index].imageUrl)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _categories[index].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      "${_categories[index].workoutCount} workouts",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            childCount: _categories.length,
          )),
    );
  }
}

class HorizontalCalendar extends StatelessWidget {
  const HorizontalCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 4),
          child: Text(
            "December 2022",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 36,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: 31,
            itemBuilder: (context, index) {
              return Container(
                width: 36,
                child: CalendarItem(
                  day: index + 1,
                  selected: index == 4,
                ),
              );
            },
          ),
        )
      ],
    );
    /*
        Row(
                  children: [
                    CalendarItem(
                      day: e,
                      selected: e == 24,
                    ),
                    const SizedBox(
                      width: 12,
                    )
                  ],
                )
         */
  }
}

class FeaturedSession extends StatelessWidget {
  const FeaturedSession({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: boxDecorationWithImage(const AssetImage(
          'assets/images/gordon-cowie-ISg1JhN_vFk-unsplash.jpg',
        )),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Text(
                    "Day 2",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "Full Body",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text("John Doe",
                    style: TextStyle(
                      color: Colors.white60,
                    )),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "836 kcals",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.timelapse,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "24 min",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(100)),
                child: const Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

BoxDecoration boxDecorationWithImage(ImageProvider image) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.black,
    image: DecorationImage(
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
      fit: BoxFit.cover,
      image: image,
    ),
  );
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  final List<BottomAppBarIcon> _icons = [
    BottomAppBarIcon("Home", Icons.fitness_center),
    BottomAppBarIcon("Calendar", Icons.calendar_month),
    BottomAppBarIcon("Challenges", Icons.workspace_premium),
    BottomAppBarIcon("Stats", Icons.bar_chart),
    BottomAppBarIcon("User", Icons.person)
  ];

  int currentIndex = 0;
  Size? currentIconSize;
  Offset? currentIconPosition;

  final List<GlobalKey> _iconKeys = [];

  @override
  void initState() {
    _iconKeys.addAll(_icons.map((e) => GlobalKey()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setCurrentSelectedItem(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 6), // changes position of shadow
        ),
      ]),
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  _icons.map((e) => _pageIcon(_icons.indexOf(e))).toList(),
            ),
          ),
          if (currentIconPosition != null && currentIconSize != null)
            AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                left: currentIconPosition!.dx - 24,
                bottom: 12,
                child: Container(
                  width: (currentIconSize!.width) * 3,
                  child: Center(
                    child: Text(_icons[currentIndex].label, textAlign: TextAlign.center,),
                  ),
                ))
        ],
      ),
    );
  }

  void _setCurrentSelectedItem(int index) {
    RenderBox box =
        _iconKeys[index].currentContext!.findRenderObject() as RenderBox;
    var position = box.localToGlobal(Offset.zero);
    var size = box.size;

    setState(() {
      currentIndex = index;
      currentIconSize = size;
      currentIconPosition = position;
    });
  }

  Widget _pageIcon(int indexOf) {
    BottomAppBarIcon icon = _icons[indexOf];
    return GestureDetector(
      key: _iconKeys[indexOf],
      onTap: () => _setCurrentSelectedItem(indexOf),
      child: Icon(
        icon.icon,
        color: currentIndex == indexOf ? Colors.black : Colors.black38,
      ),
    );
  }
}

class BottomAppBarIcon {
  final String label;
  final IconData icon;

  BottomAppBarIcon(this.label, this.icon);
}

import 'package:blog_club/Home.dart';
import 'package:blog_club/article.dart';
import 'package:blog_club/gen/fonts.gen.dart';
import 'package:blog_club/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primarytextcolor = Color(0xff0D253C);
    const secondarytextcolor = Color(0xff2D4379);
    const primarycolor = Color(0xff376AED);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            titleSpacing: 32,
            backgroundColor: Colors.white,
            foregroundColor: primarytextcolor),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        colorScheme: const ColorScheme.light(
            primary: primarycolor,
            onPrimary: Colors.white,
            background: Color(0xffFDFEFF),
            surface: Colors.white,
            onSurface: primarytextcolor,
            onBackground: primarytextcolor),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: primarycolor,
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(TextStyle(
                    fontFamily: FontFamily.avenir,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)))),
        textTheme: const TextTheme(
            caption: TextStyle(
                fontFamily: FontFamily.avenir,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xff7B8BB2)),
            subtitle2: TextStyle(
                fontFamily: FontFamily.avenir,
                color: primarytextcolor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            subtitle1: TextStyle(
                fontFamily: FontFamily.avenir,
                color: secondarytextcolor,
                fontWeight: FontWeight.w200,
                fontSize: 14),
            bodyText2: TextStyle(
                fontFamily: FontFamily.avenir,
                fontSize: 12,
                color: secondarytextcolor),
            bodyText1: TextStyle(
                fontFamily: FontFamily.avenir,
                fontSize: 14,
                color: primarytextcolor),
            headline4: TextStyle(
                fontFamily: FontFamily.avenir,
                color: primarytextcolor,
                fontSize: 24,
                fontWeight: FontWeight.w700),
            headline6: TextStyle(
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.bold,
                color: primarytextcolor,
                fontSize: 18),
            headline5: TextStyle(
                fontFamily: FontFamily.avenir,
                fontSize: 20,
                color: primarytextcolor,
                fontWeight: FontWeight.w700)),
      ),
      // home: Stack(
      //   children: [
      //     Positioned.fill(child: const Homescreen()),
      //     Positioned(bottom: 0, left: 0, right: 0, child: _BottomNavigation())
      //   ],
      // ),
      home: const Mainscreen(),
    );
  }
}

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

const int homeindex = 0;
const int articleindex = 1;
const int searchindex = 2;
const int menuindex = 3;

class _MainscreenState extends State<Mainscreen> {
  int selectedscreenindex = homeindex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homekey = GlobalKey();
  final GlobalKey<NavigatorState> _articlekey = GlobalKey();
  final GlobalKey<NavigatorState> _searchkey = GlobalKey();
  final GlobalKey<NavigatorState> _profilekey = GlobalKey();

  late final Map = {
    homeindex: _homekey,
    articleindex: _articlekey,
    searchindex: _searchkey,
    menuindex: _profilekey
  };

  Future<bool> _onwillpop() async {
    final NavigatorState currentselectedTabnavigatorstate =
        Map[selectedscreenindex]!.currentState!;
    if (_homekey.currentState!.canPop()) {
      currentselectedTabnavigatorstate.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedscreenindex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillpop,
      child: Scaffold(
        bottomNavigationBar: _BottomNavigation(
          selectedindex: selectedscreenindex,
          onTap: (index) {
            setState(() {
              selectedscreenindex = index;
            });
          },
        ),
        body: IndexedStack(
          index: selectedscreenindex,
          children: [
            Navigator(
              key: _homekey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Homescreen(),
              ),
            ),
            Navigator(
              key: _articlekey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Articlescreen(),
              ),
            ),
            Navigator(
              key: _searchkey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Simplescreen(),
              ),
            ),
            Navigator(
              key: _profilekey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Profilescreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int screennumber = 1;

class Simplescreen extends StatelessWidget {
  const Simplescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "screen #$screennumber",
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
              onPressed: () {
                screennumber++;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Simplescreen()));
              },
              child: const Text("click me"))
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int selectedindex;
  const _BottomNavigation(
      {Key? key, required this.onTap, required this.selectedindex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 20, color: const Color(0xaa9B8487).withOpacity(0.3))
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavigationItem(
                      isActive: selectedindex == homeindex,
                      onTap: () {
                        onTap(homeindex);
                      },
                      iconFileName: "Home.png",
                      activeiconFileName: "Home.png",
                      title: "Home"),
                  BottomNavigationItem(
                      onTap: () {
                        onTap(articleindex);
                      },
                      isActive: selectedindex == articleindex,
                      iconFileName: "Articles.png",
                      activeiconFileName: "Articles.png",
                      title: "Articles"),
                  const SizedBox(
                    width: 8,
                  ),
                  BottomNavigationItem(
                      isActive: selectedindex == searchindex,
                      onTap: () {
                        onTap(searchindex);
                      },
                      iconFileName: "Search.png",
                      activeiconFileName: "Search.png",
                      title: "Search"),
                  BottomNavigationItem(
                      isActive: selectedindex == menuindex,
                      onTap: () {
                        onTap(menuindex);
                      },
                      iconFileName: "Menu.png",
                      activeiconFileName: "Menu.png",
                      title: "Menu")
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 60,
              height: 85,
              alignment: Alignment.topCenter,
              child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xff376AED),
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(32.5)),
                  child: Image.asset("assets/img/icons/plus.png")),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String activeiconFileName;
  final String title;
  final Function() onTap;
  final bool isActive;

  const BottomNavigationItem(
      {super.key,
      required this.iconFileName,
      required this.activeiconFileName,
      required this.title,
      required this.onTap,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              "assets/img/icons/${isActive ? activeiconFileName : iconFileName}"),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.caption!.apply(
                color: isActive
                    ? themeData.colorScheme.primary
                    : Theme.of(context).textTheme.caption!.color),
          )
        ],
      ),
    );
  }
}

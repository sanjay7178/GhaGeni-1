import 'dart:ui';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GhaGeni',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  SideMenuDisplayMode displayMode = SideMenuDisplayMode.auto;
  TextEditingController chat = TextEditingController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   centerTitle: true,
      // ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: swidth<600?10:350, right: 10),
        child: ClipRRect(
          //
          borderRadius:
          BorderRadius.all(Radius.circular(50.0)), // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  style: TextStyle(),
                  controller: chat,
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    // fillColor: Colors.white,
                    //   hoverColor: Colors.white,
                    //   focusColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.pink,
                          size: 30,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide:
                        BorderSide(color: Colors.blue.shade100, width: 2),
                      ),
                      hintText: 'Type your query...',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              compactSideMenuWidth: 66,
              itemBorderRadius: BorderRadius.circular(50),
              // showTooltip: false,
              displayMode: displayMode,
              hoverColor: Colors.pinkAccent[100],
              selectedHoverColor: Color.alphaBlend(
                  Color.fromRGBO(
                      Theme.of(context).colorScheme.surfaceTint.red,
                      Theme.of(context).colorScheme.surfaceTint.green,
                      Theme.of(context).colorScheme.surfaceTint.blue,
                      0.08),
                  Colors.pinkAccent[100]!),
              selectedColor: Colors.pink,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Column(
              children: [
                SideMenuItem(
                  priority: 0,
                  title: 'Bucket List',
                  onTap: (index, _) {
                    setState(() {
                      if(displayMode == SideMenuDisplayMode.auto) {
                        displayMode = SideMenuDisplayMode.open;
                      } else {
                        displayMode = SideMenuDisplayMode.auto;
                      }
                    });
                  },
                  icon: Icon(FaIcon(FontAwesomeIcons.bucket).icon),
                  tooltipContent: "Bucket list",
                ),
                Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Logout',
                      style: TextStyle(color: Colors.white)
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.pinkAccent[100]!),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(
                                15.0)), // Set rounded radius here
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Clear Everything',
                      style: TextStyle(color: Colors.white)
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.pinkAccent[100]!),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0.0), // Set rounded radius here
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  color: Colors.pinkAccent[100],
                )
              ],
            ),
            items: [
              for (int i = 0; i < 10; i++)
                SideMenuItem(
                  priority: i + 1,
                  title: 'Dashboard',
                  onTap: (index, _) {},
                  iconWidget: CircleAvatar(

                    backgroundColor: Colors.pinkAccent[100],
                    child: Text("#${i+1}"),
                  ),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "PageView",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                Text(""),
              ],
            ),
          )
        ],
      ),
    );
  }
}

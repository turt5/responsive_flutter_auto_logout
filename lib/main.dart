import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_tutorial/provider/_theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '_home.dart';
import '_login.dart';
import 'controller/_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialized

  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("session_token");
  String? user = preferences.getString("user");

  print("Token saved: $token");

  dynamic data = await Session.getSession();
  print('Session got: ${data['users'][0]['session_cookie']} ');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(
        token: token,
        data: data,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.token, this.user, this.data}) : super(key: key);
  final String? token;
  final String? user;
  final dynamic data;

  bool checkData(String? token, String? user, dynamic data) {
    print(data);
    for (var map in data['users']) {
      if (map['session_cookie'] == token && map['user'] == user) {
        print("returning true");
        return true;
      }
    }
    print("Returning false");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: token==null?ResponsiveLayoutExample():HomePage(),
      home: token!=null && checkData(token, user, data) ? HomePage() : ResponsiveLayoutExample(),
    );
  }
}

class ResponsiveLayoutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        backgroundColor: themeProvider.currentTheme == ThemeData.dark()
            ? Color(0xFF161616)
            : Colors.white,
        drawer: Drawer(
          backgroundColor: themeProvider.currentTheme == ThemeData.dark()
              ? Color(0xFF161616)
              : Colors.white,
          child: Container(
            padding: EdgeInsets.only(top: 50, left: 20),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: themeProvider.currentTheme == ThemeData.dark()
                        ? Colors.white
                        : Colors.black,
                  ),
                  title: Text("Home",
                      style: TextStyle(
                        color: themeProvider.currentTheme == ThemeData.dark()
                            ? Colors.white
                            : Colors.black,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: themeProvider.currentTheme == ThemeData.dark()
                        ? Colors.white
                        : Colors.black,
                  ),
                  title: Text("About",
                      style: TextStyle(
                        color: themeProvider.currentTheme == ThemeData.dark()
                            ? Colors.white
                            : Colors.black,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.contact_phone,
                    color: themeProvider.currentTheme == ThemeData.dark()
                        ? Colors.white
                        : Colors.black,
                  ),
                  title: Text("Contact",
                      style: TextStyle(
                        color: themeProvider.currentTheme == ThemeData.dark()
                            ? Colors.white
                            : Colors.black,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: themeProvider.currentTheme == ThemeData.dark()
                        ? Colors.white
                        : Colors.black,
                  ),
                  title: Text("Services",
                      style: TextStyle(
                        color: themeProvider.currentTheme == ThemeData.dark()
                            ? Colors.white
                            : Colors.black,
                      )),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.brightness_4,
                    color: themeProvider.currentTheme == ThemeData.dark()
                        ? Colors.white
                        : Colors.black,
                  ),
                  title: Text("Dark Mode",
                      style: TextStyle(
                        color: themeProvider.currentTheme == ThemeData.dark()
                            ? Colors.white
                            : Colors.black,
                      )),
                  trailing: CupertinoSwitch(
                    value: themeProvider.currentTheme == ThemeData.dark(),
                    onChanged: (_) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return ListView(
                children: [
                  Container(
                      height: 100,
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: width * .1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(Icons.menu)),
                          Text("Logo",
                              style: GoogleFonts.silkscreen(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.currentTheme ==
                                          ThemeData.dark()
                                      ? Colors.black
                                      : Colors.white)),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: themeProvider.currentTheme ==
                                          ThemeData.dark()
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: themeProvider.currentTheme ==
                                        ThemeData.dark()
                                    ? Colors.black
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  color: themeProvider.currentTheme ==
                                          ThemeData.dark()
                                      ? Colors.black
                                      : Colors.white,
                                  width: 2,
                                ),
                              )),
                        ],
                      )),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          'Bangladesh',
                          style: TextStyle(
                            color:
                                themeProvider.currentTheme == ThemeData.dark()
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Architecture\nDesigned for Life',
                    style: TextStyle(
                        fontSize: calculateTextSize(context, 30),
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'When you choose us, you choose a team of professionals who are dedicated to providing you with the best service possible.\nWe are committed to providing you with the highest quality workmanship and customer service.\nWe are committed to providing you with the highest quality workmanship and customer service.',
                      style: TextStyle(
                          fontSize: calculateTextSize(context, 13),
                          fontWeight: FontWeight.normal,
                          color: themeProvider.currentTheme == ThemeData.dark()
                              ? Colors.white
                              : Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.network(
                      'https://images.pexels.com/photos/1668246/pexels-photo-1668246.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              );
            } else {
              // Tablet/Desktop layout
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    height: 100,
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: width * .1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Logo",
                              style: GoogleFonts.silkscreen(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.currentTheme ==
                                          ThemeData.dark()
                                      ? Colors.black
                                      : Colors.white)),
                          Row(
                            children: [
                              Text("Home",
                                  style: TextStyle(
                                    color: themeProvider.currentTheme ==
                                            ThemeData.dark()
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                              const SizedBox(width: 15),
                              Text("About",
                                  style: TextStyle(
                                    color: themeProvider.currentTheme ==
                                            ThemeData.dark()
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                              const SizedBox(width: 15),
                              Text("Contact",
                                  style: TextStyle(
                                    color: themeProvider.currentTheme ==
                                            ThemeData.dark()
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                              const SizedBox(width: 15),
                              Text("Services",
                                  style: TextStyle(
                                    color: themeProvider.currentTheme ==
                                            ThemeData.dark()
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                              const SizedBox(width: 15),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text("Dark Mode",
                                        style: TextStyle(
                                          color: themeProvider.currentTheme ==
                                                  ThemeData.dark()
                                              ? Colors.black
                                              : Colors.white,
                                        )),
                                    const SizedBox(width: 10),
                                    CupertinoSwitch(
                                      value: themeProvider.currentTheme ==
                                          ThemeData.dark(),
                                      onChanged: (_) {
                                        themeProvider.toggleTheme();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text("Login",
                                  style: TextStyle(
                                    color: themeProvider.currentTheme ==
                                            ThemeData.dark()
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              )),
                        ]),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'Bangladesh',
                            style: TextStyle(
                              color:
                                  themeProvider.currentTheme == ThemeData.dark()
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Architecture\nDesigned for Life',
                    style: TextStyle(
                        fontSize: calculateTextSize(context, 30),
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'When you choose us, you choose a team of professionals who are dedicated to providing you with the best service possible.\nWe are committed to providing you with the highest quality workmanship and customer service.\nWe are committed to providing you with the highest quality workmanship and customer service.',
                      style: TextStyle(
                          fontSize: calculateTextSize(context, 13),
                          fontWeight: FontWeight.normal,
                          color: themeProvider.currentTheme == ThemeData.dark()
                              ? Colors.white
                              : Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.network(
                      'https://images.pexels.com/photos/1668246/pexels-photo-1668246.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              );
            }
          },
        ),
      );
    });
  }

  double calculateTextSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = 0.003; // Adjust this value based on your design
    return (screenWidth * scaleFactor) + baseSize;
  }
}

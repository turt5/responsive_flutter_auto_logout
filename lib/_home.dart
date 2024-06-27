import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_tutorial/controller/_logout_server.dart';
import 'package:responsive_tutorial/provider/_theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, _) {
      return Scaffold(
        backgroundColor: themeProvider.currentTheme == ThemeData.light()
            ? Colors.white
            : Colors.black,
        appBar: AppBar(
          title: Text('Home Page', style: TextStyle(color: themeProvider.currentTheme == ThemeData.light() ? Colors.black : Colors.white),
        ),),
        body: LayoutBuilder(builder: (context, constraints) {
          return constraints.maxWidth < 600
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Welcome to Home Page', style: TextStyle(color: themeProvider.currentTheme == ThemeData.light() ? Colors.black : Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async{
                            await removeSessionToken();
                            LogoutServer.logout();
                            Navigator.pop(context);
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Welcome to Home Page', style: TextStyle(color: themeProvider.currentTheme == ThemeData.light() ? Colors.black : Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async{
                            await removeSessionToken();
                            LogoutServer.logout();
                            Navigator.pop(context);
                          },
                          child: Text('Logout',),
                        ),
                      ],
                    ),
                  ],
                );
        }),
      );
    });
  }

  Future<void> removeSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_token');
  }
}

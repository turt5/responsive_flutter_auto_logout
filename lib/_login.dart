import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '_home.dart';
import 'controller/_login_server.dart';
import 'provider/_theme_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          backgroundColor: themeProvider.currentTheme == ThemeData.light()
              ? Colors.white
              : Colors.black,
          appBar: AppBar(
            title: Text('Login Page'),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth < 600
                  ? _buildLoginUI(themeProvider, usernameController,
                  passwordController, context)
                  : _buildLoginUI(themeProvider, usernameController,
                  passwordController, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildLoginUI(
      ThemeProvider themeProvider,
      TextEditingController usernameController,
      TextEditingController passwordController,
      BuildContext context,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: usernameController,
                style: TextStyle(
                  color: themeProvider.currentTheme == ThemeData.light()
                      ? Colors.black
                      : Colors.white,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: themeProvider.currentTheme == ThemeData.light()
                      ? Colors.grey.shade200
                      : Colors.grey.shade800,
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: themeProvider.currentTheme == ThemeData.light()
                        ? Colors.grey.shade500
                        : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: passwordController,
                style: TextStyle(
                  color: themeProvider.currentTheme == ThemeData.light()
                      ? Colors.black
                      : Colors.white,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: themeProvider.currentTheme == ThemeData.light()
                      ? Colors.grey.shade200
                      : Colors.grey.shade800,
                  labelStyle: TextStyle(
                    color: themeProvider.currentTheme == ThemeData.light()
                        ? Colors.grey.shade500
                        : Colors.grey.shade500,
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            String username = usernameController.text;
            String password = passwordController.text;

            if (username.isNotEmpty && password.isNotEmpty) {

              usernameController.clear();
              passwordController.clear();


              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please wait...'),
                  duration: Duration(seconds: 1),
                ),
              );

              var response = await LoginServer.login(username, password);
              if (response['status']) {
                await saveSessionToken(response['cookie'], response['user']);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login failed. Please try again.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please fill in all fields.'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Text('Login'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor:
            themeProvider.currentTheme == ThemeData.light()
                ? Colors.white
                : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> saveSessionToken(String sessionToken, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_token', sessionToken);
    await prefs.setString('user', userId);

  }

  Future<void> removeSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_token');
  }
}

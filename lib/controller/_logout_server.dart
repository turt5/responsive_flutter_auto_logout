import 'dart:convert';
import 'package:http/http.dart' as http;

class LogoutServer{
  static Future<dynamic> logout() async {
    String url = 'https://pharmabrew.online.bcrypt.site/php/logout.php';

    try {
      var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        // Logout successful
        var responseData = jsonDecode(response.body);
        return responseData['message'];
        // Perform any additional actions, such as navigating to a login screen
      } else {
        // Error handling based on status code
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      // Exception handling
      print('Exception caught: $e');
    }
  }
}
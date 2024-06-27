import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginServer{
  static Future<dynamic> login(String username, String password) async {
    String url = 'https://pharmabrew.online.bcrypt.site/php/login.php'; // Replace with your PHP API endpoint

    // Prepare data to send
    Map<String, String> data = {
      'username': username,
      'password': password,
    };

    // Make POST request
    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        // Successful login
        var responseData = jsonDecode(response.body);
        if(responseData['message']=='Login successful.'){
          return {
            "status": true,
            "message": responseData['message'],
            "cookie": responseData['session_cookie'],
            "user": responseData['user_id']
          };
        }
      }
    } catch (e) {
      // Exception handling
      print('Exception caught: $e');
    }
  }
}
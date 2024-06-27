import 'package:http/http.dart' as http;
import 'dart:convert';

class Session{
  static Future<dynamic> getSession() async{
    print("Requesting For session ...");
    String url = 'https://pharmabrew.online.bcrypt.site/php/get_session.php';

    try{
      var response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});
      // print(response.body);
      if(response.statusCode == 200){

        var responseData = jsonDecode(response.body);
        // print(responseData['users']);
        return responseData;
      }
    }catch(e){
      print('Exception caught: $e');
    }
  }
}

void main() async {
  var session = await Session.getSession();
  print(session);
}
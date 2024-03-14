import 'package:flutter/material.dart';
import 'package:moviesync/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  void _loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      
    });
    if (_rememberMe) {
      // If rememberMe is true, navigate to Home Screen directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  void _saveRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', _rememberMe);
    if (_rememberMe) {
      prefs.setString('username', _usernameController.text);
      prefs.setString('password', _passwordController.text);
    } else {
      prefs.remove('username');
      prefs.remove('password');
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Welcome to MovieSync',
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      )),
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset('asset/moviesyncsignin.png'), // Replace 'app_icon.png' with your actual app icon image path
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    Text('Remember Me'),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _saveRememberMe(); // Save remember me status
                    // Navigate to Home Screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}

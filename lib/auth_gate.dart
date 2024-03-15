import 'package:flutter/material.dart';
import 'package:moviesync/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  _AuthGateState createState() => _AuthGateState();

  static void saveRememberMe(bool rememberMe) {
    _AuthGateState()._saveRememberMe(rememberMe);
  }
}

class _AuthGateState extends State<AuthGate> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  static void saveRememberMe(bool rememberMe) {
    _AuthGateState()._saveRememberMe(rememberMe);
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

  void _saveRememberMe(bool rememberMe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', rememberMe);
    if (rememberMe) {
      prefs.setString('username', _emailController.text);
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
        title: Text(
          'Welcome!',
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 6, 3, 45), // Set background color to dark blue
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Set border color to white
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Set border color to white
                          ),
                        ),
                        style: TextStyle(color: Colors.white), // Set text color to white
                      ),
                      SizedBox(height: 10), // Small gap between email and password fields
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Set border color to white
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white), // Set border color to white
                          ),
                        ),
                        style: TextStyle(color: Colors.white), // Set text color to white
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
                            checkColor: Colors.white, // Set check color to white
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(color: Colors.white), // Set text color to white
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _saveRememberMe(_rememberMe); // Save remember me status
                          // Navigate to Home Screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Color.fromARGB(255, 6, 3, 45)), // Set button text color to white
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

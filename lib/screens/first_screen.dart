import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/screens/auth.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  // final PageController _pageController = PageController(initialPage: 0);
  // final List<Widget> _screens = [
  //   const AuthScreen(),
  // ];
  void _continue(){
  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthScreen(),
  ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1919),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/applogo.png',
                  width: 300,
                ),
                const SizedBox(height: 30),
                OutlinedButton.icon(
                  onPressed: _continue,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward_ios_sharp,
                  size: 40,),
                  label: const Text('CONTINUE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

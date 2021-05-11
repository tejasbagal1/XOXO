import 'package:bestxo/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';



import 'package:bestxo/choice_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Our XO",
      home: AnimatedSplashScreen(
          duration: 2500,
          splash: SplashScreen(),
          nextScreen: ChoiceScreen(),
          // splashTransition: SplashTransition.fadeTransition,
          // pageTransitionType: PageTransitionType.scale,
          backgroundColor: Color.fromRGBO(255, 76, 76, 1)
        )
    );

  }
}












// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 8), () {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ChoiceScreen(),
//           ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlareActor(
//         "assets/13-17-tic-tac-toe.riv",
//         alignment: Alignment.center,
//         fit: BoxFit.contain,
//         animation: "TicTacToe",
//       ),
//     );
//   }
// }





















// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Widget homeShow = PlayerScreen();

//   @override
//   Widget build(BuildContext context) {
//     var appbar = AppBar(
//       title: Text("XO"),
//       actions: [
//         IconButton(
//             onPressed: () {
//               setState(() {
//                 homeShow = BotScreen();
//               });
//             },
//             icon: Icon(Icons.android))
//       ],
//     );
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Our XO",
//       home: Scaffold(
//         appBar: appbar,
//         body: homeShow,
//         backgroundColor: Colors.red.shade400,
//       ),
//     );
//   }
// }

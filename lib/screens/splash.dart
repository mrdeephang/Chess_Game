import 'package:chess_game/screens/gamepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  //SingleTickerProviderStateMixin allows animation to work properly
  late AnimationController
  _controller; //Manages the animation (start/stop/duration)
  late Animation<double>
  _animation; //Handles the actual animation values (like scale size)
  @override
  void initState() {
    //Runs when screen first loads
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this, // makes the animation sync with screen refreshes
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ); // Makes the animation smooth (starts slow, speeds up, ends slow)

    _controller.forward(); //Starts playing the animation

    // Navigate after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(),
        ), //navigation to portfoliopage after splash
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ScaleTransition(
          scale: _animation,

          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                ),
                Lottie.asset(
                  'assets/animations/loading.json',
                  width: 200, // Adjust as needed
                  height: 200,
                  fit: BoxFit.cover,
                  controller: _controller,
                  animate: true,
                  repeat: true,
                  frameRate: FrameRate.max,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

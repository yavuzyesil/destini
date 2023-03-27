import 'package:destini/story_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final sMarPad = const EdgeInsets.all(8.0);
  final mMarPad = const EdgeInsets.all(16.0);
  final imgPath = "images/background.png";
  final transparentBackgroundColor = const Color(0x32000000);
  final redColor = Colors.red;
  final blueColor = Colors.blue;
  ButtonStyle choiceButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
        backgroundColor: color, shape: const RoundedRectangleBorder());
  }

  TextStyle? choiceTextStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: Colors.white);
  }

  StoryService storyService = StoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(imgPath), fit: BoxFit.cover),
          ),
          padding: sMarPad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                      color: transparentBackgroundColor,
                      borderRadius: BorderRadius.circular(16)),
                  margin: sMarPad,
                  child: Center(
                    child: Text(storyService.getStoryTitle(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: sMarPad,
                  child: TextButton(
                    style: choiceButtonStyle(blueColor),
                    onPressed: () {
                      setState(() {
                        storyService.nextStory(1);
                      });
                    },
                    child: Text(
                      storyService.getChoice1(),
                      style: choiceTextStyle(context),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: sMarPad,
                  child: Visibility(
                    visible: storyService.buttonVisibility(),
                    child: ElevatedButton(
                      style: choiceButtonStyle(redColor),
                      onPressed: () {
                        setState(() {
                          storyService.nextStory(2);
                        });
                      },
                      child: Text(
                        storyService.getChoice2(),
                        style: choiceTextStyle(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

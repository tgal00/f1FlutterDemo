import 'package:flutter/material.dart';
import 'package:formula1/constructorStandings.dart';
import 'package:formula1/model/constructors.dart';
import 'package:formula1/schedule.dart';
import 'package:formula1/util/gradient.dart';
import 'package:formula1/driverStandings.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<Homepage> {
  int _currentIndex = 0;

  List<StatefulWidget> options = [
    const Standings(),
    const RacesSchedule(),
    const Constructors(), //directly call the class to load
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _currentIndex = 0;
    options = [
      const Standings(),
      const RacesSchedule(),
      const Constructors(), //directly call the class to load
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      resizeToAvoidBottomInset: false,
      body: options.elementAt(_currentIndex),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: const Color.fromARGB(255, 185, 185, 185),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_rounded),
            label: 'Standings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Races',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Teams',
          ),
        ],
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: const GradientText(
      "F1 Tracker",
      style: TextStyle(
        color: Color.fromARGB(255, 168, 24, 13),
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontStyle: FontStyle.italic,
        letterSpacing: 0.6,
      ),
      gradient: LinearGradient(colors: [
        Color.fromARGB(255, 193, 34, 34),
        Color.fromARGB(255, 255, 0, 0),
      ]),
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 22, 22, 22),
    scrolledUnderElevation: 0,
  );
}

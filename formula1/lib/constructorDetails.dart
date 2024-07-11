import 'package:flutter/material.dart';
import 'package:formula1/constructorStandings.dart';
import 'package:formula1/homepage.dart';
import 'package:formula1/model/constructors.dart';
import 'package:formula1/util/gradient.dart';

class ConstructorInfo extends StatelessWidget {
  final ConstructorStanding constructor;
  const ConstructorInfo({super.key, required this.constructor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 00, 40),
              child: GradientText(
                "Constructor details",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 164, 164, 164),
                  Color.fromARGB(255, 211, 211, 211),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text("Constructor: ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 183, 183, 183),
                        fontSize: 18,
                        letterSpacing: 1.5,
                      )),
                  Text(
                    "${constructor.constructor!.name} (${constructor.constructor!.nationality})",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text("Points: ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 183, 183, 183),
                        fontSize: 18,
                        letterSpacing: 1.5,
                      )),
                  Text(
                    "${constructor.points}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text("Position in championship: ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 183, 183, 183),
                        fontSize: 18,
                        letterSpacing: 1.5,
                      )),
                  Text(
                    "${constructor.position}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text("Wins: ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 183, 183, 183),
                        fontSize: 18,
                        letterSpacing: 1.5,
                      )),
                  Text(
                    "${constructor.wins}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    iconTheme: const IconThemeData(
      color: Colors.red, //change your color here
    ),
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formula1/constructorDetails.dart';
import 'package:formula1/model/constructors.dart';
import 'package:formula1/util/gradient.dart';
import 'package:http/http.dart' as http;

class Constructors extends StatefulWidget {
  const Constructors({super.key});

  @override
  State<Constructors> createState() => _Constructors();
}

class _Constructors extends State<Constructors> {
  late Future<ConstructorsRoot> futureStandings;
  String currentYear = "2024";

  @override
  void initState() {
    super.initState();
    futureStandings = fetchConstructors(currentYear);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConstructorsRoot>(
      future: futureStandings,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ConstructorsRoot data = snapshot.data!;
          int numOfConstructors = data.mRData!.standingsTable!
              .standingsLists![0]!.constructorStandings!.length;
          List<ConstructorStanding>? constructorsStanding = [];
          if (data.mRData!.standingsTable!.standingsLists![0]!
              .constructorStandings!.isNotEmpty) {
            constructorsStanding = data.mRData!.standingsTable!
                .standingsLists![0]!.constructorStandings!
                .cast<ConstructorStanding>();
          }

          return ListView.builder(
              itemCount: numOfConstructors,
              //shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => Container(
                    //color: const Color.fromARGB(255, 43, 43, 43),
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "#${index + 1}",
                              style: TextStyle(
                                color: getFirst3Colors(index),
                                fontSize: 14,
                              ),
                            ),
                            //getDriverFullName(index),
                            GradientText(
                              "${constructorsStanding![index].constructor!.name!}",
                              style: TextStyle(
                                fontSize: index == 0
                                    ? 27
                                    : index == 1
                                        ? 26
                                        : index == 2
                                            ? 25
                                            : 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 164, 164, 164),
                                Color.fromARGB(255, 211, 211, 211),
                              ]),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero, // Set this
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                side: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 49, 49, 49),
                                ),
                                backgroundColor: null,
                                foregroundColor:
                                    Color.fromARGB(255, 154, 154, 154),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ConstructorInfo(
                                      constructor: constructorsStanding![index],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'More info',
                                style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          constructorsStanding[index].points!,
                          style: TextStyle(
                            color: getFirst3Colors(index),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                          ),
                        ),
                      ],
                    ),
                  ));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  getFirst3Colors(int index) {
    return index == 0
        ? const Color.fromARGB(255, 255, 180, 18)
        : index == 1
            ? const Color.fromARGB(255, 192, 192, 192)
            : index == 2
                ? const Color.fromARGB(255, 205, 127, 50)
                : const Color.fromARGB(255, 155, 155, 155);
  }
}

Future<ConstructorsRoot> fetchConstructors(String year) async {
  final response = await http.get(
      Uri.parse('http://ergast.com/api/f1/$year/constructorStandings.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ConstructorsRoot.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

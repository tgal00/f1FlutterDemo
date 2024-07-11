import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formula1/util/gradient.dart';
import 'package:formula1/model/standings.dart';
import 'package:http/http.dart' as http;

class Standings extends StatefulWidget {
  const Standings({super.key});

  @override
  State<Standings> createState() => _Standings();
}

class _Standings extends State<Standings> {
  late Future<StandingsRoot> futureStandings;

  static List<String> list = <String>[];
  //static List<String> list = <String>['2024', '2023', '2022', '2021', '2020'];

  String dropdownValue = '2024';
  String selectedYear = '2024';

  @override
  void initState() {
    super.initState();
    list = [];
    for (int i = 2024; i > 1960; i--) {
      list.add(i.toString());
    }
    futureStandings = fetchStandings(selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<StandingsRoot>(
        future: futureStandings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            StandingsRoot data = snapshot.data!;
            int numOfDrivers = data.mRData!.standingsTable!.standingsLists![0]!
                .driverStandings!.length;
            List<DriverStanding>? driverStandings = [];
            if (data.mRData!.standingsTable!.standingsLists![0]!
                .driverStandings!.isNotEmpty) {
              driverStandings = data
                  .mRData!.standingsTable!.standingsLists![0]!.driverStandings!
                  .cast<DriverStanding>();
            }

            return Column(
              children: [
                DropdownButton<String>(
                  value: dropdownValue,
                  dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                  style:
                      const TextStyle(color: Color.fromARGB(255, 88, 87, 87)),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                      futureStandings = fetchStandings(dropdownValue);
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                ),
                ListView.builder(
                    itemCount: numOfDrivers,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                                  getDriverFullName(index),
                                  Text(
                                    "${driverStandings![index].constructors![0]!.name}",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                driverStandings[index].points!,
                                style: TextStyle(
                                  color: getFirst3Colors(index),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                ),
                              ),
                            ],
                          ),
                        )),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  getDriverFullName(int index) {
    return FutureBuilder<StandingsRoot>(
        future: futureStandings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GradientText(
              "${snapshot.data!.mRData!.standingsTable!.standingsLists![0]!.driverStandings![index]!.driver!.givenName!} ${snapshot.data!.mRData!.standingsTable!.standingsLists![0]!.driverStandings![index]!.driver!.familyName!}",
              style: TextStyle(
                fontSize: index == 0
                    ? 21
                    : index == 1
                        ? 20
                        : index == 2
                            ? 19
                            : 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 164, 164, 164),
                Color.fromARGB(255, 211, 211, 211),
              ]),
            );
          } else {
            return const Text(
              "",
            );
          }
        });
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

Future<StandingsRoot> fetchStandings(String year) async {
  final response = await http
      .get(Uri.parse('http://ergast.com/api/f1/$year/driverStandings.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return StandingsRoot.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

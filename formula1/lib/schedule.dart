import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formula1/model/raceSchedule.dart';
import 'package:formula1/util/gradient.dart';
import 'package:http/http.dart' as http;

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RacesSchedule extends StatefulWidget {
  const RacesSchedule({super.key});

  @override
  State<RacesSchedule> createState() => _RacesScheduleState();
}

class _RacesScheduleState extends State<RacesSchedule> {
  late Future<ScheduleRoot> schedule;
  String selectedYear = "2024";
  int jumpToIndex = -1;
  int currIndex = 0;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    super.initState();
    schedule = fetchSchedule(selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 41, 41, 41),
        label: const Text(
          "Next race",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        onPressed: () {
          getNextRace();
        },
      ),
      body: FutureBuilder<ScheduleRoot>(
        future: schedule,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ScheduleRoot data = snapshot.data!;
            int numOfRaces = data.mRData!.raceTable!.races!.length;
            debugPrint("NUM OF RACES $numOfRaces");
            return ScrollablePositionedList.builder(
              itemCount: numOfRaces,
              itemScrollController: itemScrollController,
              itemBuilder: (context, index) {
                return Container(
                  decoration: index == jumpToIndex
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color.fromARGB(48, 109, 10, 10),
                              Color.fromARGB(49, 23, 49, 155),
                            ],
                          ),
                        )
                      : null,
                  margin: const EdgeInsets.all(20),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Round #${data.mRData!.raceTable!.races![index]!.round!}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 169, 169, 169),
                              fontSize: 12,
                              fontStyle: FontStyle.italic),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.public,
                              color: Color.fromARGB(255, 105, 145, 162),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: GradientText(
                                data.mRData!.raceTable!.races![index]!
                                    .raceName!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 26,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 195, 195, 195),
                                    Color.fromARGB(255, 137, 137, 137),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 148, 146, 84),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                data.mRData!.raceTable!.races![index]!.circuit!
                                    .circuitName!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 175, 175, 175),
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Color.fromARGB(255, 172, 117, 117),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${data.mRData!.raceTable!.races![index]!.date!} ${data.mRData!.raceTable!.races![index]!.time!}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 175, 175, 175),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  void getNextRace() {
    DateTime curr = DateTime.now();
    currIndex = 0;
    DateTime raceDate;
    schedule.then(
      (data) => {
        data.mRData!.raceTable!.races!.forEach(
          (race) {
            raceDate = DateTime.parse(race!.date!);
            if (jumpToIndex == -1) {
              if (raceDate.month < curr.month) {
                setState(() {
                  currIndex += 1;
                });
              } else if (raceDate.month == curr.month &&
                  raceDate.day < curr.day) {
                setState(() {
                  currIndex += 1;
                });
              } else {
                setState(() {
                  jumpToIndex = currIndex;
                });
              }
            }
            itemScrollController.jumpTo(index: jumpToIndex, alignment: 0);
          },
        ),
      },
    );
  }
}

Future<ScheduleRoot> fetchSchedule(String year) async {
  final response =
      await http.get(Uri.parse('http://ergast.com/api/f1/$year.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ScheduleRoot.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Circuit {
  String? circuitId;
  String? url;
  String? circuitName;
  Location? location;

  Circuit({this.circuitId, this.url, this.circuitName, this.location});

  Circuit.fromJson(Map<String, dynamic> json) {
    circuitId = json['circuitId'];
    url = json['url'];
    circuitName = json['circuitName'];
    location =
        json['Location'] != null ? Location?.fromJson(json['Location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['circuitId'] = circuitId;
    data['url'] = url;
    data['circuitName'] = circuitName;
    data['Location'] = location!.toJson();
    return data;
  }
}

class FirstPractice {
  String? date;
  String? time;

  FirstPractice({this.date, this.time});

  FirstPractice.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}

class Location {
  String? lat;
  String? long;
  String? locality;
  String? country;

  Location({this.lat, this.long, this.locality, this.country});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    locality = json['locality'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = lat;
    data['long'] = long;
    data['locality'] = locality;
    data['country'] = country;
    return data;
  }
}

class MRData {
  String? xmlns;
  String? series;
  String? url;
  String? limit;
  String? offset;
  String? total;
  RaceTable? raceTable;

  MRData(
      {this.xmlns,
      this.series,
      this.url,
      this.limit,
      this.offset,
      this.total,
      this.raceTable});

  MRData.fromJson(Map<String, dynamic> json) {
    xmlns = json['xmlns'];
    series = json['series'];
    url = json['url'];
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    raceTable = json['RaceTable'] != null
        ? RaceTable?.fromJson(json['RaceTable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['xmlns'] = xmlns;
    data['series'] = series;
    data['url'] = url;
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    data['RaceTable'] = raceTable!.toJson();
    return data;
  }
}

class Qualifying {
  String? date;
  String? time;

  Qualifying({this.date, this.time});

  Qualifying.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}

class Race {
  String? season;
  String? round;
  String? url;
  String? raceName;
  Circuit? circuit;
  String? date;
  String? time;
  FirstPractice? firstPractice;
  SecondPractice? secondPractice;
  ThirdPractice? thirdPractice;
  Qualifying? qualifying;
  Sprint? sprint;

  Race(
      {this.season,
      this.round,
      this.url,
      this.raceName,
      this.circuit,
      this.date,
      this.time,
      this.firstPractice,
      this.secondPractice,
      this.thirdPractice,
      this.qualifying,
      this.sprint});

  Race.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    round = json['round'];
    url = json['url'];
    raceName = json['raceName'];
    circuit =
        json['Circuit'] != null ? Circuit?.fromJson(json['Circuit']) : null;
    date = json['date'];
    time = json['time'];
    firstPractice = json['FirstPractice'] != null
        ? FirstPractice?.fromJson(json['FirstPractice'])
        : null;
    secondPractice = json['SecondPractice'] != null
        ? SecondPractice?.fromJson(json['SecondPractice'])
        : null;
    thirdPractice = json['ThirdPractice'] != null
        ? ThirdPractice?.fromJson(json['ThirdPractice'])
        : null;
    qualifying = json['Qualifying'] != null
        ? Qualifying?.fromJson(json['Qualifying'])
        : null;
    sprint = json['Sprint'] != null ? Sprint?.fromJson(json['Sprint']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['season'] = season;
    data['round'] = round;
    data['url'] = url;
    data['raceName'] = raceName;
    data['Circuit'] = circuit!.toJson();
    data['date'] = date;
    data['time'] = time;
    data['FirstPractice'] = firstPractice!.toJson();
    data['SecondPractice'] = secondPractice!.toJson();
    data['ThirdPractice'] = thirdPractice!.toJson();
    data['Qualifying'] = qualifying!.toJson();
    data['Sprint'] = sprint!.toJson();
    return data;
  }
}

class RaceTable {
  String? season;
  List<Race?>? races;

  RaceTable({this.season, this.races});

  RaceTable.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    if (json['Races'] != null) {
      races = <Race>[];
      json['Races'].forEach((v) {
        races!.add(Race.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['season'] = season;
    data['Races'] = races?.map((v) => v?.toJson()).toList();
    return data;
  }
}

class ScheduleRoot {
  MRData? mRData;

  ScheduleRoot({this.mRData});

  ScheduleRoot.fromJson(Map<String, dynamic> json) {
    mRData = json['MRData'] != null ? MRData?.fromJson(json['MRData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['MRData'] = mRData!.toJson();
    return data;
  }
}

class SecondPractice {
  String? date;
  String? time;

  SecondPractice({this.date, this.time});

  SecondPractice.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}

class Sprint {
  String? date;
  String? time;

  Sprint({this.date, this.time});

  Sprint.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}

class ThirdPractice {
  String? date;
  String? time;

  ThirdPractice({this.date, this.time});

  ThirdPractice.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}

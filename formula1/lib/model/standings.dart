class Constructor {
  String? constructorId;
  String? url;
  String? name;
  String? nationality;

  Constructor({this.constructorId, this.url, this.name, this.nationality});

  Constructor.fromJson(Map<String, dynamic> json) {
    constructorId = json['constructorId'];
    url = json['url'];
    name = json['name'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['constructorId'] = constructorId;
    data['url'] = url;
    data['name'] = name;
    data['nationality'] = nationality;
    return data;
  }
}

class Driver {
  String? driverId;
  String? permanentNumber;
  String? code;
  String? url;
  String? givenName;
  String? familyName;
  String? dateOfBirth;
  String? nationality;

  Driver(
      {this.driverId,
      this.permanentNumber,
      this.code,
      this.url,
      this.givenName,
      this.familyName,
      this.dateOfBirth,
      this.nationality});

  Driver.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    permanentNumber = json['permanentNumber'];
    code = json['code'];
    url = json['url'];
    givenName = json['givenName'];
    familyName = json['familyName'];
    dateOfBirth = json['dateOfBirth'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driverId'] = driverId;
    data['permanentNumber'] = permanentNumber;
    data['code'] = code;
    data['url'] = url;
    data['givenName'] = givenName;
    data['familyName'] = familyName;
    data['dateOfBirth'] = dateOfBirth;
    data['nationality'] = nationality;
    return data;
  }
}

class DriverStanding {
  String? position;
  String? positionText;
  String? points;
  String? wins;
  Driver? driver;
  List<Constructor?>? constructors;

  DriverStanding(
      {this.position,
      this.positionText,
      this.points,
      this.wins,
      this.driver,
      this.constructors});

  DriverStanding.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    positionText = json['positionText'];
    points = json['points'];
    wins = json['wins'];
    driver = json['Driver'] != null ? Driver?.fromJson(json['Driver']) : null;
    if (json['Constructors'] != null) {
      constructors = <Constructor>[];
      json['Constructors'].forEach((v) {
        constructors!.add(Constructor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = position;
    data['positionText'] = positionText;
    data['points'] = points;
    data['wins'] = wins;
    data['Driver'] = driver!.toJson();
    data['Constructors'] = constructors?.map((v) => v?.toJson()).toList();
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
  StandingsTable? standingsTable;

  MRData(
      {this.xmlns,
      this.series,
      this.url,
      this.limit,
      this.offset,
      this.total,
      this.standingsTable});

  MRData.fromJson(Map<String, dynamic> json) {
    xmlns = json['xmlns'];
    series = json['series'];
    url = json['url'];
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    standingsTable = json['StandingsTable'] != null
        ? StandingsTable?.fromJson(json['StandingsTable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['xmlns'] = xmlns;
    data['series'] = series;
    data['url'] = url;
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    data['StandingsTable'] = standingsTable!.toJson();
    return data;
  }
}

class StandingsRoot {
  MRData? mRData;

  StandingsRoot({this.mRData});

  StandingsRoot.fromJson(Map<String, dynamic> json) {
    mRData = json['MRData'] != null ? MRData?.fromJson(json['MRData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MRData'] = mRData!.toJson();
    return data;
  }
}

class StandingsList {
  String? season;
  String? round;
  List<DriverStanding?>? driverStandings;

  StandingsList({this.season, this.round, this.driverStandings});

  StandingsList.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    round = json['round'];
    if (json['DriverStandings'] != null) {
      driverStandings = <DriverStanding>[];
      json['DriverStandings'].forEach((v) {
        driverStandings!.add(DriverStanding.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['season'] = season;
    data['round'] = round;
    data['DriverStandings'] = driverStandings?.map((v) => v?.toJson()).toList();
    return data;
  }
}

class StandingsTable {
  String? season;
  List<StandingsList?>? standingsLists;

  StandingsTable({this.season, this.standingsLists});

  StandingsTable.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    if (json['StandingsLists'] != null) {
      standingsLists = <StandingsList>[];
      json['StandingsLists'].forEach((v) {
        standingsLists!.add(StandingsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['season'] = season;
    data['StandingsLists'] = standingsLists?.map((v) => v?.toJson()).toList();
    return data;
  }
}

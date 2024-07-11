/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['constructorId'] = constructorId;
    data['url'] = url;
    data['name'] = name;
    data['nationality'] = nationality;
    return data;
  }
}

class ConstructorStanding {
  String? position;
  String? positionText;
  String? points;
  String? wins;
  Constructor? constructor;

  ConstructorStanding(
      {this.position,
      this.positionText,
      this.points,
      this.wins,
      this.constructor});

  ConstructorStanding.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    positionText = json['positionText'];
    points = json['points'];
    wins = json['wins'];
    constructor = json['Constructor'] != null
        ? Constructor?.fromJson(json['Constructor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['position'] = position;
    data['positionText'] = positionText;
    data['points'] = points;
    data['wins'] = wins;
    data['Constructor'] = constructor!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class ConstructorsRoot {
  MRData? mRData;

  ConstructorsRoot({this.mRData});

  ConstructorsRoot.fromJson(Map<String, dynamic> json) {
    mRData = json['MRData'] != null ? MRData?.fromJson(json['MRData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['MRData'] = mRData!.toJson();
    return data;
  }
}

class StandingsList {
  String? season;
  String? round;
  List<ConstructorStanding?>? constructorStandings;

  StandingsList({this.season, this.round, this.constructorStandings});

  StandingsList.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    round = json['round'];
    if (json['ConstructorStandings'] != null) {
      constructorStandings = <ConstructorStanding>[];
      json['ConstructorStandings'].forEach((v) {
        constructorStandings!.add(ConstructorStanding.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['season'] = season;
    data['round'] = round;
    data['ConstructorStandings'] = constructorStandings != null
        ? constructorStandings!.map((v) => v?.toJson()).toList()
        : null;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['season'] = season;
    data['StandingsLists'] = standingsLists != null
        ? standingsLists!.map((v) => v?.toJson()).toList()
        : null;
    return data;
  }
}

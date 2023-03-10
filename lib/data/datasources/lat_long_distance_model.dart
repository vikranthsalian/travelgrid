class MetaLatLongDistanceModel {
  List<Routes>? routes;

  MetaLatLongDistanceModel({this.routes});

  MetaLatLongDistanceModel.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(new Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routes != null) {
      data['routes'] = this.routes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  String? id;
  List<Sections>? sections;

  Routes({this.id, this.sections});

  Routes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? id;
  String? type;
  Departure? departure;
  Departure? arrival;
  Summary? summary;
  Transport? transport;

  Sections(
      {this.id,
        this.type,
        this.departure,
        this.arrival,
        this.summary,
        this.transport});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    departure = json['departure'] != null
        ? new Departure.fromJson(json['departure'])
        : null;
    arrival = json['arrival'] != null
        ? new Departure.fromJson(json['arrival'])
        : null;
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    transport = json['transport'] != null
        ? new Transport.fromJson(json['transport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.departure != null) {
      data['departure'] = this.departure!.toJson();
    }
    if (this.arrival != null) {
      data['arrival'] = this.arrival!.toJson();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.transport != null) {
      data['transport'] = this.transport!.toJson();
    }
    return data;
  }
}

class Departure {
  String? time;
  Place? place;

  Departure({this.time, this.place});

  Departure.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    place = json['place'] != null ? new Place.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    if (this.place != null) {
      data['place'] = this.place!.toJson();
    }
    return data;
  }
}

class Place {
  String? type;
  Location? location;
  Location? originalLocation;

  Place({this.type, this.location, this.originalLocation});

  Place.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    originalLocation = json['originalLocation'] != null
        ? new Location.fromJson(json['originalLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.originalLocation != null) {
      data['originalLocation'] = this.originalLocation!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Summary {
  int? duration;
  int? length;
  int? baseDuration;

  Summary({this.duration, this.length, this.baseDuration});

  Summary.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    length = json['length'];
    baseDuration = json['baseDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['length'] = this.length;
    data['baseDuration'] = this.baseDuration;
    return data;
  }
}

class Transport {
  String? mode;

  Transport({this.mode});

  Transport.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    return data;
  }
}

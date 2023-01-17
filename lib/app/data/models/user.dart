import 'dart:convert';

class Users {
    Users({
        this.id,
        this.data,
    });

    String? id;
    Data? data;

    factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "data": data!.toMap(),
    };
}

class Data {
    Data({
        this.routes,
        this.lastName,
        this.password,
        this.phone,
        this.name,
        this.picture,
    });

    List<Route?>? routes;
    String? lastName;
    String? password;
    String? phone;
    String? name;
    String? picture;

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        routes: json["routes"] == null ? [] : List<Route?>.from(json["routes"]!.map((x) => Route.fromMap(x))),
        lastName: json["lastName"],
        password: json["password"],
        phone: json["phone"],
        name: json["name"],
        picture: json["picture"],
    );

    Map<String, dynamic> toMap() => {
        "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x!.toMap())),
        "lastName": lastName,
        "password": password,
        "phone": phone,
        "name": name,
        "picture": picture,
    };
}

class Route {
    Route({
        this.distances,
        this.name,
        this.picture,
    });

    int? distances;
    String? name;
    String? picture;

    factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Route.fromMap(Map<String, dynamic> json) => Route(
        distances: json["distances"],
        name: json["name"],
        picture: json["picture"],
    );

    Map<String, dynamic> toMap() => {
        "distances": distances,
        "name": name,
        "picture": picture,
    };
}

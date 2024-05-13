class Users {
  String? uId;
  String name;
  String description;
  int years;

  Users({
    this.uId,
    required this.name,
    required this.description,
    required this.years,
  });

  factory Users.fromMap(Map map) {
    return Users(
      uId: map['uId'],
      name: map['name'],
      description: map['description'],
      years: map['years'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'description': description,
      'years': years,
    };
  }
}

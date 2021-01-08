class User {
  String firstName;
  String secondName;
  String email;
  bool isMale;

  User({
    this.firstName,
    this.secondName,
    this.email,
    this.isMale,
  });

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        secondName = json['secondName'],
        email = json['email'],
        isMale = json['isMale'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'secondName': secondName,
        'email': email,
        'isMale': isMale,
      };
}

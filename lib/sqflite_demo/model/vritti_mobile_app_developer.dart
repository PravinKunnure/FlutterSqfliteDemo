class VrittiMobileAppDeveloper {
  int id;
  String firstName;
  String lastName;
  String email;

  VrittiMobileAppDeveloper({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });


  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
  };

}
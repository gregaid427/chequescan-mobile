class User {
  String? user_id;
  String? firstName;
  String? lastName;
  String? otherName;
  String? role;
  String? verified;
  String? contact;
  String? email;
  String? phone;
  String? dob;
  String? access_token;
  String? sex;
  String? otp;

  User(
      {this.user_id,
      this.firstName,
      this.otherName,
      this.lastName,
      this.email,
      this.contact,
      this.access_token,
      this.dob,
      this.role,
      this.sex,
      this.verified,
        this.otp});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      user_id: responseData['user_id'],
      firstName: responseData['firstName'],
      lastName: responseData['lastName'],
      otherName: responseData['otherName'],
      email: responseData['email'],
      contact: responseData['contact'],
      role: responseData['role'],
      access_token: responseData['token'],
      verified: responseData['verified'],
      dob: responseData['dob'],
      otp: responseData['otp'],
    );
  }
}

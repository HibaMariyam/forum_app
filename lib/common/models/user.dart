class Users {
  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.bio,
    required this.image,
    required this.isActive,
    required this.token,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String username;
  late final String email;
  late final String bio;
  late final String image;
  late final bool isActive;
  late final String token;
  
  Users.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    bio = json['bio'];
    image = json['image'];
    isActive = json['is_active'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['username'] = username;
    _data['email'] = email;
    _data['bio'] = bio;
    _data['image'] = image;
    _data['is_active'] = isActive;
    _data['token'] = token;
    return _data;
  }
}
class Thread {
  Thread({
    required this.id,
    required this.user,
    required this.content,
     this.image,
    required this.createdAt,
    required this.isLiked,
    required this.likesCount,
  });
  late final int id;
  late final Author user;
  late final String content;
  String? image;
  late final String createdAt;
  late final bool isLiked;
  late final int likesCount;
  
 Thread.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = Author.fromJson(json['user']);
    content = json['content'];
    image = json['image'] ?? null; 
    createdAt = json['created_at'];
    isLiked = json['is_liked'];
    likesCount = json['likes_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user'] = user.toJson();
    _data['content'] = content;
    _data['image'] = image;
    _data['created_at'] = createdAt;
    _data['is_liked'] = isLiked;
    _data['likes_count'] = likesCount;
    return _data;
  }
}

class Author {
  Author({
    required this.id,
    required this.username,
    required this.image,
    required this.firstName,
    required this.lastName,
  });
  late final int id;
  late final String username;
  late final String image;
  late final String firstName;
  late final String lastName;
  
  Author.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    image = json['image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['image'] = image;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    return _data;
  }
}
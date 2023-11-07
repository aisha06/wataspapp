class ChatUser {
  ChatUser({
    required this.image,
    required this.about,
    required this.name,
    required this.created_at,
    required this.isonline,
    required this.id,
    required this.lastactive,
    required this.email,
    required this.pushToken,
  });
  late String image;
  late String about;
  late String name;
  late String created_at;
  late bool isonline;
  late String id;
  late String lastactive;
  late String email;
  late String pushToken;

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    created_at = json['created_at'] ?? '';
    isonline = json['is_online'] ?? '';
    id = json['id'] ?? '';
    lastactive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = created_at;
    data['is_online'] = isonline;
    data['id'] = id;
    data['last_active'] = lastactive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}
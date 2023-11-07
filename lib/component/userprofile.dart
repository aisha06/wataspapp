
class UserProfile {

  final String displayName;
  // You can add more fields as needed

  UserProfile({

    required this.displayName,

  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,

    };
  }
}
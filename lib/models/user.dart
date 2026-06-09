class User {
  final String id;
  final String username;
  final String email;
  final String profileImageUrl;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImageUrl = 'https://via.placeholder.com/150',
  });
}

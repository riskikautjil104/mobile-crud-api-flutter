class User {
  final String createdAt;
  final String name;
  final String avatar;
  final String id;

  const User({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createdAt: json['createdAt'],
      name: json['name'],
      avatar: json['avatar'],
      id: json['id'],
    );
  }
}

// "createdAt": "2023-10-02T12:19:07.456Z",
//         "name": "Harry Boyle",
//         "avatar": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/997.jpg",
//         "id": "1"
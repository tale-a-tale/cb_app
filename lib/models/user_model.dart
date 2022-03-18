class AppUser {
  final String id;
  final String name;
  final String email;
  final String userRole;

  AppUser({this.id, this.name, this.email, this.userRole});

  AppUser.fromData(Map<String, dynamic> data)
      : id = data['id'], name = data['name'], email=  data['email'], userRole = data['userRole'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userRole':userRole,
    };
  }
}
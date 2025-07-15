class User {
  String id;
  String name;
  String email;
  String password;
  String phone;
  String province;
  String street;
  String photoUrl;

  static List<User> _allUsers = [];

  User({
    this.id = '1',
    this.name = '',
    required this.email,
    this.password = '',
    this.phone = '',
    this.province = '',
    this.street = '',
    this.photoUrl = 'assets/profile/user.png',
  }) {
    _allUsers.add(this);
  }

  // get and set methods for name, email, password, phone, province, street
  String get getName => name;
  set setName(String name) => this.name = name;
  String get getEmail => email;
  set setEmail(String email) => this.email = email;
  String get getPassword => password;
  set setPassword(String password) => this.password = password;
  String get getPhone => phone;
  set setPhone(String phone) => this.phone = phone;
  String get getProvince => province;
  set setProvince(String province) => this.province = province;
  String get getStreet => street;
  set setStreet(String street) => this.street = street;

  // Factory constructor for creating User from Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      phone: map['phone'] ?? '',
      province: map['province'] ?? '',
      street: map['street'] ?? '',
    );
  }
  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, phone: $phone, province: $province, street: $street}';
  }

  // Mock data
  static List<User> getMockUsers() {
    return List.from(_allUsers);
  }

  static User getMockUser() {
    if (_allUsers.isEmpty) {
      // Tạo user mặc định nếu danh sách rỗng
      return User(
        id: 'mock_id',
        name: 'Default User',
        email: 'default@example.com',
        password: 'password123',
        phone: '+84000000000',
        province: 'ádasdasdasda',
        street: 'ádasdasdasdasd',
      );
    }
    return _allUsers.last;
  }

  // Get a single mock user
  // create a user from email and password and phone number
  static User createUser(String email, String password, String phone) {
    return User(email: email, password: password, phone: phone);
  }
  static User createGoogleUser(
      String email, String name, String photoUrl) {
    return User(email: email, name: name, photoUrl: photoUrl);
  }

  static void clearAllUsers() {
    _allUsers.clear();
  }

  static User? authenticate(String email, String password) {
    for (var user in _allUsers) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }
    return null; // Return null if no user matches
  }

  static bool userExists(String email) {
    for (var user in _allUsers) {
      if (user.email == email) {
        return true; // User with this email already exists
      }
    }
    return false; // No user with this email found
  }
}

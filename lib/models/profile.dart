class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final bool isStaff;
  final bool isActive;
  final DateTime dateJoined;
  final String? phone; // Nullable alanlar için "?" ekledik
  final bool isSuperuser;
  final DateTime? birthDate; // Nullable alanlar için "?" ekledik

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    this.phone,
    required this.isSuperuser,
    this.birthDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullName: json['full_name'],
      email: json['email'],
      isStaff: json['is_staff'],
      isActive: json['is_active'],
      dateJoined: DateTime.parse(json['date_joined']),
      phone: json['phone'],
      isSuperuser: json['is_superuser'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
    );
  }
}

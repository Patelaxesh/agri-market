class RegistrationParams {
  final String name;
  final String email;
  final String password;
  final String mobile;
  final String role;
  final String? village;
  final String? state;
  final String? businessName;
  final String? city;
  final String? buyerType;

  RegistrationParams({
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.role,
    this.village,
    this.state,
    this.businessName,
    this.city,
    this.buyerType,
  });
}
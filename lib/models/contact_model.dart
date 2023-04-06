class Contact {
  final String id;
  final String contactName;
  final String contactSirName;
  final String companyName;
  final int phoneNumber;
  final String emailAddress;
  Contact({
    required this.id,
    required this.contactName,
    required this.contactSirName,
    required this.companyName,
    required this.phoneNumber,
    required this.emailAddress,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': contactName,
      'sirname': contactSirName,
      'companyname': companyName,
      'phonenumber': phoneNumber,
      'email': emailAddress
    };
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $contactName, sirname: $contactSirName, companyname: $companyName, phonenumber: $phoneNumber, email: $emailAddress}';
  }
}

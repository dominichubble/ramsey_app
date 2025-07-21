class Commissioner {
  final String id;
  final String name;
  final String title;
  final String party;
  final String constituency;
  final String email;
  final String phone;
  final String bio;
  final String imageUrl;
  final List<String> responsibilities;
  final DateTime electedDate;

  Commissioner({
    required this.id,
    required this.name,
    required this.title,
    required this.party,
    required this.constituency,
    required this.email,
    required this.phone,
    required this.bio,
    required this.imageUrl,
    required this.responsibilities,
    required this.electedDate,
  });

  String get yearsInOffice {
    final now = DateTime.now();
    final years = now.difference(electedDate).inDays ~/ 365;
    return years == 1 ? '1 year' : '$years years';
  }
}

enum CommissionerType { local, parish, government }

extension CommissionerTypeExtension on CommissionerType {
  String get displayName {
    switch (this) {
      case CommissionerType.local:
        return 'Local Commissioner';
      case CommissionerType.parish:
        return 'Parish Commissioner';
      case CommissionerType.government:
        return 'Government Official';
    }
  }

  String get description {
    switch (this) {
      case CommissionerType.local:
        return 'Elected representatives for local government';
      case CommissionerType.parish:
        return 'Representatives for parish-level governance';
      case CommissionerType.government:
        return 'Government department officials';
    }
  }
}

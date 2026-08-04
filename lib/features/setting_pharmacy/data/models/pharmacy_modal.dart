class PharmacyProfile {
  final String name;
  final String pharmacistName;
  final String address;
  final String openTime;
  final String closeTime;
  final bool isOpen;
  final double rating;
  final int deliveredCount;
  final int todayOrdersCount;

  const PharmacyProfile({
    required this.name,
    required this.pharmacistName,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.isOpen,
    required this.rating,
    required this.deliveredCount,
    required this.todayOrdersCount,
  });
}
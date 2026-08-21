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
class PharmacyModel {
  final PharmacyLocalizedText name;
  final PharmacyLocalizedText address;
  final String area;
  final String phone;
  final PharmacyLocation location;

  PharmacyModel({
    required this.name,
    required this.address,
    required this.area,
    required this.phone,
    required this.location,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      name: PharmacyLocalizedText.fromJson(json['name']),
      address: PharmacyLocalizedText.fromJson(json['address']),
      area: json['area'],
      phone: json['phone'],
      location: PharmacyLocation.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      'address': address.toJson(),
      'area': area,
      'phone': phone,
      'location': location.toJson(),
    };
  }
}

class PharmacyLocalizedText {
  final String ar;
  final String en;

  PharmacyLocalizedText({
    required this.ar,
    required this.en,
  });

  factory PharmacyLocalizedText.fromJson(Map<String, dynamic> json) {
    return PharmacyLocalizedText(
      ar: json['ar'],
      en: json['en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}

class PharmacyLocation {
  final double lat;
  final double lng;

  PharmacyLocation({
    required this.lat,
    required this.lng,
  });

  factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
    return PharmacyLocation(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
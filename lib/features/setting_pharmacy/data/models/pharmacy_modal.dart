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
   bool isOpen;

  PharmacyModel({
    required this.name,
    required this.address,
    required this.area,
    required this.phone,
    required this.location,
    required this.isOpen,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      name: PharmacyLocalizedText.fromJson(json['name']),
      address: PharmacyLocalizedText.fromJson(json['address']),
      area: json['area'],
      phone: json['phone'],
      location: PharmacyLocation.fromJson(json['location']),
      isOpen: json['isOpen'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      'address': address.toJson(),
      'area': area,
      'phone': phone,
      'location': location.toJson(),
      'isOpen': isOpen,
    };
  }
  PharmacyModel copyWith({
    PharmacyLocalizedText? name,
    PharmacyLocalizedText? address,
    String? area,
    String? phone,
    PharmacyLocation? location,
    bool? isOpen,
  }) {
    return PharmacyModel(
      name: name ?? this.name,
      address: address ?? this.address,
      area: area ?? this.area,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      isOpen: isOpen ?? this.isOpen,
    );
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
      ar: json['ar'] ?? '',
      en: json['en'] ?? '',
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
    // Backend يرجع GeoJSON:
    // coordinates = [longitude, latitude]
    if (json['coordinates'] != null) {
      final coordinates = json['coordinates'] as List;

      return PharmacyLocation(
        lng: (coordinates[0] as num).toDouble(),
        lat: (coordinates[1] as num).toDouble(),
      );
    }

    // لو الـBackend رجع lat / lng مباشرة
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



import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/api/utils/to_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';

import '../../../core/enums/gender.dart';
import '../facility.dart';

class User extends BaseModel {
  // User information
  String? firstName;
  String? lastName;
  String? email;
  Gender? gender;
  DateTime? birthdate;
  String? birthPlace;
  String? phoneNumber;
  String? passport;
  String? website;
  String? secondaryPhoneNumber;
  String? zipCode;
  String? occupation;
  String? cnssNumber;
  String? country;
  String? city;
  String? address;
  String? postalCode;
  String? bank;
  String? rib;
  String? enterprise;
  String? barcode;
  int? uniqueNumber;
  String? description;

  // Scholarship information
  Facility? facility;
  List<Facility>? ownedFacilities;

  String? imageFilename;
  String? fcmToken;

  User({
    required super.id,
    this.firstName,
    this.lastName,
    this.email,
    this.cnssNumber,
    this.rib,
    this.address,
    this.enterprise,
    this.bank,
    this.barcode,
    this.birthPlace,
    this.birthdate,
    this.city,
    this.country,
    this.description,
    this.gender,
    this.phoneNumber,
    this.occupation,
    this.passport,
    this.postalCode,
    this.secondaryPhoneNumber,
    this.uniqueNumber,
    this.website,
    this.zipCode,
  });

  User.fromId(String? id) : super(id: id);

  factory User.fromMap(map) {
    if (map is String) return User.fromId(map);
    return User(
        id: FromJson.string(map['_id'] ?? map['id']),
        firstName: FromJson.string(map['firstName']),
        lastName: FromJson.string(map['lastName']),
        email: FromJson.string(map['email']),
        gender: FromJson.enumValue(map['gender'], Gender.values),
        birthdate: FromJson.dateTime(map['birthday']),
        birthPlace: FromJson.string(map['birthPlace']),
        phoneNumber: FromJson.string(map['phoneNumber']),
        passport: FromJson.string(map['passport']),
        website: FromJson.string(map['website']),
        secondaryPhoneNumber: FromJson.string(map['secondaryPhoneNumber']),
        zipCode: FromJson.string(map['zipCode']),
        occupation: FromJson.string(map['occupation']),
        cnssNumber: FromJson.string(map['cnssNumber']),
        country: FromJson.string(map['country']),
        city: FromJson.string(map['city']),
        address: FromJson.string(map['address']),
        postalCode: FromJson.string(map['postalCode']),
        bank: FromJson.string(map['bank']),
        enterprise: FromJson.string(map['enterprise']),
        barcode: FromJson.string(map['barcode']),
        uniqueNumber: FromJson.integer(map['uniqueNumber']),
        description: FromJson.string(map['description']),
        rib: FromJson.string(map['rib']));
  }

  @override
  Map<String, Object> toMap() {
    final map = <String, Object>{};

    map.add('_id', id);
    map.add('firstName', firstName);
    map.add('lastName', lastName);
    map.add('email', email);
    map.add('gender', gender?.databaseValue);
    map.add('birthday', ToJson.date(birthdate));
    map.add('birthPlace', birthPlace);
    map.add('phoneNumber', phoneNumber?.replaceAll('+', ''));
    map.add('address', address);
    map.add('imageUrl', imageFilename);
    map.add('facility', facility?.id);
    map.add('fcmToken', fcmToken);

    return map;
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class AppColors {
  static Color oldLace = const Color.fromARGB(255, 255, 248, 235);
  static Color peachCrayola = const Color.fromARGB(255, 255, 196, 155);
  static Color cadetBlueCrayola = const Color.fromARGB(255, 173, 182, 196);
  static Color charcoal = const Color.fromARGB(255, 41, 76, 96);
  static Color oxfordBlue = const Color.fromARGB(255, 0, 27, 46);
}

class ThemeProvider {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.charcoal,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.black,
    backgroundColor: AppColors.oldLace,
    scaffoldBackgroundColor: AppColors.oldLace,
    colorScheme: ColorScheme.light(primary: AppColors.peachCrayola),
    fontFamily: 'Comfortaa',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: AppColors.oxfordBlue),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.peachCrayola,
      foregroundColor: Colors.black,
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: Colors.black,
      selectedTileColor: AppColors.peachCrayola.withAlpha(40),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.peachCrayola,
    primaryColorLight: Colors.black,
    primaryColorDark: Colors.white,
    backgroundColor: AppColors.oxfordBlue,
    scaffoldBackgroundColor: AppColors.oxfordBlue,
    colorScheme: ColorScheme.dark(primary: AppColors.charcoal),
    fontFamily: 'Comfortaa',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: AppColors.oldLace),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.charcoal,
      foregroundColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: Colors.white,
      selectedTileColor: AppColors.charcoal.withAlpha(40),
    ),
  );
}

class DocumentSerializer
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentSerializer();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}

class LatLngSerializer implements JsonConverter<LatLng, JsonResponse> {
  const LatLngSerializer();

  @override
  LatLng fromJson(JsonResponse json) => LatLng(
        json['latitude'],
        json['longtitude'],
      );

  @override
  JsonResponse toJson(LatLng latLng) => <String, dynamic>{
        'latitude': latLng.latitude,
        'longtitude': latLng.longitude,
      };
}

typedef JsonResponse = Map<String, dynamic>;

enum SortOrder { nameAscending, priceAscending, priceDescending }
enum OrderStatus {
  preparing,
  overdue,
  completed,
}

@JsonEnum(fieldRename: FieldRename.snake)
enum OrderMode {
  eatingIn,
  takingAway,
}

@JsonEnum(fieldRename: FieldRename.snake)
enum PaymentMethod {
  cash,
  cardDetails,
  googlePay,
}

final $OrderStatusEnumMap = {
  OrderStatus.preparing: 'preparing',
  OrderStatus.overdue: 'overdue',
  OrderStatus.completed: 'completed',
};

final $OrderModeEnumMap = {
  OrderMode.eatingIn: 'eating_in',
  OrderMode.takingAway: 'taking_away',
};

final $PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.cardDetails: 'cardDetails',
  PaymentMethod.googlePay: 'googlePay',
};

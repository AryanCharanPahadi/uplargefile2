// To parse this JSON data, do
//
//     final tourDetails = tourDetailsFromJson(jsonString);

import 'dart:convert';

List<TourDetails> tourDetailsFromJson(String str) => List<TourDetails>.from(json.decode(str).map((x) => TourDetails.fromJson(x)));

String tourDetailsToJson(List<TourDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TourDetails {
    String tourId;
    String allSchool;

    TourDetails({
        required this.tourId,
        required this.allSchool,
    });

    factory TourDetails.fromJson(Map<String, dynamic> json) => TourDetails(
        tourId: json["tourId"],
        allSchool: json["AllSchool"],
    );

    Map<String, dynamic> toJson() => {
        "tourId": tourId,
        "AllSchool": allSchool,
    };
}

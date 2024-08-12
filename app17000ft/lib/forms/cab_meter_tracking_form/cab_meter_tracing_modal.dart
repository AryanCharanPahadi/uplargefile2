// ignore_for_file: file_names

import 'dart:convert';

List<CabMeterTracingRecords> cabMeterTracingRecordsFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<CabMeterTracingRecords>.from(
        json.decode(str).map((x) => CabMeterTracingRecords.fromJson(x)));

String cabMeterTracingRecordsToJson(List<CabMeterTracingRecords> data) =>
    json.encode(
        List<dynamic>.from(data.map((x) => x.toJson())));

class CabMeterTracingRecords {
  CabMeterTracingRecords({
    this.id,
    this.status,
    this.placeVisit,
    this.remarks,
    this.vehicleNo,
    this.driverName,
    this.meterReading,
    this.image,
    this.uid,
    this.createdAt,
    this.office,
    this.version,
    this.uniqueId,
    this.tourId,
  });

  int? id;
  String? status;
  String? placeVisit;
  String? remarks;
  String? vehicleNo;
  String? driverName;
  String? meterReading;
  String? image;
  String? uid;
  String? createdAt;
  String? office;
  String? version;
  String? uniqueId;
  String? tourId;
  factory CabMeterTracingRecords.fromJson(Map<String, dynamic> json) =>
      CabMeterTracingRecords(
        id: json["id"],
        status: json["status"],
        placeVisit: json["place_visit"],
        remarks: json["remarks"],
        vehicleNo: json["vehicle_no"],
        driverName: json["driver_name"],
        meterReading: json["meter_reading"],
        image: json["image"],
        uid: json["uid"],
        createdAt: json["created_at"],
        office: json["office"],
        version: json["version"],
        uniqueId: json["uniqueId"],
        tourId: json["tour_id"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "place_visit": placeVisit,
    "remarks": remarks,
    "vehicle_no": vehicleNo,
    "driver_name": driverName,
    "meter_reading": meterReading,
    "image": image,
    "uid": uid,
    "created_at": createdAt,
    "office": office,
    "version": version,
    "uniqueId": uniqueId,
    "tour_id": tourId,
  };
}

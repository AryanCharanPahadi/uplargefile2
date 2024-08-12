import 'dart:convert';

List<InPersonQuantitativeRecords?>? inPersonQuantitativeRecordsFromJson(String str) =>
    str.isEmpty ? [] : List<InPersonQuantitativeRecords?>.from(json.decode(str).map((x) => InPersonQuantitativeRecords.fromJson(x)));
String inPersonQuantitativeRecordsToJson(List<InPersonQuantitativeRecords?>? data) =>
    json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));
class InPersonQuantitativeRecords {
  InPersonQuantitativeRecords({
    this.id,
    this.tourId,
    this.school,
    this.udiseCode,
    this.correctUdise,
    this.image,
    required this.noOfEnrolled,
    this.isDigilabSchedule,
    this.Schedule2Hours,
    this.instrucRegardingClass,
    this.remarksOnDigiLab,
    this.admin_appointed,
    this.admin_trained,
    this.admin_name,
    this.admin_number,
    this.subjectTeachersTrained,
    this.idsOnTheTabs,
    this.teacherComfortUsingTab,
    this.staffAttendedTraining,
    this.image2,
    this.otherTopics,
    this.practicalDemo,
    this.reasonPracticalDemo,

    this.commentOnTeacher,
    this.childComforUsingTab,
    this.childAbleToUndersContent,
    this.postTestByChild,
    this.teachHelpChild,
    this.digiLogBeFill,
    this.correcDigiLogFill,
    this.isReportDoneEachTab,
    this.facilitAppInstallPhone,
    this.dataSynced,
    this.dateOfDataSyn,
    this.libraryTimeTable,
    this.timeTableFollow,
    this.registerUpdated,
    this.additiObservLibrary,
    this.refreshTrainTopic,
    this.participantsData,
    this.issueAndResolution,
    this.uid,
    this.createdAt,
    this.office,
    this.version,
    this.uniqueId,
  });

  int? id;
  String? tourId;
  String? school;
  String? udiseCode;
  String? correctUdise;
  String? image;
  String noOfEnrolled;
  String? isDigilabSchedule;
  String? Schedule2Hours;
  String? instrucRegardingClass;
  String? remarksOnDigiLab;
  String? admin_appointed;
  String? admin_trained;
  String? admin_name;
  String? admin_number;
  String? subjectTeachersTrained;
  String? idsOnTheTabs;
  String? teacherComfortUsingTab;
  String? staffAttendedTraining;
  String? image2;
  String? otherTopics;
  String? practicalDemo;
  String? reasonPracticalDemo;

  String? commentOnTeacher;
  String? childComforUsingTab;
  String? childAbleToUndersContent;
  String? postTestByChild;
  String? teachHelpChild;
  String? digiLogBeFill;
  String? correcDigiLogFill;
  String? isReportDoneEachTab;
  String? facilitAppInstallPhone;
  String? dataSynced;
  String? dateOfDataSyn;
  String? libraryTimeTable;
  String? timeTableFollow;
  String? registerUpdated;
  String? additiObservLibrary;
  String? refreshTrainTopic;
  String? participantsData;
  String? issueAndResolution;
  String? uid;
  String? createdAt;
  String? office;
  String? version;
  String? uniqueId;

  factory InPersonQuantitativeRecords.fromJson(Map<String, dynamic> json) => InPersonQuantitativeRecords(
    id: json["id"],
    tourId: json["tour_id"],
    school: json["school"],
    udiseCode: json["udise_code"],
    correctUdise: json["correctUdise"],
    image: json["image"],
    noOfEnrolled: json["noOfEnrolled"],
    isDigilabSchedule: json["isDigilabSchedule"],
    Schedule2Hours: json["Schedule2Hours"],
    instrucRegardingClass: json["instrucRegardingClass"],
    remarksOnDigiLab: json["remarksOnDigiLab"],
    admin_appointed: json["admin_appointed"],
    admin_trained: json["admin_trained"],
    admin_name: json["admin_name"],
    admin_number: json["admin_number"],
    subjectTeachersTrained: json["subjectTeachersTrained"],
    idsOnTheTabs: json["idsOnTheTabs"],
    teacherComfortUsingTab: json["teacherComfortUsingTab"],
    staffAttendedTraining: json["staff_attended_training"],
    image2: json["image2"],
    otherTopics: json["other_topics"],
    practicalDemo: json["practicalDemo"],
    reasonPracticalDemo: json["reasonPracticalDemo"],
    commentOnTeacher: json["commentOnTeacher"],
    childComforUsingTab: json["childComforUsingTab"],
    childAbleToUndersContent: json["childAbleToUndersContent"],
    postTestByChild: json["postTestByChild"],
    teachHelpChild: json["teachHelpChild"],
    digiLogBeFill: json["digiLogBeFill"],
    correcDigiLogFill: json["correcDigiLogFill"],
    isReportDoneEachTab: json["isReportDoneEachTab"],
    facilitAppInstallPhone: json["facilitAppInstallPhone"],
    dataSynced: json["dataSynced"],
    dateOfDataSyn: json["dateOfDataSyn"],
    libraryTimeTable: json["libraryTimeTable"],
    timeTableFollow: json["timeTableFollow"],
    registerUpdated: json["registerUpdated"],
    additiObservLibrary: json["additiObservLibrary"],
    refreshTrainTopic: json["refreshTrainTopic"],
    participantsData: json["participantsData"],
    issueAndResolution: json["issueAndResolution"],
    uid: json["uid"],
    createdAt: json["created_at"],
    office: json["office"],
    version: json["version"],
    uniqueId: json["unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tour_id": tourId,
    "school": school,
    "udise_code": udiseCode,
    "correctUdise": correctUdise,
    "image": image,
    "noOfEnrolled": noOfEnrolled,
    "isDigilabSchedule": isDigilabSchedule,
    "Schedule2Hours": Schedule2Hours,
    "instrucRegardingClass": instrucRegardingClass,
    "remarksOnDigiLab": remarksOnDigiLab,
    "admin_appointed": admin_appointed,
    "admin_trained": admin_trained,
    "admin_name": admin_name,
    "admin_number": admin_number,
    "subjectTeachersTrained": subjectTeachersTrained,
    "idsOnTheTabs": idsOnTheTabs,
    "teacherComfortUsingTab": teacherComfortUsingTab,
    "staff_attended_training": staffAttendedTraining,
    "image2": image2,
    "other_topics": otherTopics,
    "practicalDemo": practicalDemo,
    "reasonPracticalDemo": reasonPracticalDemo,
    "commentOnTeacher": commentOnTeacher,
    "childComforUsingTab": childComforUsingTab,
    "childAbleToUndersContent": childAbleToUndersContent,
    "postTestByChild": postTestByChild,
    "teachHelpChild": teachHelpChild,
    "digiLogBeFill": digiLogBeFill,
    "correcDigiLogFill": correcDigiLogFill,
    "isReportDoneEachTab": isReportDoneEachTab,
    "facilitAppInstallPhone": facilitAppInstallPhone,
    "dataSynced": dataSynced,
    "dateOfDataSyn": dateOfDataSyn,
    "libraryTimeTable": libraryTimeTable,
    "timeTableFollow": timeTableFollow,
    "registerUpdated": registerUpdated,
    "additiObservLibrary": additiObservLibrary,
    "refreshTrainTopic": refreshTrainTopic,
    "participantsData": participantsData,
    "issueAndResolution": issueAndResolution,
    "uid": uid,
    "created_at": createdAt,
    "office": office,
    "version": version,
    "unique_id": uniqueId,
  };
}

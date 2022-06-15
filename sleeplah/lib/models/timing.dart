import 'package:cloud_firestore/cloud_firestore.dart';

class TimingModel {
  DateTime bedDateTime;
  DateTime wakeUpDateTime;
  int durationHour;
  int durationMinute;
  String docRef = "";

  TimingModel(this.bedDateTime, this.wakeUpDateTime, this.durationHour,
      this.durationMinute);

  TimingModel.fromDatabase(this.bedDateTime, this.wakeUpDateTime, this.durationHour,
      this.durationMinute, String ref) {
    docRef = ref;
  }
}
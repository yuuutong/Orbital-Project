import 'package:sleeplah/database.dart';

class check {
  Future<bool> compareTime(String date) async {
    DateTime sleepActual = await DB().getSleepActual(date);
    DateTime sleepSet = await DB().getSleepSet(date);
    DateTime wakeActual = await DB().getWakeActual(date);
    DateTime wakeSet = await DB().getWakeSet(date);
    return (sleepSet.isAfter(sleepActual) && wakeSet.isAfter(wakeActual));
  }
}

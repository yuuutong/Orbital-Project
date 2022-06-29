import 'package:sleeplah/Database.dart';

class check {
  //bool ifOnTime = false;

  Future<bool> compareTime(String date) async {
    // String sleepTimeSet = await DB().getSleepTime(date);
    // String sleepTimeActual = await DB().getActualSleepTime(date);
    // String wakeTimeSet = await DB().getWakeTime(date);
    // String wakeTimeActual = await DB().getActualWakeTime(date);
    // DateTime sleepSet =
    //     await DB().convertToDateTime(date, sleepTimeSet);
    // DateTime sleepActual =
    //     await DB().convertToDateTime(date, sleepTimeActual);
    // DateTime wakeSet =
    //     await DB().convertToDateTime(date, wakeTimeSet);
    // DateTime wakeActual =
    //     await DB().convertToDateTime(date, wakeTimeActual);
    // return ((!sleepActual.isAfter(sleepSet)) && (!wakeActual.isAfter(wakeSet)));
    return false;
  }
}

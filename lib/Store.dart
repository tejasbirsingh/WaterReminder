class stats {
  DateTime date;
  int intake;

  stats(this.date, this.intake);
}

List<stats> recordListparse (String text) {
  var listOfRecord = List<stats>();
  var total = text.split('\n');

  total.removeLast(); // removes the amount of water consumed from the data stores in memory


  total.forEach((record) {
    var Date = record
        .split(' ')
        .first
        .split('-');

    var intake = int.parse(record
        .split(' ')
        .last);

    DateTime currentDate = DateTime.utc(
        int.parse(Date[0]), int.parse(Date[1]), int.parse(Date[2]));
    listOfRecord.add(stats(currentDate, intake));
  });
  return listOfRecord;
}


String dataInString(List<stats> recordList) {
  String save = '';
  recordList.forEach((record) {
    save = save +
        '${record.date.year}-${record.date.month}-${record.date.day} ${record
            .intake}\n';
  });
  return save;
}


stats getTodayFromRecordList(List<stats> recordList) {
  stats lastRecord = recordList.last;
  DateTime today = DateTime.now();
  if (lastRecord.date.year == today.year &&
      lastRecord.date.month == today.month &&
      lastRecord.date.day == today.day) {
    return lastRecord;
  }
  recordList.add(stats(DateTime.now(), 0));
  return recordList.last;
}


List<stats> addtodayData(int intake,
    List<stats> recordList)
{
  stats lastRecord = recordList.last;
  DateTime today = DateTime.now();
  if (lastRecord.date.year == today.year &&
      lastRecord.date.month == today.month &&
      lastRecord.date.day == today.day) {
    recordList.last.intake = intake;
  } else {
    recordList.add(stats(today, intake));
  }
  return recordList;
}

void main() {
  DateTime now = DateTime.now();
  String formattedDateTime = "${now.year}${now.month}${(now.day)}"
      "${(now.hour)}${(now.minute)}${(now.second)}${now.microsecond}";
  print('$formattedDateTime.jpg');
}

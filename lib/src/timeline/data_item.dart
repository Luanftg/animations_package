class DataItem {
  DateTime timestamp;
  double? value;
  String? name;
  Object? object;
  DataItem({
    required this.timestamp,
    this.value,
    this.name,
    this.object,
  });
}

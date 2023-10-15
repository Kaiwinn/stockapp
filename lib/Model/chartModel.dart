class ChartModel {
  int timestamp;
  double? open;
  double? high;
  double? low;
  double? close;

  ChartModel({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

//  factory constructor trả về bất kì đối tượng nào ( không nhất thiết phải là đối tượng mới).
// constructor thông thường chỉ trả về giá trị mới.
  factory ChartModel.fromJSON(List l) {
    return ChartModel(
      timestamp: l[0] ?? 0,
      open: l[1] ?? 0,
      high: l[2] ?? 0,
      low: l[3] ?? 0,
      close: l[4] ?? 0,
    );
  }
}

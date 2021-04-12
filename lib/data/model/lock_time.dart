class LockTime {
  int from;
  int to;
  LockTime({this.from,this.to});
  Map<String, dynamic> toJson() => {
    "from": from == null ? null : from,
    "to": to == null ? null : to,
  };
}

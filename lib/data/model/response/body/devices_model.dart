class DeviceModel {
  String? deviceId;
  String? deviceName;
  String? createdAt;

  DeviceModel({
    this.deviceId,
    this.deviceName,
    this.createdAt,
  });

  DeviceModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    deviceName = json['device_name'];
    createdAt = json['created_at'];
  }
}

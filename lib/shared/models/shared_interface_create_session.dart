class SharedInterfaceCreateSession {
  final int constructorId;
  final int assistantId;
  final String sessionDate;
  final String deviceId;
  final String deviceLat;
  final String deviceLon;
  final String deviceIp;

  Map<String, dynamic> get object {
    return {
      'gen_session_constructor': constructorId,
      'gen_session_assistant': assistantId,
      'gen_session_date': sessionDate,
      'gen_session_device_id': deviceId,
      'gen_session_device_lat': deviceLat,
      'gen_session_device_lon': deviceLon,
      'gen_session_device_ip': deviceIp,
    };
  }

  SharedInterfaceCreateSession({
    required this.constructorId,
    required this.assistantId,
    required this.sessionDate,
    required this.deviceId,
    required this.deviceLat,
    required this.deviceLon,
    required this.deviceIp,
  });
}

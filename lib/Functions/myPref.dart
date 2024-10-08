import 'package:get_storage/get_storage.dart';

class MyPref {
  static GetStorage? _dataPreference; // Properly typed variable
  static MyPref? _instance;

  // Private constructor
  MyPref._() {
    _dataPreference = GetStorage(); // Initialize GetStorage
  }

  // Factory constructor
  factory MyPref() {
    _instance ??= MyPref._(); // Ensure only one instance is created
    return _instance!;
  }

  void setLoginData(String? data) {
    _dataPreference?.write('user-data', data ?? '');
  }

  String getLoginData() {
    return _dataPreference?.read('user-data') ?? '';
  }

  bool loginStatus() {
    return _dataPreference?.read('user-data') != null;
  }

  void logout() {
    _dataPreference!.erase();
  }
}

import 'package:get_storage/get_storage.dart';

class MFLocalStorage {
  late final GetStorage _storage;

  static MFLocalStorage? _instance;
  MFLocalStorage._internal();

  factory MFLocalStorage.instance() {
    _instance ??= MFLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String buckName) async {
    await GetStorage.init(buckName);
    _instance = MFLocalStorage._internal();
    _instance!._storage = GetStorage(buckName);
  }

  // Generic method to save data
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}


// / *** *** *** *** *** Example *** *** *** *** *** ///

// LocalStorage localStorage = LocalStorage();

// // Save data
// localStorage.saveData('username', 'JohnDoe');

// // Read data
// String? username = localStorage.readData<String>('username');
// print('Username: $username'); // Output: Username: JohnDoe

// // Remove data
// localStorage.removeData('username');

// // Clear all data
// localStorage.clearAll();


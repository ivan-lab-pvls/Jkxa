import 'package:shared_preferences/shared_preferences.dart';

const String _ktotalIncomeKey = 'totalIncome';
const String _ktotalSpendKey = 'totalSpend';

const String _kspendBillsKey = 'spendBills';
const String _kincomeBillsKey = 'incomeBills';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  dynamic _getData(String key) {
    var value = _preferences.get(key);

    print('Retrieved $key: $value');

    return value;
  }

  void _saveData(String key, dynamic value) {
    print('Saving $key: $value');

    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }

  double get totalIncome => _getData(_ktotalIncomeKey) ?? 0;
  set totalIncome(double value) => _saveData(_ktotalIncomeKey, value);

  double get totalSpend => _getData(_ktotalSpendKey) ?? 0;
  set totalSpend(double value) => _saveData(_ktotalSpendKey, value);


  List<String> get spendBills {
    List<String> spendBillsList = _getData(_kspendBillsKey)?.cast<String>().toList() ?? [];
    return spendBillsList;
  }

  set spendBills(List<String> value) {
    List<String> spendBillsList = _getData(_kspendBillsKey)?.cast<String>().toList() ?? [];
    spendBillsList = [];
    spendBillsList.addAll(value);
    _saveData(_kspendBillsKey, spendBillsList);
  }

  List<String> get incomeBills {
    List<String> incomeBillsList = _getData(_kincomeBillsKey)?.cast<String>().toList() ?? [];
    return incomeBillsList;
  }

  set incomeBills(List<String> value) {
    List<String> incomeBillsList = _getData(_kincomeBillsKey)?.cast<String>().toList() ?? [];
    incomeBillsList = [];
    incomeBillsList.addAll(value);
    _saveData(_kincomeBillsKey, incomeBillsList);
  }
}
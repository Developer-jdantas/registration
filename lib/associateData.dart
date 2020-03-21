import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'model/associate.dart';
import 'util.dart';

class AssociateData extends ChangeNotifier {
  static const String _boxName = 'associateBox';

  List<Associate> _associates = [];

  Associate _activeAssociate;

  void getAssociates() async {
    var box = await Hive.openBox<Associate>(_boxName);

    _associates = box.values.toList();

    notifyListeners();
  }

  Associate getAssociate(index) {
    return _associates[index];
  }

  void addAssociates(Associate associate) async {
    var box = await Hive.openBox<Associate>(_boxName);

    await box.add(associate);

    _associates = box.values.toList();

    notifyListeners();
  }

  void deleteAssociate(key) async {
    var box = await Hive.openBox<Associate>(_boxName);

    await box.delete(key);

    _associates = box.values.toList();

    Log.i("Deleted member with key: " + key.toString());

    notifyListeners();
  }

  void editAssociate({Associate associate, int associateKey}) async {
    var box = await Hive.openBox<Associate>(_boxName);

    await box.put(associateKey, associate);

    _associates = box.values.toList();

    _activeAssociate = box.get(associateKey);

    Log.i("Edited " + associate.name);

    notifyListeners();
  }

  void setActiveAssociate(key) async {
    var box = await Hive.openBox<Associate>(_boxName);

    _activeAssociate = box.get(key);

    notifyListeners();
  }

  Associate getActiveAssociate() {
    return _activeAssociate;
  }

  int get associateCount {
    return _associates.length;
  }
}

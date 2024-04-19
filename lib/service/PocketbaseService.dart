import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  static final PocketBaseService _singleton = PocketBaseService._internal();

  factory PocketBaseService() {
    return _singleton;
  }

  static PocketBase get() {
    return pb;
  }

  PocketBaseService._internal();

  static final PocketBase pb = PocketBase('http://45.135.164.29:8080');
}

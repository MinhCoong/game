// ignore_for_file: constant_identifier_names, unused_element, avoid_print

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import '../model/member.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> _members = [];
  final _db = FirebaseDatabase.instance.ref();

  static const MEMBERS_PATH = 'members';

  late StreamSubscription<DatabaseEvent> _memberStream;

  List<Member> get members => _members;

  MemberProvider() {
    _listenToMember();
  }

  void _listenToMember() {
    _db.child(MEMBERS_PATH).onValue.listen((event) {
      final allMembers = Map<String, dynamic>.from(Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>));
      _members = allMembers.values
          .map((memberAsJson) =>
              Member.FromRTDB(Map<String, dynamic>.from(memberAsJson)))
          .toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _memberStream.cancel();
    super.dispose();
  }

}

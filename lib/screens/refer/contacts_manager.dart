import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/contact.dart';

class ContactCont extends GetxController {
  var isLoading = false.obs;
  @override
  void onClose() {
    super.onClose();
    controller.value.clear();
    filteredList.value.clear();
  }

  var contact = Contact().obs;
  var permissionDenied = false.obs;
  var favIsEmpty = false.obs;
  Rx<TextEditingController> controller = TextEditingController().obs;
  List<Contact> contacts = [];
  List<Contact> favContacts = [];
  final Rx<List<Contact>> filteredList = Rx<List<Contact>>([]);
  Rx<List<Contact>> favList = Rx<List<Contact>>([]);

  fetchContacts() async {
    isLoading.value = true;
    final _contacts = await FlutterContacts.getContacts(
        withThumbnail: true, withProperties: true);
    contacts = _contacts.toList();
    filteredList.value = contacts;
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchContacts();
  }

  filterList(value) async {
    List<Contact> results = [];

    if (value.isEmpty) {
      results = contacts;
    } else {
      results = contacts
          .where((element) => element.displayName.toLowerCase().contains(
                value.toString().toLowerCase(),
              ))
          .toList();
    }
    filteredList.value = results;
  }
}

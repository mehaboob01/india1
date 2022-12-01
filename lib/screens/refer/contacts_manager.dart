import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/contact.dart';

class ContactCont extends GetxController {

  var isLoading = false.obs;
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.value.clear();
    filteredList.value = contacts;
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


    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied.value = true;

    }




    else

    {
      final _contacts = await FlutterContacts.getContacts(
          withThumbnail: true, withProperties: true);
      contacts = _contacts.toList();

      print("contact from device ${contacts}");
      // for( var i = 0 ; i >= contacts.length; i++ ) {
      //   if(contacts[i].phones != null)
      //   {
      //     filteredList.value[i].phones;
      //   }
      // }
      print("contact from forloop ${filteredList.value}");


    }


    filteredList.value = contacts;
    isLoading.value = false;

    await fetchFavs();



  }

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();
    await fetchContacts();
  }

  fetchFavs() async {
    List<Contact> results = [];
    results = contacts.where((e) => e.isStarred).toList();

    if (results != null) {
      favContacts = results;
      favList.value = favContacts;
    } else {
      favIsEmpty.value = true;
    }
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

  randomColorGradients() {
    var gradient1 = LinearGradient(colors: [
      Color(0xFF00C376).withOpacity(1),
      Color(0xFF00C37600).withOpacity(0)
    ], begin: Alignment.topLeft, end: Alignment.bottomRight);
    var gradient2 = LinearGradient(
        colors: [Color(0xFFDFC900), Color(0xFFDFC90000).withOpacity(0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
    var gradient3 = LinearGradient(
        colors: [Color(0xFF4F0AD2), Color(0xFF4F0AD200).withOpacity(0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
    var gradient4 = LinearGradient(
        colors: [Color(0xFFED1C24), Color(0xFFED1C2400).withOpacity(0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);

    List<LinearGradient> _gradients = [
      gradient1,
      gradient2,
      gradient3,
      gradient4
    ];
    var randomItem = _gradients.randomItem();
    return randomItem;
  }
}

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}

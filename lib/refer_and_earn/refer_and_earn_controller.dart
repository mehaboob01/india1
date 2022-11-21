import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ReferAndEarnController extends GetxController {
  RxList contacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      await _getContacts();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Get.snackbar('Permission Denied', 'Access to contact data denied');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Get.snackbar('Permission Denied', 'Contact data not available on device');
    }
  }

  Future<List<Contact>> _getContacts() async {
    return contacts.value = await ContactsService.getContacts();
  }
}

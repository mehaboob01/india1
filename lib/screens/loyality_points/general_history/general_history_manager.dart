import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/loyality_points/general_history/general_history_model.dart';

class ListManager extends GetxController {
  final List<GeneralHistoryModel> dummyData = [
    GeneralHistoryModel(
        name: "HDFC Bank Personal Loan",
        type: "Personal Loan",
        loanAmount: "1,12,000",
        appliedOn: DateTime(2022, 10, 10),
        icon: "assets/icons/hdfc.png",
        status: "Pending"),
    GeneralHistoryModel(
        name: "Axis Bank",
        type: "2 Wheeler Loan",
        loanAmount: "84,000",
        icon: "assets/icons/axis.png",
        appliedOn: DateTime(2022, 10, 9),
        status: "Rejected"),
    GeneralHistoryModel(
      name: "Aditya Birla Insurance",
      type: "Health Insurance",
      amountCoveres: "2,00,000",
      icon: "assets/icons/abirla.png",
      boughtOn: DateTime(2022, 10, 10),
    ),
    GeneralHistoryModel(
        name: "SBI Bank Personal Loan",
        type: "Personal Loan",
        icon: "assets/icons/sbi.png",
        loanAmount: "2,10,00",
        appliedOn: DateTime(2022, 22, 9),
        status: "Approved"),
  ];

  final Rx<List<GeneralHistoryModel>> filteredList =
      Rx<List<GeneralHistoryModel>>([]);
  @override
  void onInit() {
    super.onInit();
    filteredList.value = dummyData;
  }

  @override
  void onClose() {
    super.onClose();
  }

  filterList(String appliedFilter) {
    List<GeneralHistoryModel>? results = [];
    if (appliedFilter.isEmpty || appliedFilter.toLowerCase() == "no filter") {
      results = dummyData;
    } else if (appliedFilter.toLowerCase() == "status - approved") {
      results = dummyData
          .where((element) =>
              element.status.toString().toLowerCase() == "approved")
          .toList();
    } else if (appliedFilter.toLowerCase() == "status - rejected") {
      results = dummyData
          .where((element) =>
              element.status.toString().toLowerCase() == "rejected")
          .toList();
    } else if (appliedFilter.toLowerCase() == "status - pending") {
      results = dummyData
          .where(
              (element) => element.status.toString().toLowerCase() == "pending")
          .toList();
    }

    filteredList.value = results;
  }

  cardColor(int index) {
    if (filteredList.value[index].status.toString().toLowerCase() ==
        "rejected") {
      return const Color(0xFFF2F2F2);
    } else {
      return Colors.white;
    }
  }

  statusTextColor(int index) {
    if (filteredList.value[index].status.toString().toLowerCase() ==
        "pending") {
      return const Color(0xFF4F0AD2);
    } else if (filteredList.value[index].status.toString().toLowerCase() ==
        "approved") {
      return const Color(0xFF00C376);
    } else if (filteredList.value[index].status.toString().toLowerCase() ==
        "rejected") {
      return const Color(0XffED1C24);
    } else {
      return Colors.black;
    }
  }
}

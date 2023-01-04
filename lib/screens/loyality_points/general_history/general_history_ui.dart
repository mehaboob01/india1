import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/loyality_points/general_history/general_history_manager.dart';

import '../../../connection_manager/ConnectionManagerController.dart';

class GeneralHistory extends StatefulWidget {
  GeneralHistory({key});

  @override
  State<GeneralHistory> createState() => _GeneralHistoryState();
}

class _GeneralHistoryState extends State<GeneralHistory> {
  final ListManager _controller = Get.put(ListManager());

  final ConnectionManagerController controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              "History",
              style: TextStyle(color: Colors.black),
            ),
            leading: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            titleSpacing: 1,
            elevation: 0.1,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white70.withOpacity(0.9),
          body: _body(),
        ),
      ),
    );
  }

  final TextStyle _stats = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF2D2D2D));

  final TextStyle _statsTitle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF333333));
  String? selectedFilter;

  _body() {
    final List<String> _filters = [
      'Status - Approved',
      'Status - Rejected',
      'Status - Pending',
      'No Filter'
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: Get.height * 0.05,
                width: Get.width * 0.63,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.center,
                  child: DropdownButton(
                    items: _filters.map((filter) {
                      return DropdownMenuItem(
                        value: filter,
                        child: Text(filter),
                      );
                    }).toList(),
                    hint: Text(
                      "Apply Filter",
                      style: _stats,
                    ),
                    value: selectedFilter,
                    onChanged: (newValue) {
                      setState(() {
                        selectedFilter = newValue.toString();
                      });
                      _controller.filterList(newValue.toString());
                    },
                    alignment: AlignmentDirectional.center,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.025,
              ),
              Container(
                width: Get.width * 0.23,
                height: Get.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFFFFFF),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "All Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.filteredList.value.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: _controller.cardColor(index),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          height: Get.height * 0.17,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        height: Get.height * 0.055,
                                        width: Get.width * 0.09,
                                        color: Colors.white,
                                        child: Image.asset(_controller
                                            .filteredList.value[index].icon
                                            .toString())),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _controller
                                              .filteredList.value[index].name
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Color(0xFF2D2D2D),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.004,
                                        ),
                                        Text(
                                          _controller
                                              .filteredList.value[index].type
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF999999),
                                              fontSize: 14),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.025,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _controller.filteredList.value[index]
                                                  .loanAmount !=
                                              null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "₹ ${_controller.filteredList.value[index].loanAmount}",
                                                    style: _stats),
                                                Text(
                                                  "Loan Amount",
                                                  style: _statsTitle,
                                                )
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "₹ ${_controller.filteredList.value[index].amountCoveres}",
                                                  style: _stats,
                                                ),
                                                Text(
                                                  "Amount Coverees",
                                                  style: _statsTitle,
                                                )
                                              ],
                                            ),
                                      _controller.filteredList.value[index]
                                                  .appliedOn !=
                                              null
                                          ? Column(
                                              children: [
                                                Text(
                                                  "${_controller.filteredList.value[index].appliedOn!.day} ${_controller.filteredList.value[index].appliedOn!.month} ${_controller.filteredList.value[index].appliedOn!.year}",
                                                  style: _stats,
                                                ),
                                                Text(
                                                  "Applied On",
                                                  style: _statsTitle,
                                                )
                                              ],
                                            )
                                          : Column(),
                                      _controller.filteredList.value[index]
                                                  .status !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  _controller.filteredList
                                                      .value[index].status
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: _controller
                                                          .statusTextColor(
                                                              index)
                                                      // color: _statusColor(index),
                                                      ),
                                                ),
                                                Text(
                                                  "Status",
                                                  style: _statsTitle,
                                                )
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${_controller.filteredList.value[index].boughtOn!.day} ${_controller.filteredList.value[index].boughtOn!.month} ${_controller.filteredList.value[index].boughtOn!.year}",
                                                  style: _stats,
                                                ),
                                                Text(
                                                  "Bought On",
                                                  style: _statsTitle,
                                                )
                                              ],
                                            )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

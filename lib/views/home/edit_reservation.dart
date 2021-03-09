import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:texido_app/constants/app_constants.dart';
import 'package:texido_app/constants/asset_path.dart';
import 'package:texido_app/controllers/table.dart';
import 'package:texido_app/models/table.dart';
import 'package:texido_app/widgets/custom_button.dart';
import 'package:texido_app/widgets/custom_field.dart';
import 'package:texido_app/widgets/custom_text.dart';

class EditReservation extends StatelessWidget {
  final TableInfo table;
  final bool isFloor;
  EditReservation(this.table, this.isFloor);
  final controller = Get.find<TableController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final List<String> items = [
    "Member",
    "Name",
    "Mobile",
    "Date",
    "Time",
    "Guests",
    "Table",
    "Notes"
  ];

  Widget buildContainer(String val, Widget child, {Color color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: size * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size * 3,
            alignment: Alignment.centerLeft,
            child: RegularText(
              text: val,
              size: f,
              color: greyColor06.withOpacity(0.5),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: table.name);
    mobileController = TextEditingController(text: "+966 ${table.mobile}");
    noteController = TextEditingController(text: table.notes[0]);
    controller.pickedDate.value = table.date;
    var months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: size, right: size * 0.5),
      child: Container(
        color: isFloor ? Colors.transparent : blueGrey3,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size * 2.2,
                padding: EdgeInsets.symmetric(horizontal: size),
                decoration: BoxDecoration(
                  color: Color(0xffF4F4F5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MediumText(
                      text: "Edit Reservation",
                      color: greyColor06,
                      size: a,
                    ),
                    GestureDetector(
                        child: Icon(
                          Icons.close,
                          size: size * 1.5,
                          color: Color(0xffFF4C4D),
                        ),
                        onTap: () {
                          if (isFloor)
                            Get.close(1);
                          else
                            controller.edit.value = false;
                        }),
                  ],
                ),
              ),
              Container(
                height: Get.height / 1.5,
                color: whiteColor,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: size, left: size),
                        child: Column(
                          children: [
                            buildContainer(
                              items[0],
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RegularText(
                                  text: table.name,
                                  size: f,
                                  color: greyColor06,
                                ),
                              ),
                            ),
                            buildContainer(
                              items[1],
                              textField(
                                fieldController: nameController,
                                filled: true,
                                filledColor: greyColor03,
                                autoValidate: false,
                                vertical: size * 0.7,
                                hintSize: e,
                                hintColor: Color(0xffA2A2A2).withOpacity(0.4),
                                borderColor: Colors.transparent,
                              ),
                            ),
                            buildContainer(
                              items[2],
                              textField(
                                fieldController: mobileController,
                                filled: true,
                                filledColor: greyColor03,
                                autoValidate: false,
                                vertical: size * 0.7,
                                hintSize: e,
                                hintColor: Color(0xffA2A2A2).withOpacity(0.4),
                                borderColor: Colors.transparent,
                              ),
                              color: greyColor02.withOpacity(0.1),
                            ),
                            buildContainer(
                              items[3],
                              GestureDetector(
                                onTap: () async {
                                  await controller.pickDate(
                                      context, table.date);
                                },
                                child: Container(
                                  height: size * 2.3,
                                  alignment: Alignment.centerRight,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: size),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(color: borderColor02),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RegularText(
                                        text:
                                            "${table.date.day} ${months[table.date.month]} ${table.date.year}",
                                        color: greyColor06,
                                        size: f,
                                      ),
                                      SvgPicture.asset(calendar,
                                          height: size * 1.1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            buildContainer(
                              items[4],
                              GestureDetector(
                                onTap: () async {
                                  await controller.pickTime(context);
                                },
                                child: Container(
                                  height: size * 2.3,
                                  alignment: Alignment.centerRight,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: size),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(color: borderColor02),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RegularText(
                                        text: table.time,
                                        color: greyColor06,
                                        size: f,
                                      ),
                                      SvgPicture.asset(clock,
                                          height: size * 1.1,
                                          color: greyColor06),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            buildContainer(
                              items[5],
                              Container(
                                height: size * 2.3,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: size),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(color: borderColor02),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RegularText(
                                      text: table.guests.toString(),
                                      color: greyColor06,
                                      size: f,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          child: SvgPicture.asset(minus,
                                              height: size * 1.1,
                                              color: greyColor06),
                                          onTap: () {
                                            if (table.guests > 1)
                                              table.guests--;
                                          },
                                        ),
                                        SizedBox(width: size * 0.5),
                                        GestureDetector(
                                            child: SvgPicture.asset(plus,
                                                height: size * 1.1,
                                                color: greyColor06),
                                            onTap: () {
                                              controller
                                                  .tables[
                                                      controller.index.value]
                                                  .guests++;
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size),
                            buildContainer(
                              items[6],
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RegularText(
                                  text: "Table ${table.table}",
                                  size: f,
                                  color: greyColor06,
                                ),
                              ),
                            ),
                            SizedBox(height: size),
                            buildContainer(
                              items[7],
                              textField(
                                fieldController: noteController,
                                autoValidate: false,
                                vertical: size,
                                hintSize: e,
                                hintColor: Color(0xffA2A2A2),
                                borderColor: borderColor02,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Color(0xffF4F4F5).withOpacity(0.4),
                        padding: EdgeInsets.only(top: size, left: size * 0.5),
                        child: ListView.builder(
                          itemCount: 10,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: size * 0.5),
                          itemBuilder: (context, index) {
                            Color color;
                            if (controller.tables[index].activated)
                              color = greenColor;
                            else
                              color = darkGrey03;
                            return Padding(
                              padding: EdgeInsets.only(bottom: size),
                              child: Row(
                                children: [
                                  Container(
                                    height: size * 1.8,
                                    width: size * 3.5,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    child: SemiBoldText(
                                      text:
                                          "TA-${controller.tables[index].table}",
                                      size: f,
                                      color: color,
                                    ),
                                  ),
                                  SizedBox(width: size * 0.5),
                                  MediumText(
                                    text: controller.tables[index].activated
                                        ? "Available"
                                        : "Reserved",
                                    size: f,
                                    color: color,
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        tap4,
                                        height: size * 0.9,
                                        color: color,
                                      ),
                                      SizedBox(width: size * 0.5),
                                      MediumText(
                                        text:
                                            controller.tables[index].guests <= 2
                                                ? "1-2"
                                                : "3-4",
                                        size: f,
                                        color: color,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size * 3.2,
                decoration: BoxDecoration(color: Color(0xffF4F4F5)),
                child: ButtonBar(
                  children: [
                    customButton(
                      label: "Cancel",
                      labelColor: darkGrey03,
                      buttonColor: transparentColor,
                      borderColor: darkGrey03,
                      labelSize: e,
                      onPressed: () {
                        if (isFloor)
                          Get.close(1);
                        else
                          controller.edit.value = false;
                      },
                      hasBorder: true,
                    ),
                    SizedBox(width: size * 0.5),
                    customButton(
                        label: "Save",
                        labelColor: whiteColor,
                        buttonColor: greenColor,
                        labelSize: e,
                        onPressed: () {
                          controller.tables[controller.index.value] = TableInfo(
                            member: "Golden membership",
                            name: nameController.text,
                            mobile: mobileController.text,
                            date: table.date,
                            time: table.time,
                            guests: table.guests,
                            table: table.table,
                            notes: ["Birthday party"],
                            activated: table.activated,
                          );
                          isFloor
                              ? Get.close(1)
                              : controller.edit.value = false;
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

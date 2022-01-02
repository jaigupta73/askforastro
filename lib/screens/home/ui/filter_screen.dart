import 'package:askforastro/custom_widget/textview.dart';
import 'package:askforastro/screens/home/controller/home_controller.dart';
import 'package:askforastro/util/utils.dart';
import 'package:askforastro/values/custom_colors.dart';
import 'package:askforastro/values/custom_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreen extends GetView {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      // padding: const EdgeInsets.only(left: spacing_xxl_2, right: spacing_xxl_2),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(spacing_xxl_2),
              topRight: Radius.circular(spacing_xxl_2))),
      child: Column(
        children: [
          Container(
            width: Get.width * .15,
            height: spacing_ms,
            margin: EdgeInsets.only(top: spacing_xxl_2),
            decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(spacing_xxl_2)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    for (var element in homeController.langList) {
                      element.isSelected = false;
                    }
                    for (var element in homeController.skillList) {
                      element.isSelected = false;
                    }
                    homeController.langList.refresh();
                    homeController.skillList.refresh();
                    homeController.listFilterSearch('');
                    Get.back();
                  },
                  child: TextView(
                    title: getStringFromLocale('reset'),
                    textStyle: commonTextStyle(fontSize: 14),
                  )),
              TextButton(
                  onPressed: null,
                  child: TextView(
                    title: getStringFromLocale('filter'),
                    textStyle: commonTextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {
                    Get.back();
                    homeController.filterAgentList();
                  },
                  child: TextView(
                    title: getStringFromLocale('done'),
                    textStyle:
                        commonTextStyle(fontSize: 14, color: colorPrimary),
                  ))
            ],
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          Container(
            padding: EdgeInsets.all(spacing_xxl_2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                    title: getStringFromLocale('language'),
                    textStyle: commonTextStyle(
                        fontSize: 17,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: spacing_xxl_2,
                ),
                Wrap(
                  spacing: spacing_xxl_2,
                  children: List.generate(
                      homeController.langList.length,
                      (index) => Obx(
                            () => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: spacing_xl,
                                        right: spacing_xl,
                                        bottom: spacing_m,
                                        top: spacing_m),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: homeController
                                                    .langList[index].isSelected
                                                ? colorPrimary
                                                : Colors.black12),
                                        borderRadius: BorderRadius.circular(
                                            spacing_xxl_4)),
                                    child: TextView(
                                      title:
                                          homeController.langList[index].name,
                                      textStyle: commonTextStyle(
                                          fontWeight: homeController
                                                  .langList[index].isSelected
                                              ? FontWeight.w500
                                              : FontWeight.w300,
                                          color: homeController
                                                  .langList[index].isSelected
                                              ? colorPrimary
                                              : Colors.black87),
                                    ),
                                  ),
                                  onTap: () {
                                    homeController.langList[index].isSelected =
                                        !homeController
                                            .langList[index].isSelected;
                                    homeController.langList.refresh();
                                    appLog(
                                        'homeController ${homeController.langList[index].isSelected}');
                                  },
                                ),
                              ],
                            ),
                          )),
                ),
                const SizedBox(
                  height: spacing_xxl_2,
                ),
                TextView(
                    title: getStringFromLocale('skills'),
                    textStyle: commonTextStyle(
                        fontSize: 17,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: spacing_xxl_2,
                ),
                Obx(() => Wrap(
                      spacing: spacing_xxl_2,
                      runSpacing: spacing_xxl_2,
                      children: List.generate(
                          homeController.skillList.length,
                          (index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.only(
                                            left: spacing_xl,
                                            right: spacing_xl,
                                            bottom: spacing_m,
                                            top: spacing_m),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: homeController
                                                        .skillList[index]
                                                        .isSelected
                                                    ? colorPrimary
                                                    : Colors.black12),
                                            borderRadius: BorderRadius.circular(
                                                spacing_xxl_4)),
                                        child: TextView(
                                          title: homeController
                                              .skillList[index].name,
                                          textStyle: commonTextStyle(
                                              fontWeight: homeController
                                                      .skillList[index]
                                                      .isSelected
                                                  ? FontWeight.w500
                                                  : FontWeight.w300,
                                              color: homeController
                                                      .skillList[index]
                                                      .isSelected
                                                  ? colorPrimary
                                                  : Colors.black87),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      homeController.isShowFilterOption.value =
                                          true;
                                      homeController
                                              .skillList[index].isSelected =
                                          !homeController
                                              .skillList[index].isSelected;
                                      homeController.skillList.refresh();
                                    },
                                  ),
                                ],
                              )),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:askforastro/base_directory/base_list_get_state.dart';
import 'package:askforastro/custom_widget/textview.dart';
import 'package:askforastro/screens/daily_panchang/ui/panchang_detail_page.dart';
import 'package:askforastro/screens/home/controller/home_controller.dart';
import 'package:askforastro/screens/home/models/agents_list_model.dart';
import 'package:askforastro/screens/home/ui/filter_screen.dart';
import 'package:askforastro/screens/home/ui/home_screen_shimmer.dart';
import 'package:askforastro/util/enums.dart';
import 'package:askforastro/util/utils.dart';
import 'package:askforastro/values/custom_colors.dart';
import 'package:askforastro/values/custom_dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends BaseListGetWidget<HomeController, AgentData> {
  @override
  Widget getListItemWidget(BuildContext context, HomeController controller,
      AgentData itemModel, int index) {
    // TODO: implement getListItemWidget
    return Container(
      width: GetPlatform.isWeb ? Get.width : Get.width,
      padding: const EdgeInsets.only(
          left: spacing_xxl_2, right: spacing_xxl_2, top: spacing_xxl_2),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 96,
                  width: 96,
                  margin: const EdgeInsets.only(right: spacing_xl),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(spacing_m),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: itemModel.images.medium.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: spacing_xxs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextView(
                              title:
                                  '${itemModel.firstName} ${itemModel.lastName}',
                              textStyle: commonTextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                        TextView(
                            title: getFormattedString(
                                getStringFromLocale('year'),
                                '${itemModel.experience.round()}'),
                            textStyle: commonTextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300)),
                      ],
                    ),
                    const SizedBox(
                      height: spacing_xs,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/skills.svg',
                          width: 16,
                          color: colorPrimary,
                        ),
                        Expanded(
                          child: TextView(
                              title: itemModel.filterSkilled,
                              maxLines: 5,
                              margin: EdgeInsets.only(left: spacing_m),
                              textStyle: commonTextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spacing_xs,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/tranlate.svg',
                          width: 16,
                          color: colorPrimary,
                        ),
                        Expanded(
                          child: TextView(
                              title: itemModel.filterLanguage,
                              maxLines: 5,
                              margin: EdgeInsets.only(left: spacing_m),
                              textStyle: commonTextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spacing_xs,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/badge.svg',
                          width: 16,
                          color: colorPrimary,
                        ),
                        Expanded(
                          child: TextView(
                              title:
                                  '₹${itemModel.additionalPerMinuteCharges}/${getStringFromLocale('min')}',
                              maxLines: 5,
                              margin: const EdgeInsets.only(left: spacing_m),
                              textStyle: commonTextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Container(
                      width: Get.width * 0.4,
                      margin: const EdgeInsets.only(
                          top: spacing_xl, bottom: spacing_xxl_2),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(primary: colorPrimary),
                        child: Row(
                          children: [
                            const Icon(Icons.phone_outlined),
                            TextView(
                              title: getString('talkONCall'),
                              textStyle: commonTextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
          Container(
            width: Get.width,
            height: 1,
            color: Colors.black26,
          )
        ],
      ),
    );
  }

  @override
  HomeController onInitialize() {
    // TODO: implement onInitialize
    return HomeController();
  }

  @override
  Color getScreenColor() {
    // TODO: implement getScreenColor
    return Colors.white;
  }

  @override
  Widget getTopWidget(BuildContext context, HomeController controller) {
    // TODO: implement getTopWidget
    return Container(
      padding: const EdgeInsets.only(
          left: spacing_xxl_2,
          right: spacing_xxl_2,
          top: spacing_xl,
          bottom: spacing_xl),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                  title: getString('title'),
                  textStyle: commonTextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600)),
              Row(
                children: [
                  InkWell(
                    // radius: Radius.circular(10.0),
                    child: controller.isShowSearchOption.value
                        ? const Icon(
                            Icons.close_rounded,
                            color: colorPrimary,
                          )
                        : Image.asset(
                            'assets/images/search.png',
                            height: spacing_xxl_4,
                            width: spacing_xxl_4,
                          ),

                    onTap: () {
                      controller.isShowSearchOption.value =
                          !controller.isShowSearchOption.value;
                      if (!controller.isShowSearchOption.value) {
                        controller.searchEditController.clear();
                        controller.listFilterSearch('');
                      }
                    },
                  ),
                  const SizedBox(
                    width: spacing_xl,
                  ),
                  InkWell(
                    child: Image.asset(
                      'assets/images/filter.png',
                      height: spacing_xxl_4,
                      width: spacing_xxl_4,
                    ),
                    onTap: () {
                      // Get.to(FilterScreen());
                      showAppBottomSheet(FilterScreen());
                    },
                  ),
                  const SizedBox(
                    width: spacing_xl,
                  ),
                  PopupMenuButton(
                    child: Image.asset(
                      'assets/images/sort.png',
                      height: spacing_xxl_4,
                      width: spacing_xxl_4,
                    ),
                    offset: const Offset(0, 30),
                    onSelected: (value) {
                      controller.currentSortIndex.value =
                          int.parse(value.toString());
                      controller
                          .sortByAction(controller.currentSortIndex.value);
                    },
                    itemBuilder: (context) {
                      return List.generate(5, (index) {
                        return PopupMenuItem(
                          value: index,
                          child: index == 0
                              ? Column(
                                  children: [
                                    TextView(
                                        title: getString('sortBy'),
                                        textStyle: commonTextStyle(
                                            color: colorPrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                    Container(
                                      height: 1,
                                      margin: const EdgeInsets.only(
                                          top: spacing_xl),
                                      color: Colors.black38,
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      index == controller.currentSortIndex.value
                                          ? Icons.radio_button_checked_rounded
                                          : Icons.radio_button_unchecked,
                                      color: index ==
                                              controller.currentSortIndex.value
                                          ? colorPrimary
                                          : Colors.black38,
                                    ),
                                    TextView(
                                        margin: const EdgeInsets.only(
                                            left: spacing_xxl_2),
                                        title:
                                            controller.sortByValue[index - 1],
                                        textStyle: commonTextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15)),
                                  ],
                                ),
                        );
                      });
                    },
                  ),
                  // InkWell(
                  //   child: Image.asset(
                  //     'assets/images/sort.png',
                  //     height: spacing_xxl_4,
                  //     width: spacing_xxl_4,
                  //   ),
                  // )
                ],
              )
            ],
          ),
          Visibility(
            visible: controller.isShowSearchOption.value,
            child: Container(
              width: Get.width,
              margin:
                  const EdgeInsets.only(top: spacing_xxl_2, bottom: spacing_m),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 6.0),
                ],
              ),
              child: TextField(
                controller: controller.searchEditController,
                cursorColor: colorPrimary,
                onChanged: (value) {
                  controller.listFilterSearch(value.toLowerCase());
                },
                style: commonTextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: getString('searchHintTxt'),
                    hintStyle: commonTextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: colorPrimary,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.searchEditController.clear();
                          controller.listFilterSearch('');
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: colorPrimary,
                        ))),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget getEmptyListWidget(BuildContext context, HomeController controller) {
    // TODO: implement getEmptyListWidget
    return Container(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextView(
              alignment: Alignment.center,
              title: getString('noRecordFound'),
              textStyle: commonTextStyle())
        ],
      ),
    );
  }

  @override
  Widget getShimmerWidget(BuildContext context, HomeController controller) {
    // TODO: implement getShimmerWidget
    return HomeScreenShimmer();
  }

  @override
  PreferredSizeWidget? getToolBar(
      BuildContext context, HomeController controller) {
    // TODO: implement getToolBar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(18),
        child: Image.asset('assets/images/hamburger.png'),
      ),
      centerTitle: true,
      title: Image.asset('assets/images/logo.png',
          width: spacing_xxl_20, height: spacing_xxl_20),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(PanchangDetailPage());
            },
            icon: Image.asset(
              'assets/images/profile.png',
              width: spacing_xxl_6,
              height: spacing_xxl_6,
            )),
      ],
    );
  }

  @override
  void onDisConnected(BuildContext context, HomeController controller) {
    // TODO: implement onDisConnected
    super.onDisConnected(context, controller);
    controller.viewState.value = ViewState.NO_INTERNET_STATE;
  }

  @override
  void onConnected(BuildContext context, HomeController controller) {
    // TODO: implement onConnected
    super.onConnected(context, controller);
    // if (controller.agentDataList.isEmpty) {
    controller.viewState.value = ViewState.SHIMMER_STATE;
    if (controller.viewState.value == ViewState.SHIMMER_STATE) {
      controller.agentDataList.clear();
      controller.callGetAgentListAPI();
    }
    // }
  }

  Widget getFilterScreen(HomeController controller) {
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
                  onPressed: () {},
                  child: TextView(
                    title: getStringFromLocale('reset'),
                    textStyle: commonTextStyle(fontSize: 14),
                  )),
              TextButton(
                  onPressed: () {},
                  child: TextView(
                    title: getStringFromLocale('filter'),
                    textStyle: commonTextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {},
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
            padding: const EdgeInsets.all(spacing_xxl_2),
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
                Obx(() => Wrap(
                      spacing: spacing_xxl_2,
                      children: List.generate(
                          controller.langList.value.length,
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
                                                color: controller.langList
                                                        .value[index].isSelected
                                                    ? colorPrimary
                                                    : Colors.black12),
                                            borderRadius: BorderRadius.circular(
                                                spacing_xxl_4)),
                                        child: TextView(
                                          title: controller
                                              .langList.value[index].name,
                                          textStyle: commonTextStyle(),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      controller.langList.value[index]
                                              .isSelected =
                                          !controller
                                              .langList.value[index].isSelected;
                                      // controller.langList.value[index].isSelected
                                      appLog(
                                          'homeController ${controller.langList.value[index].isSelected}');
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

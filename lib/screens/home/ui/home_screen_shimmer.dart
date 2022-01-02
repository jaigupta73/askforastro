import 'package:askforastro/base_directory/shimmer_base_widget.dart';
import 'package:askforastro/library_classes/shimmer.dart';
import 'package:askforastro/values/custom_colors.dart';
import 'package:askforastro/values/custom_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';


class HomeScreenShimmer extends ShimmerBaseWidget {
  @override
  Widget getBuildWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: spacing_xxl_2, vertical: spacing_xxl_2),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highLightColor,
        period: time,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsetsDirectional.only(bottom: spacing_xxl_6),
                child: Container(
                  width: Get.width * .5,
                  height: spacing_xxl_4,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [0, 1, 2, 3, 4, 5, 6]
                    .map((_) => Padding(
                  padding: const EdgeInsetsDirectional.only(
                      bottom: spacing_xxl_6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(spacing_xs),
                        child: Container(
                          width: 96.0,
                          height: 96.0,
                          color: Colors.white,

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: spacing_m),
                      ),
                      Expanded(
                        child: Container(
                          height: 96.0,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    height: spacing_xxl_4,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: spacing_xs),
                                  ),
                                  Container(
                                    width: Get.width * .25,
                                    height: spacing_xxl_2,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Get.width * .2,
                                    height: spacing_xxl_8,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: Get.width * .2,
                                    height: spacing_xxl_8,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
import 'package:assignment/src/base_directory/shimmer_base_widget.dart';
import 'package:assignment/src/library_classes/shimmer.dart';
import 'package:assignment/src/values/custom_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenHeaderShimmer extends ShimmerBaseWidget {
  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement build
    return Container(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(
              left: spacing_xxl_2, right: spacing_xxl_2, top: spacing_xxl_2),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Material(
                      shape: const CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: SizedBox(
                        height: 90,
                        width: 90,
                        child: Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highLightColor,
                          period: time,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: baseColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: spacing_xxl_2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highLightColor,
                          period: time,
                          child: Container(
                            height: 8,
                            width: Get.width * .4,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: baseColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: const EdgeInsets.only(top: spacing_xxl_2),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highLightColor,
                          period: time,
                          child: Container(
                            height: 20,
                            width: Get.width * .5,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: baseColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: const EdgeInsets.only(top: spacing_xxl_2),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: spacing_xxl_2,
                      right: spacing_xxl_2,
                      bottom: spacing_xxl_2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highLightColor,
                        period: time,
                        child: Container(
                          height: 16,
                          width: Get.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: baseColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: spacing_xxl_2),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highLightColor,
                        period: time,
                        child: Container(
                          height: 8,
                          width: Get.width * .50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: baseColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: spacing_xxl_2),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:assignment/src/base_directory/base_list_get_state.dart';
import 'package:assignment/src/home/controller/home_controller.dart';
import 'package:assignment/src/home/models/tournament_response_model.dart';
import 'package:assignment/src/home/ui/home_screen_header_shimmer.dart';
import 'package:assignment/src/home/ui/logout_bottom_sheet.dart';
import 'package:assignment/src/home/ui/touramnet_item_shimmer.dart';
import 'package:assignment/src/util/enums.dart';
import 'package:assignment/src/custom_widget/textview.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:assignment/src/values/custom_colors.dart';
import 'package:assignment/src/values/custom_dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'language_bottom_sheet.dart';

class HomeScreen extends BaseListGetWidget<HomeController, Tournaments> {
  ScrollController scrollController = ScrollController();

  @override
  Widget getListItemWidget(BuildContext context, HomeController controller,
      Tournaments itemModel, int index) {
    // TODO: implement getListItemWidget
    return Padding(
      padding: const EdgeInsets.only(
          left: spacing_xxl_2, right: spacing_xxl_2, top: spacing_xxl_2),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(spacing_xxl_6),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0.0, 0.0),
                blurRadius: 8.0),
          ],
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3.8,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(spacing_xxl_6),
                    topRight: Radius.circular(spacing_xxl_6)),
                child: CachedNetworkImage(
                  imageUrl: itemModel.coverUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Container(
                      child: Center(child: const CircularProgressIndicator()),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                        child: Center(child: const Icon(Icons.error_rounded)));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(spacing_xxl_2),
              child: Column(
                children: [
                  TextView(
                      title: itemModel.name,
                      textOverflow: TextOverflow.ellipsis,
                      textStyle: commonTextStyle()),
                  TextView(
                      title: itemModel.gameName,
                      textOverflow: TextOverflow.ellipsis,
                      textStyle: commonTextStyle(fontWeight: FontWeight.w400))
                ],
              ),
            )
          ],
        ),
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
  Widget getLoadMoreWidget(BuildContext context, HomeController controller) {
    // TODO: implement getLoadMoreWidget
    return TouramentItemShimmer();
  }

  @override
  Widget getTopWidget(BuildContext context, HomeController controller) {
    // TODO: implement getTopWidget
    return Container(
      padding: const EdgeInsets.only(
          left: spacing_xxl_2,
          right: spacing_xxl_2,
          top: spacing_xxl_2,
          bottom: spacing_m),
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
                  child: CachedNetworkImage(
                    imageUrl: controller.userData.profileImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Container(
                        child: Center(child: const CircularProgressIndicator()),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                          child:
                              Center(child: const Icon(Icons.error_rounded)));
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: spacing_xxl_2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                      title: controller.userData.name,
                      textStyle: commonTextStyle(fontSize: text_18)),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: spacing_m,
                        right: spacing_m,
                        top: spacing_ms,
                        bottom: spacing_ms),
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(spacing_xxl_6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          title: controller.userData.rating,
                          textStyle: commonTextStyle(
                              color: borderColor, fontSize: text_18),
                        ),
                        TextView(
                          title: 'Elo Rating',
                          textStyle: commonTextStyle(
                              color: ratingTextColor,
                              fontSize: text_12,
                              fontWeight: FontWeight.w600),
                          margin: const EdgeInsets.only(
                              left: spacing_xl, right: spacing_xxl_4),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: spacing_xxl_4, bottom: spacing_xxl_4),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spacing_xxl_2),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(spacing_xxl_4),
                          bottomLeft: Radius.circular(spacing_xxl_4)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffE67E00),
                          Color(0xffE88F01),
                          Color(0xffEAA000),
                          Color(0xffEAA000),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        TextView(
                            title: controller.userData.tournamentPlayed,
                            alignment: Alignment.center,
                            textAlign: TextAlign.center,
                            textStyle: commonTextStyle(
                                color: Colors.white, fontSize: text_13)),
                        TextView(
                            title: getString('tournamentsPlayed'),
                            maxLines: 3,
                            alignment: Alignment.center,
                            textAlign: TextAlign.center,
                            textStyle: commonTextStyle(
                                color: Colors.white,
                                fontSize: text_12,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 1, right: 1),
                    padding: EdgeInsets.all(spacing_xxl_2),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff4F289C),
                          Color(0xff783EAB),
                          Color(0xff944DB8),
                          Color(0xff944DB8),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        TextView(
                            title: controller.userData.tournamentWon,
                            alignment: Alignment.center,
                            textStyle: commonTextStyle(
                                color: Colors.white, fontSize: text_13)),
                        TextView(
                            title: getString('tournamentsWon'),
                            alignment: Alignment.center,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            textStyle: commonTextStyle(
                                color: Colors.white,
                                fontSize: text_12,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spacing_xxl_2),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(spacing_xxl_4),
                          bottomRight: Radius.circular(spacing_xxl_4)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffED5B47),
                          Color(0xffEE6147),
                          Color(0xffEE744C),
                          Color(0xffEE744C),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        TextView(
                            title: controller.userData.winningPercentage,
                            alignment: Alignment.center,
                            textAlign: TextAlign.center,
                            textStyle: commonTextStyle(
                                color: Colors.white, fontSize: text_13)),
                        TextView(
                            title: getString('winningPercentage'),
                            maxLines: 3,
                            alignment: Alignment.center,
                            textAlign: TextAlign.center,
                            textStyle: commonTextStyle(
                                color: Colors.white,
                                fontSize: text_12,
                                fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextView(
              title: getString('recommendedForYou'),
              textStyle: commonTextStyle(
                  fontSize: text_18, fontWeight: FontWeight.w600))
        ],
      ),
    );
  }

  @override
  void onScreenReady(BuildContext context, HomeController controller,
      ScrollController scrollController) {
    // TODO: implement onScreenReady
    super.onScreenReady(context, controller, scrollController);
    controller.scrollController = scrollController;
    if (controller.viewState.value == ViewState.SHIMMER_STATE) {
      controller.limit = 20;
      controller.tournamentList.clear();
      controller.getTournamentDataAPI();
    }
  }

  @override
  void onLoadMore(BuildContext context, HomeController controller) async {
    // TODO: implement onScreenReady
    super.onLoadMore(context, controller);
    if (controller.isLoadMoreContent.value) {
      controller.setLoading(true);
      controller.getTournamentDataAPI();
    }
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
    return ListView.builder(
      itemBuilder: (context, index) {
        return index == 0 ? HomeScreenHeaderShimmer() : TouramentItemShimmer();
      },
      itemCount: 5,
    );
  }

  @override
  PreferredSizeWidget? getToolBar(
      BuildContext context, HomeController controller) {
    // TODO: implement getToolBar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Icon(
        Icons.sort_rounded,
        color: Colors.grey,
      ),
      centerTitle: true,
      title: TextView(
        alignment: Alignment.center,
        title: getString('homeTitle'),
        textStyle: commonTextStyle(
            fontSize: text_18,
            fontWeight: FontWeight.bold,
            color: Colors.black87),
      ),
      actions: [
        IconButton(
            onPressed: () {
              showAppBottomSheet(getLangBottomSheet(controller),
                  isScrollControlled: true, barrierColor: Colors.black38);
            },
            icon: SvgPicture.asset('assets/images/lang_icon.svg')),
        IconButton(
            onPressed: () {
              showAppBottomSheet(getLogoutBottomSheet(),
                  isScrollControlled: true, barrierColor: Colors.black38);
            },
            icon: SvgPicture.asset('assets/images/logout_icon.svg'))
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
    controller.viewState.value = ViewState.SHIMMER_STATE;
    if (controller.viewState.value == ViewState.SHIMMER_STATE) {
      controller.limit = 20;
      controller.tournamentList.clear();
      controller.getTournamentDataAPI();
    }
  }
}

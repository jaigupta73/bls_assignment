import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:assignment/src/home/ui/no_internet_screen.dart';
import 'package:assignment/src/util/enums.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_list_controller.dart';

abstract class BaseListGetWidget<T extends BaseListController, V>
    extends StatefulWidget {
  T onInitialize();

  Widget getListSeparatorWidget(
      BuildContext context, T controller, V itemModel, int index) {
    return Container();
  }

  Widget getListItemWidget(
      BuildContext context, T controller, V itemModel, int index);

  performBack(BuildContext context, {dynamic result}) {
    backPressedForTracking();
    if (overrideBackBehaviour()) {
      onBackPressManual(context);
    } else {
      if (Navigator.of(context).canPop()) {
        Get.back(result: result);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  String getString(String tag) {
    return tag.tr;
  }

  bool overrideBackBehaviour() {
    return false;
  }

  void showAppBottomSheet(
      Widget child, {
        Function? onBottomSheetClosed,
        Color barrierColor = Colors.black54,
        bool closeOnOutsideClick = true,
        ShapeBorder? shape,
        bool isScrollControlled = false,
      }) {
    Get.bottomSheet(
      child  ,
      barrierColor: barrierColor,
      isDismissible: closeOnOutsideClick,
      shape: shape,
      isScrollControlled: isScrollControlled
    ).then((value) {
      if (onBottomSheetClosed != null) {
        Future.delayed(Duration(milliseconds: 250), () {
          onBottomSheetClosed();
        });
      }
    });
  }

  void onBackPressManual(BuildContext context) {}

  void onScreenReady(
      BuildContext context, T controller, ScrollController scrollController) {}

  void onConnected(BuildContext context, T controller) {}

  void onDisConnected(BuildContext context, T controller) {}

  void onLoadMore(BuildContext context, T controller) {}

  void onPreBuild(BuildContext context, T controller) {}

  void onListScrollToTop(BuildContext context, T controller) {}

  void onListScroll(
      BuildContext context, ListScrollEnum scrollEnum, T controller) {}

  void onListScrollStart(BuildContext context, T controller) {}

  void onListScrollEnd(BuildContext context, T controller) {}

  Widget getShimmerWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getLoadMoreWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getNoInternetWidget(BuildContext context, T controller) {
    return NoInternetScreen(context, 0);
  }

  Widget getBottomWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getTopWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getErrorWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getEmptyListWidget(BuildContext context, T controller) {
    return Container();
  }

  PreferredSizeWidget? getToolBar(BuildContext context, T controller) {
    return null;
  }

  Widget? getFloatingButton(BuildContext context, T controller) {
    return null;
  }

  Widget? getBottomNavigationBar(BuildContext context) {
    return null;
  }

  FloatingActionButtonLocation getFloatingActionButtonLocation(
      BuildContext context) {
    return FloatingActionButtonLocation.endFloat;
  }

  Color? getScreenColor() {
    return null;
  }

  Drawer? getDrawer(BuildContext context) {
    return null;
  }

  Drawer? getEndDrawer(BuildContext context) {
    return null;
  }

  bool resizeToAvoidBottomInset() {
    return true;
  }

  bool applyDefaultAnimationForFAB() {
    return true;
  }

  bool scrollToTopOnFirstBack() {
    return true;
  }

  bool isControllerGlobal() {
    return true;
  }

  double cacheExtentLimit() {
    return 20;
  }

  bool enablePullToRefresh(T controller) {
    return false;
  }

  void onPullToRefresh(T controller) {}

  backPressedForTracking() {}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BaseListGetWidgetState<T, V>();
  }
}

class _BaseListGetWidgetState<T extends BaseListController, V>
    extends State<BaseListGetWidget> with SingleTickerProviderStateMixin {
  var _getController;
  bool _firstLaunch = true;
  bool _firstTimeNet = true;
  ScrollController _scrollController = ScrollController();
  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  PreviousNetStatus _previousNetStatus = PreviousNetStatus.NONE;
  Animation<Offset>? _offset;
  AnimationController? _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getController = widget.onInitialize();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 2.0))
        .animate(_animationController!);
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.onScreenReady(context, _getController, _scrollController);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        widget.onLoadMore(context, _getController);
      } else if (_scrollController.position.pixels == 0) {
        widget.onListScrollToTop(context, _getController);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (widget.applyDefaultAnimationForFAB()) {
          _animationController?.forward();
        }
        widget.onListScroll(context, ListScrollEnum.UP, _getController);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (widget.applyDefaultAnimationForFAB()) {
          _animationController?.forward();
        }
        widget.onListScroll(context, ListScrollEnum.DOWN, _getController);
      }
      if (widget.applyDefaultAnimationForFAB()) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          try {
            _animationController?.reverse();
          } catch (e) {
            print(e);
          }
        });
      }
    });

    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result!);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            widget.onConnected(context, _getController);
          }
          _previousNetStatus = PreviousNetStatus.CONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.CONNECTED;
          _firstTimeNet = false;
        }
        break;
      case ConnectivityResult.mobile:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            widget.onConnected(context, _getController);
          }
          _previousNetStatus = PreviousNetStatus.CONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.CONNECTED;
          _firstTimeNet = false;
        }
        break;
      case ConnectivityResult.none:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.DISCONNECTED) {
            widget.onDisConnected(context, _getController);
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
      default:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.DISCONNECTED) {
            widget.onDisConnected(context, _getController);
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController?.dispose();
    _connectivitySubscription?.cancel();
  }

  bool showCobrowseSessionWidget() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_firstLaunch) {
      _firstLaunch = false;
      widget.onPreBuild(context, _getController);
    }
    return GetBuilder<T>(
      init: _getController,
      global: widget.isControllerGlobal(),
      builder: (lc) {
        return Stack(
          children: [
            Scaffold(
              appBar: widget.getToolBar(context, _getController),
              floatingActionButton:
                  widget.getFloatingButton(context, _getController) != null
                      ? widget.applyDefaultAnimationForFAB()
                          ? Obx(() {
                              return !_getController.showLoadMore.value &&
                                      _getController.viewState.value ==
                                          ViewState.LIST_VIEW_STATE
                                  ? SlideTransition(
                                      position: _offset!,
                                      child: widget.getFloatingButton(
                                          context, _getController),
                                    )
                                  : Container();
                            })
                          : widget.getFloatingButton(context, _getController)
                      : null,
              floatingActionButtonLocation:
                  widget.getFloatingActionButtonLocation(context),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return _viewWidget(context, _getController);
                        }),
                      )
                    ],
                  ),
                ),
              ),
              backgroundColor: widget.getScreenColor(),
              drawer: widget.getDrawer(context),
              endDrawer: widget.getEndDrawer(context),
              bottomNavigationBar: widget.getBottomNavigationBar(context),
              resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset(),
              endDrawerEnableOpenDragGesture: false,
              drawerEnableOpenDragGesture: false,
            ),
            Obx(() {
              return _getController.progressBar.value
                  ? Container(
                      alignment: Alignment.center,
                      color: Colors.black26,
                      height: Get.height,
                      width: Get.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    );
            })
          ],
        );
      },
    );
  }

  Widget _viewWidget(BuildContext context, T lc) {
    switch (lc.viewState.value) {
      case ViewState.SHIMMER_STATE:
        return widget.getShimmerWidget(context, lc);
        break;
      case ViewState.NO_INTERNET_STATE:
        return widget.getNoInternetWidget(context, lc);
        break;
      case ViewState.LIST_ERROR_STATE:
        return widget.getErrorWidget(context, lc);
        break;
      case ViewState.LIST_EMPTY_STATE:
        return widget.getEmptyListWidget(context, lc);
        break;
      case ViewState.LIST_VIEW_STATE:
        return _getListViewWidget(context, lc, lc.getDataList().toList());
        break;
      default:
        return Container();
        break;
    }
  }

  Widget _getListViewWidget(
      BuildContext context, T controller, List<dynamic> dataList) {
    // if (dataList.isNotEmpty) {
      return Column(
        children: [
          Visibility(
              visible: dataList.isEmpty,
              child: widget.getTopWidget(context, controller)),
          Expanded(
            child: dataList.isNotEmpty?
            NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  widget.onListScrollStart(context, _getController);
                } else if (scrollNotification is ScrollUpdateNotification) {
                } else if (scrollNotification is ScrollEndNotification) {
                  widget.onListScrollEnd(context, _getController);
                }
                return true;
              },
              child: SmartRefresher(
                controller: controller.refreshController,
                enablePullUp: true,
                enablePullDown:
                    widget.enablePullToRefresh(controller) != null &&
                        widget.enablePullToRefresh(controller),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  },
                  height: 0,
                ),
                header: CustomHeader(
                  builder: (context, mode) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.black87,
                    );
                  },
                ),
                onRefresh: () {
                  widget.onPullToRefresh(controller);
                },
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return index == dataList.length
                        ? Obx(() {
                            if (controller.isLoading()) {
                              Future.delayed(Duration(milliseconds: 100), () {
                                _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent);
                              });
                              return widget.getLoadMoreWidget(
                                  context, controller);
                            } else {
                              return Container();
                            }
                          })
                        : index == 0
                            ? widget.getTopWidget(context, controller)
                            : widget.getListItemWidget(context, controller,
                                dataList.elementAt(index), index);
                  },
                  separatorBuilder: (ctx, index) {
                    return widget.getListSeparatorWidget(
                        context, controller, dataList.elementAt(index), index);
                  },
                  itemCount: dataList.isNotEmpty ? dataList.length + 1 : 0,
                  shrinkWrap: true,
                  cacheExtent: widget.cacheExtentLimit(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                ),
              ),
            ):widget.getEmptyListWidget(context, controller),
          ),
          widget.getBottomWidget(context, controller),
        ],
      );
    // } else {
    //   return widget.getEmptyListWidget(context, controller);
    // }
  }
}

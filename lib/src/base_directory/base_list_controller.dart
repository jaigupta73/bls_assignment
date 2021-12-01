import 'dart:async';

import 'package:assignment/src/util/enums.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_get_controller.dart';


abstract class BaseListController<T> extends BaseGetController {
  Rx<ViewState> viewState = ViewState.SHIMMER_STATE.obs;
  RxList<T> _dataList = <T>[].obs;
  RxBool showLoadMore = false.obs;
  RxBool progressBar = false.obs;
  Connectivity _connectivity = Connectivity();
  PreviousNetStatus _previousNetStatus = PreviousNetStatus.NONE;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _firstTimeNet = true;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  hidePullToRefreshBar() {
    try {
      refreshController.refreshCompleted();
    } catch (e) {
      print(e);
    }
  }

  bool isLoading() {
    return showLoadMore.value;
  }

  bool isProgressBarShowing() {
    return progressBar.value;
  }

  void setLoading(bool loading) {
    showLoadMore.value = loading;
  }

  showProgressBar(bool b) {
    progressBar.value = b;
  }

  void addItemsToDataList(List<T> items, {bool clearPreviousData = false}) {
    if (clearPreviousData != null && clearPreviousData) {
      _dataList.clear();
      _dataList.addAll(items);
    } else {
      _dataList.addAll(items);
    }
    showLoadMore.value = false;
  }

  void addItemToDataList(T item) {
    _dataList.add(item);
  }

  List<T> getDataList() {
    return _dataList;
  }

  void clearDataList() {
    _dataList.clear();
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _connectivitySubscription?.cancel();
  }

  void onConnected() {}

  void onDisConnected() {}

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result!);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            onConnected();
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
            onConnected();
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
            onDisConnected();
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
            onDisConnected();
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
    }
  }
}

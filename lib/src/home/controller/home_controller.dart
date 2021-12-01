import 'package:assignment/src/base_directory/base_list_controller.dart';
import 'package:assignment/src/home/models/tournament_response_model.dart';
import 'package:assignment/src/home/repository/tournament_respo.dart';
import 'package:assignment/src/preferences/app_preference.dart';
import 'package:assignment/src/util/enums.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment/src/login/models/user.dart' as user_data;

class HomeController extends BaseListController<Tournaments> {
  RxBool loading = false.obs,
      isInternetConnected = true.obs,
      isLoadMoreContent = true.obs;
  Rx<ViewState> viewState = ViewState.SHIMMER_STATE.obs,
      viewStateAll = ViewState.SHIMMER_STATE.obs;
  ScrollController? scrollController;
  RxString appLangCode = AppPreferences.getLanguageCode().obs;

  final TournamentRepo _tournamentRepo = TournamentRepo();
  int limit = 20;
  List<Tournaments> tournamentList = [];
  TournamentResponseModel? tournamentResponseModel;
  RxString cursor = ''.obs;

  late user_data.Data userData;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    userData = await getUserData();
  }

  void onError(e) {
    appLog(e.toString());

    viewState.value = ViewState.LIST_ERROR_STATE;
    isLoadMoreContent.value = false;
    loading.value = false;
  }

  void onInternetError(e) {
    viewState.value = ViewState.NO_INTERNET_STATE;

    isLoadMoreContent.value = false;
    loading.value = false;
  }

  void onInternetConnected() async {
    isInternetConnected.value = true;
  }

  getTournamentDataAPI() async {
    if (await isConnected()) {
      await _tournamentRepo.getTournamentRepo(limit, cursor.value).then(
          (value) {
        tournamentResponseModel = value;
        if (value.success) {
          cursor.value = value.data.cursor;
          isLoadMoreContent.value = true;

          tournamentList.addAll(value.data.tournaments);
          addItemsToDataList(value.data.tournaments);
          viewState.value = ViewState.LIST_VIEW_STATE;
        } else {
          if (tournamentList.isEmpty) {
            viewState.value = ViewState.LIST_VIEW_STATE;
          }
          isLoadMoreContent.value = false;
        }
      }, onError: (e) {
        appLog(e);
      });
    } else {
      onInternetError('');
    }
  }
}

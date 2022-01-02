import 'package:askforastro/base_directory/base_list_controller.dart';
import 'package:askforastro/screens/daily_panchang/models/panchang_model.dart';
import 'package:askforastro/screens/daily_panchang/models/places_model.dart';
import 'package:askforastro/screens/daily_panchang/repository/panchang_respo.dart';
import 'package:askforastro/screens/home/models/agents_list_model.dart';
import 'package:askforastro/screens/home/repository/agentlist_respo.dart';
import 'package:askforastro/util/enums.dart';
import 'package:askforastro/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanchangController extends BaseListController<AgentData> {
  RxBool loading = false.obs,
      isInternetConnected = true.obs,
      isLoadMoreContent = true.obs;
  Rx<ViewState> viewState = ViewState.SHIMMER_STATE.obs,
      viewStateAll = ViewState.SHIMMER_STATE.obs;
  ScrollController? scrollController;

  final PanchangRepo _panchangRepo = PanchangRepo();

  List<PlaceData> placeDataList = <PlaceData>[].obs;

  PlacesModel? placesModel;
  PanchangData? panchangData;

  TextEditingController searchEditController = TextEditingController(text: 'Delhi, India');
  Rx<DateTime> selectedDateTime = DateTime.now().obs;
  RxString currentDateTime = getValidDate(DateTime.now()).obs;
  RxString selectedPlaceId = ''.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    getDailyPanchangDetails(selectedDateTime.value);
    super.onInit();
  }

  void onError(e) {
    appLog(e.toString());

    viewState.value = ViewState.LIST_ERROR_STATE;

    loading.value = false;
  }

  void onInternetError(e) {
    viewState.value = ViewState.NO_INTERNET_STATE;
    loading.value = false;
  }

  void onInternetConnected() async {
    isInternetConnected.value = true;
  }

  Future<List<PlaceData>> getSearchPlaceInfo(String query) async {
    if (await isConnected()) {
      await _panchangRepo.getSearchPlaceList(query).then((value) {
        placesModel = value;
        if (value.success) {
          placeDataList.clear();
          placeDataList.assignAll(value.data);
          viewState.value = ViewState.LIST_VIEW_STATE;
        } else {
          viewState.value = ViewState.LIST_ERROR_STATE;
        }
      }, onError: (e) {
        appLog(e);
        onError(e);
      });
    } else {
      onInternetError('');
    }
    return placeDataList;
  }

  void getDailyPanchangDetails(DateTime time,
      {String placeId = 'ChIJL_P_CXMEDTkRw0ZdG-0GVvw'}) async {
    viewState.value =ViewState.SHIMMER_STATE;
    Map<String, dynamic> postData = {
      "day": time.day,
      "month": time.month,
      "year": time.year,
      "placeId": placeId
    };
    if (await isConnected()) {
      await _panchangRepo.getpanchangDetails(postData).then((value) {
        if (value.success) {
          panchangData = value.data;
          viewState.value = ViewState.LIST_VIEW_STATE;
        } else {
          viewState.value = ViewState.LIST_ERROR_STATE;
        }
      }, onError: (e) {
        appLog(e);
        onError(e);
      });
    } else {
      onInternetError('');
    }
  }
}

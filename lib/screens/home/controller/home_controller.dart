import 'package:askforastro/base_directory/base_list_controller.dart';
import 'package:askforastro/screens/home/models/agents_list_model.dart';
import 'package:askforastro/screens/home/repository/agentlist_respo.dart';
import 'package:askforastro/util/enums.dart';
import 'package:askforastro/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends BaseListController<AgentData> {
  RxBool loading = false.obs,
      isInternetConnected = true.obs,
      isLoadMoreContent = true.obs;
  Rx<ViewState> viewState = ViewState.SHIMMER_STATE.obs,
      viewStateAll = ViewState.SHIMMER_STATE.obs;
  ScrollController? scrollController;

  final AgentListRepo _agentListRepo = AgentListRepo();

  List<AgentData> agentDataList = [];
  RxList<Skills> langList = <Skills>[].obs;
  RxList<Skills> skillList = <Skills>[].obs;
  AgentsListModel? agentsListModel;
  RxInt currentSortIndex = 0.obs;
  RxBool isShowSearchOption = false.obs;
  RxBool isShowFilterOption = false.obs;
  TextEditingController searchEditController = TextEditingController();
  var sortByValue = [
    getStringFromLocale('expHTL'),
    getStringFromLocale('expLTH'),
    getStringFromLocale('prcHTL'),
    getStringFromLocale('prcLTH')
  ];

  @override
  void onInit() async {
    // TODO: implement onInit
    callGetAgentListAPI();
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

  callGetAgentListAPI() async {
    // if (await isConnected()) {
      await _agentListRepo.getAllAgentListRepo().then((value) {
        agentsListModel = value;
        if (value.success) {
          agentDataList.addAll(value.data);
          addItemsToDataList(value.data);
          langList.assignAll(value.data[0].languages);
          skillList.assignAll(value.data[0].skills);
          viewState.value = ViewState.LIST_VIEW_STATE;
        } else {
          viewState.value = ViewState.LIST_ERROR_STATE;
        }
      }, onError: (e) {
        appLog(e);
      });
    // } else {
    //   onInternetError('');
    // }
  }

  void listSortByPrice({bool isHigh = false}) {
    if (isHigh) {
      agentDataList.sort((a, b) {
        return b.additionalPerMinuteCharges
            .compareTo(a.additionalPerMinuteCharges);
      });
    } else {
      agentDataList.sort((a, b) {
        return a.additionalPerMinuteCharges
            .compareTo(b.additionalPerMinuteCharges);
      });
    }
    addItemsToDataList(agentDataList, clearPreviousData: true);
  }

  void listSortByExperience({bool isHigh = false}) {
    if (isHigh) {
      agentDataList.sort((a, b) {
        return b.experience.compareTo(a.experience);
      });
    } else {
      agentDataList.sort((a, b) {
        return a.experience.compareTo(b.experience);
      });
    }
    addItemsToDataList(agentDataList, clearPreviousData: true);
  }

  void listFilterSearch(
    String queryText,
  ) {
    if (queryText.isNotEmpty) {
      List<AgentData> searchList = [];
      searchList = agentDataList
          .where((element) =>
              element.firstName.isCaseInsensitiveContainsAny(queryText) ||
              element.lastName.isCaseInsensitiveContainsAny(queryText) ||
              element.filterSkilled.isCaseInsensitiveContainsAny(queryText) ||
              element.filterLanguage.isCaseInsensitiveContainsAny(queryText))
          .toList();

      addItemsToDataList(searchList, clearPreviousData: true);
    } else {
      agentDataList.clear();
      agentDataList.addAll(agentsListModel!.data);
      addItemsToDataList(agentsListModel!.data, clearPreviousData: true);
    }
  }

  void sortByAction(int value) {
    switch (value) {
      case 1:
        listSortByExperience(isHigh: true);
        break;
      case 2:
        listSortByExperience(isHigh: false);
        break;
      case 3:
        listSortByPrice(isHigh: true);
        break;
      case 4:
        listSortByPrice(isHigh: false);
        break;
    }
  }

  void filterAgentList() {
    var selectedLang = langList.where((p0) => p0.isSelected).toList();
    var selectedSkill = skillList.where((p0) => p0.isSelected).toList();
    agentDataList.clear();
    for (var element in selectedLang) {
      agentDataList.addAll(agentsListModel!.data.where((agents) => agents.filterLanguage.isCaseInsensitiveContainsAny(element.name)).toList());
    }
    for (var element in selectedSkill) {
      agentDataList.addAll(agentsListModel!.data.where((agents) => agents.filterSkilled.isCaseInsensitiveContainsAny(element.name)).toList());
    }
    addItemsToDataList(agentDataList, clearPreviousData: true);
  }
}

import 'package:askforastro/base_directory/base_get_state.dart';
import 'package:askforastro/custom_widget/textview.dart';
import 'package:askforastro/screens/daily_panchang/controller/panchang_controller.dart';
import 'package:askforastro/screens/daily_panchang/models/places_model.dart';
import 'package:askforastro/util/enums.dart';
import 'package:askforastro/util/utils.dart';
import 'package:askforastro/values/custom_colors.dart';
import 'package:askforastro/values/custom_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PanchangDetailPage extends StatefulWidget {
  const PanchangDetailPage({Key? key}) : super(key: key);

  @override
  _PanchangDetailPageState createState() => _PanchangDetailPageState();
}

class _PanchangDetailPageState extends BaseGetState<PanchangDetailPage> {
  PanchangController _panchangController = Get.put(PanchangController());

  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement getBuildWidget
    return Container(
      padding: const EdgeInsets.only(left: spacing_xxl_2, right: spacing_xxl_2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextView(
              title: getString('panchangMsg'),
              textStyle: commonTextStyle(fontWeight: FontWeight.w300),
              maxLines: 4,
            ),
            Container(
              width: Get.width,
              margin: const EdgeInsets.only(top: spacing_xxl_2),
              padding: const EdgeInsets.all(spacing_xxl_2),
              decoration: BoxDecoration(color: colorPrimary.withOpacity(.15)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 75,
                        child: TextView(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: spacing_xl),
                            title: getString('date'),
                            textStyle: commonTextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                      ),
                      InkWell(
                        onTap: () async {
                          _panchangController.selectedDateTime.value = await selectDateTime(context);
                          _panchangController.currentDateTime.value =
                              getValidDate(_panchangController.selectedDateTime.value);

                          _panchangController.getDailyPanchangDetails(_panchangController.selectedDateTime.value,placeId:_panchangController.selectedPlaceId.value );
                        },
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.all(spacing_xl),
                            width: Get.width * .60,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextView(
                                    title: _panchangController
                                        .currentDateTime.value,
                                    textStyle: commonTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                const Icon(Icons.arrow_drop_down_rounded)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: spacing_xxl_2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 75,
                        child: TextView(
                            margin: EdgeInsets.only(right: spacing_xl),
                            alignment: Alignment.centerRight,
                            title: getString('location'),
                            textStyle: commonTextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                      ),
                      Container(
                        // padding: const EdgeInsets.all(spacing_xl),
                        color: Colors.white,
                        width: Get.width * .60,
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            // autofocus: true,
                            controller:
                                _panchangController.searchEditController,
                            style: commonTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                            decoration: const InputDecoration(
                              //Add th Hint text here.
                              hintText: "Search Location",
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return pattern.isNotEmpty
                                ? await _panchangController
                                    .getSearchPlaceInfo(pattern)
                                : <PlaceData>[];
                          },
                          itemBuilder: (context, PlaceData suggestion) {
                            return ListTile(
                              title: Text(suggestion.placeName,
                                  style: commonTextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15)),
                            );
                          },
                          onSuggestionSelected: (PlaceData suggestion) {
                            _panchangController.searchEditController.text =
                                suggestion.placeName;
                            _panchangController.selectedPlaceId.value = suggestion.placeId;
                            _panchangController.getDailyPanchangDetails(_panchangController.selectedDateTime.value,placeId:_panchangController.selectedPlaceId.value );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Obx(() =>
                (_panchangController.viewState.value == ViewState.SHIMMER_STATE
                    ? Container(
                        height: Get.height / 2,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: spacing_xxl_2),
                        child: Column(
                          children: [
                            TextView(
                                title: getString('tithi'),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('tithiNumber'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                            '${_panchangController.panchangData!.tithi.details.tithiNumber}',
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('tithiName'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: _panchangController.panchangData!
                                            .tithi.details.tithiName,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('special'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: _panchangController.panchangData!
                                            .tithi.details.special,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('summary'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: _panchangController.panchangData!
                                            .tithi.details.summary,
                                        maxLines: 5,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('deity'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: _panchangController
                                            .panchangData!.tithi.details.deity,
                                        maxLines: 5,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('endTime'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: getFormattedMultipleString(
                                            getString('endTimeValue'),
                                            '${_panchangController.panchangData!.tithi.endTime.hour}',
                                            '${_panchangController.panchangData!.tithi.endTime.minute}',
                                            '${_panchangController.panchangData!.tithi.endTime.second}'),
                                        maxLines: 5,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('nakshatra'),
                                margin: EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('nakshatraNumber'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        '${_panchangController.panchangData!.nakshatra.details.nakNumber}',
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('nakshatraName'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.nakshatra.details.nakName,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('deity'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.nakshatra.details.deity,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('summary'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.nakshatra.details.summary,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('special'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.nakshatra.details.special,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_m),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('endTime'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: getFormattedMultipleString(
                                            getString('endTimeValue'),
                                            '${_panchangController.panchangData!.nakshatra.endTime.hour}',
                                            '${_panchangController.panchangData!.nakshatra.endTime.minute}',
                                            '${_panchangController.panchangData!.nakshatra.endTime.second}'),
                                        maxLines: 5,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('yog'),
                                margin: EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('yogNumber'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        '${_panchangController.panchangData!.yog.details.yogNumber}',
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('yogName'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.yog.details.yogName,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('special'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.yog.details.special,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('meaning'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.yog.details.meaning,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('endTime'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: getFormattedMultipleString(
                                            getString('endTimeValue'),
                                            '${_panchangController.panchangData!.yog.endTime.hour}',
                                            '${_panchangController.panchangData!.yog.endTime.minute}',
                                            '${_panchangController.panchangData!.yog.endTime.second}'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('karan'),
                                margin: const EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('karanNumber'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        '${_panchangController.panchangData!.karan.details.karanNumber}',
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('karanName'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.karan.details.karanName,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('special'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.karan.details.special,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('deity'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.karan.details.deity,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('endTime'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title: getFormattedMultipleString(
                                            getString('endTimeValue'),
                                            '${_panchangController.panchangData!.yog.endTime.hour}',
                                            '${_panchangController.panchangData!.yog.endTime.minute}',
                                            '${_panchangController.panchangData!.yog.endTime.second}'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('hinduMaah'),
                                margin: const EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('purnimanta'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.hinduMaah.purnimanta,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('amanta'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.hinduMaah.amanta,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('amanta'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.paksha,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('ritu'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.ritu,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('sunSign'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.sunSign,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('moonSign'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.moonSign,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('ayana'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.ayana,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('panchangYog'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.panchangYog,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('vikramSamvat'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        '${_panchangController.panchangData!.vikramSamvat}',
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('shakaSamvat'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        '${_panchangController.panchangData!.shakaSamvat}',
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('shakaSamvatName'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.shakaSamvatName,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('dishaShool'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.dishaShool,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('dishaShoolRemedies'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.dishaShoolRemedies,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('nakShool'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.nakShool.remedies,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('moonNivas'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.moonNivas,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('abhijitMuhurta'),
                                margin: const EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('start'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.abhijitMuhurta.start,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('end'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.abhijitMuhurta.end,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('rahukaal'),
                                margin: const EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('start'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.rahukaal.start,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('end'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.rahukaal.end,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('gulikaal'),
                                margin: const EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('start'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.guliKaal.start,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('end'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.guliKaal.end,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            TextView(
                                title: getString('yamghantKaal'),
                                margin: const EdgeInsets.only(top: spacing_xxl_2),
                                textStyle: commonTextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('start'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.yamghantKaal.start,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: spacing_xl),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * .4,
                                    child: TextView(
                                        title: getString('end'),
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Expanded(
                                    child: TextView(
                                        title:
                                        _panchangController.panchangData!.yamghantKaal.end,
                                        textStyle: commonTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )))
          ],
        ),
      ),
    );
  }

  @override
  void onScreenReady(BuildContext context) {
    // TODO: implement onScreenReady
  }

  @override
  Color? getScreenColor() {
    // TODO: implement getScreenColor
    return Colors.white;
  }

  @override
  PreferredSizeWidget? getToolBar(BuildContext context) {
    // TODO: implement getToolBar
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        child: const Icon(Icons.arrow_back_rounded, color: colorPrimary),
        onTap: () {
          Get.back();
        },
      ),
      titleSpacing: 0,
      title: TextView(
        title: getString('dailyPanchang'),
        textStyle: commonTextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}

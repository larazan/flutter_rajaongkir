import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../city_model.dart';
import 'package:http/http.dart' as http;

class Kota extends GetView<HomeController> {
  const Kota({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);

  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        label: tipe == "asal"
            ? "Kota / kabupaten Asal"
            : "Kota / kabupaten Tujuan",
        showClearButton: true,
        onFind: (String? filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=${provId}");

          try {
            final response = await http.get(
              url,
              headers: {
                "key": "18c1ae365c10fea954e08449b1c2e185",
              },
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (err) {
            return List<City>.empty();
          }
        },
        onChanged: (cityValue) {
          if (cityValue != null) {
            if (tipe == "asal") {
              controller.kotaAsalId.value = int.parse(cityValue.cityId!);
            } else {
              controller.kotaTujuanId.value = int.parse(cityValue.cityId!);
            }
          } else {
            if (tipe == "asal") {
              print("Tidak memilih kota / kabupaten asal apapun");
              controller.kotaAsalId.value = 0;
            } else {
              print("Tidak memilih kota / kabupaten tujuan apapun");
              controller.kotaTujuanId.value = 0;
            }
          }
          controller.showButton();
        },
        showSearchBox: true,
        searchFieldProps: TextFieldProps(),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.type} ${item.cityName}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => "${item!.type} ${item.cityName}",
      ),
    );
  }
}

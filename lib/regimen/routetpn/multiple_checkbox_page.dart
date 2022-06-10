import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:glucose_control/const.dart';

class Item {
  Item(this.title);

  String title;
  bool selected = false;

  String toString() => title;
}

class MultipleCheckBoxPage extends StatelessWidget {
  final dataList = <Item>[
    Item(LoginTexts.titleItem5),
    Item(LoginTexts.titleItem6),
    Item(LoginTexts.titleItem7),
  ].obs;

  final selectedItems = <Item>[].obs;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Kêt quả theo dõi",
            style: TextStyle(fontSize: 24),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: generateItems(),
            )),
            ElevatedButton(
              onPressed: () {
                selectedItems.clear();
                selectedItems.addAll(dataList.where((p0) => p0.selected));
                selectedItems.refresh();
              },
              child: const Text("Get Selected"),
            ),
            Obx(
                  () => Text(selectedItems.join(", ")),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

  List<Widget> generateItems() {
    final result = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      result.add(CheckboxListTile(
          value: dataList[i].selected,
          title: Text(dataList[i].title),
          onChanged: (v) {
            dataList[i].selected = v ?? false;
            dataList.refresh();
          }));
    }
    return result;
  }
}
import 'package:flutter/material.dart';
import '../../global.dart' as global;
import '../routetpn/rout1.dart';
import '../routetpn/route2.dart';

class FormTPN extends StatefulWidget {
  const FormTPN({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormTPNState();
  }
}

class FormTPNState extends State<FormTPN> {
  List<String> dtdList = ["1", "2"];
  List<String> timeList = [
    "Đang tiêm insulin",
    "Không tiêm insulin",
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // FormTPNState();

  Widget _buildDTD() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            'Tiểu đường cấp',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Wrap(
            spacing: 1.0,
            runSpacing: 1.0,
            children: <Widget>[
              choiceChipWidget(dtdList),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            'Đã tiêm insunlin chưa',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 1.0,
          runSpacing: 1.0,
          children: <Widget>[
            choiceChipWidget(timeList),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form TPN")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTime(),
                const SizedBox(height: 100),
                RaisedButton(
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                global.str_regiment == 'Đang tiêm insulin'
                                    ? Route2()
                                    : const Route1()));
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    //Send to API
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  // int index = 1;
  const choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
            label: Text(item),
            labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: const Color(0xffededed),
            selectedColor: const Color(0xffffc107),
            selected: selectedChoice == item,
            onSelected: (selected) {
              setState(() {
                selectedChoice = item;
                global.str_regiment = item;
              });
            }),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glucose_control/regimen/tpn/formtpn.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  late String _name;
  late String _gender;
  late String _height;
  late String _weight;
  late String _glucose;
  List<String> genderList = ["nam", "nữ"];
  List<String> dtdList = ["1", "2"];
  List<String> timeList = ["6h", "12h", "18h", "22h"];
  late DateTime _dateTime = DateTime.now();
  late DateTime firstDate = DateTime(1900, 1);
  late DateTime lastDate = DateTime(2200, 12);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Họ Tên'),
      maxLength: 20,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (value) {
        _gender = value!;
      },
    );
  }

  Widget _builGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            child: const Text(
              'Giới tính',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          child: Wrap(
            spacing: 1.0,
            runSpacing: 1.0,
            children: <Widget>[
              choiceChipWidget(genderList),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeight() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Chiều cao(cm)'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Height is Required';
        }

        return null;
      },
      onSaved: (value) {
        _height = value!;
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Cân nặng(kg)'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Weight is Required';
        }

        return null;
      },
      onSaved: (value) {
        _weight = value!;
      },
    );
  }

  Widget _buildDTD() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            child: const Text(
              'Tiểu đường cấp',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
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

  Widget _buildBirth() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            '$_dateTime'.split(' ')[0],
            style: const TextStyle(fontSize: 15),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () => _openDatePicker(context),
              child: const Text('Chọn ngày sinh')),
        ],
      ),
    );
  }

  _openDatePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: firstDate,
        lastDate: lastDate);
    if (date != null) {
      setState(() {
        _dateTime = date;
      });
    }
  }

  Widget _buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            child: const Text(
              'Thời gian tiêm',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          child: Wrap(
            spacing: 1.0,
            runSpacing: 1.0,
            children: <Widget>[
              choiceChipWidget(timeList),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildGlucose() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Glucose(mmol/l)'),
      keyboardType: TextInputType.number,
      validator: (value) {
        int? glucose = int.tryParse(value!);

        if (glucose == null || glucose <= 0) {
          return 'Glucose must be greater than 0';
        }

        return null;
      },
      onSaved: (value) {
        _glucose = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Demo")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _builGender(),
                _buildBirth(),
                _buildHeight(),
                _buildWeight(),
                _buildGlucose(),
                const SizedBox(height: 100),
                RaisedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FormTPN()));
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    print(_name);
                    print(_gender);
                    print(_height);
                    print(_weight);
                    print(_glucose);
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
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: const Color(0xffededed),
          selectedColor: const Color(0xffffc107),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
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

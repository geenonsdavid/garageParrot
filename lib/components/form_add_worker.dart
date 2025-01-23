import 'package:flutter/material.dart';
import 'package:garage_parrot/components/api_service.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/components/list_workers.dart';
import 'package:garage_parrot/themes/colors.dart';



class FormAddWorker extends StatefulWidget {
  const FormAddWorker({super.key});

  @override
  State<FormAddWorker> createState() => _FormAddWorkerState();
}

class _FormAddWorkerState extends State<FormAddWorker> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> _fields = [
    {"label": "Nom", "hintText": "Veuillez entrer le nom de l'employé"},
    {"label": "Prénom", "hintText": "Veuillez entrer le prénom de l'employé"},
    {"label": "Email", "hintText": "Veuillez entrer son email"},
    {
      "label": "Téléphone",
      "hintText": "Veuillez entrer son numéro de téléphone"
    },
  ];

  late final _focusNodes =
      List.generate(_fields.length, (index) => FocusNode());
  late final _controllers =
      List.generate(_fields.length, (index) => TextEditingController());

  Future<void> insertrecord() async {
  // Call the ApiService class to insert a record
  final apiService = ApiService();
  // Call the insertRecord method from the ApiService class
  await apiService.insertRecord(context, _controllers, _focusNodes);
}

  Widget _buildCustomField(int index, String label, String hintText) {
    return Column(
      children: [
        CustomField(
          controller: _controllers[index],
          context: context,
          customLabel: label,
          customHintText: hintText,
          customFocus: _focusNodes[index],
          customRequestFocus: index < _focusNodes.length - 1
              ? _focusNodes[index + 1]
              : FocusNode(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
            color: secondary,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ..._buildCustomFields(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSubmitButton("Liste des employés",_viewList),
                _buildSubmitButton("Ajouter un employé",_onSubmit),],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(label,onSubmit) => ElevatedButton.icon(
        icon: const Icon(Icons.task_alt),
        onPressed: onSubmit,
        label: Text(label),
      );

  void _onSubmit() {
    if (_formKey.currentState!.validate()) insertrecord();
  }
  void _viewList() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ListWorker()));
  }

  _buildCustomFields() =>
  List.generate(
        _fields.length,
        (index) => _buildCustomField(
            index, _fields[index]["label"]!, _fields[index]["hintText"]!),
      );
}

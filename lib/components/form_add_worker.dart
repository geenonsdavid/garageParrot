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

  // list label et hintText
  final List<Map<String, String>> _fields = [
    {"label": "Nom", 
    "hintText": "Veuillez entrer le nom de l'employé",
    },
    {"label": "Prénom", 
    "hintText": "Veuillez entrer le prénom de l'employé",
    },
    {"label": "Email", 
    "hintText": "Veuillez entrer son email",
    },
    {
      "label": "Téléphone",
      "hintText": "Veuillez entrer son numéro de téléphone",
    },
    {"label": "Mot de passe", 
    "hintText": "Veuillez entrer son mot de passe",
    },
    {"label": "Confirmer le mot de passe", 
    "hintText": "Veuillez confirmer son mot de passe",
    },
  ];

  // list of focus nodes
  late final _focusNodes = List.generate(_fields.length, (index) => FocusNode());

  // list of controllers
  late final _controllers = List.generate(_fields.length, (index) => TextEditingController());

  // créer instance ApiService
  final ApiService apiservice = ApiService();

  Future<void> insertworker() async {
    await apiservice.insertWorker(
      _controllers,
      _focusNodes,
      (message) => apiservice.showSuccessDialog(context, message),
      (message) => apiservice.showErrorDialog(context, message),
      );
  }


Future<void> getworkers() async {
    await apiservice.getWorkers();
  }

  // build custom field
  // index: index of the field
  // label: label of the field
  // hintText: hint text of the field
  // return: custom field widget
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
            ..._buildCustomFields(), // custom fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSubmitButton(
                    "Liste des employés", _viewList), // submit button,
                _buildSubmitButton(
                    "Ajouter un employé", _onSubmit) // submit button
                ,
              ],
            ),
          ],
        ),
      ),
    );
  }

  // build submit button
  // label: label of the button
  // onSubmit: function to call when the button is pressed
  // return: submit button widget
  Widget _buildSubmitButton(label, onSubmit) => ElevatedButton.icon(
        icon: const Icon(Icons.task_alt),
        onPressed: onSubmit,
        label: Text(label),
      );

  // on submit
  // validate the form
  void _onSubmit() {
    if (_formKey.currentState!.validate()) insertworker();
  }

  // view list
  void _viewList() {
    // open view listWorkers
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>const  ListWorkers()),
    );
  }

  // build custom fields
  _buildCustomFields() => List.generate(
        _fields.length,
        (index) => _buildCustomField(
            index, _fields[index]["label"]!, _fields[index]["hintText"]!),
      );
}

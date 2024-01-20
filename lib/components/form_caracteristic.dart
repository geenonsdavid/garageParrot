import 'package:flutter/material.dart';
import 'package:garage_parrot/components/customfield.dart';
import 'package:garage_parrot/components/radio_door.dart';
import 'package:garage_parrot/components/radio_fuel.dart';
import 'package:garage_parrot/components/radio_gearbox.dart';
import 'package:garage_parrot/themes/colors.dart';

// Define a custom Form widget.
class FormCaracteristic extends StatefulWidget {
  const FormCaracteristic({super.key});

  @override
  FormCaracteristicState createState() {
    return FormCaracteristicState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class FormCaracteristicState extends State<FormCaracteristic> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  double? price ;
  String marque = "";
  String model = "";
  int? year;
  int? kilometer;
  int? din;
  int? fiscPower;
  String color = "";

  final _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _marqueFocusNode = FocusNode();
  final _modelFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();
  final _kilometerFocusNode = FocusNode();
  final _dinFocusNode = FocusNode();
  final _fiscPowerFocusNode = FocusNode();
  final _colorFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 1,
            color: secondary,
          )),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Caractéristique du véhicule',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Add TextFormFields and ElevatedButton here.
                CustomField(
                    context: context,
                    customLabel: "Prix",
                    customHintText: "Veuillez entrer le prix",
                    customFocus: _priceFocusNode,
                    customRequestFocus: _marqueFocusNode),
                const SizedBox(height: 10),
                CustomField(
                    context: context,
                    customLabel: "Marque",
                    customHintText: "Citroën, Ford, Peugeot, etc",
                    customFocus: _marqueFocusNode,
                    customRequestFocus: _modelFocusNode),
                const SizedBox(height: 10),
                CustomField(
                    context: context,
                    customLabel: "Modèle",
                    customHintText: "Corsa, twingo, clio, etc",
                    customFocus: _modelFocusNode,
                    customRequestFocus: _yearFocusNode),
                const SizedBox(height: 10),
                CustomField(
                    context: context,
                    customLabel: "Année",
                    customHintText: "Année de mise en circulation",
                    customFocus: _yearFocusNode,
                    customRequestFocus: _kilometerFocusNode),
                const SizedBox(height: 10),
                CustomField(
                    context: context,
                    customLabel: "Kilomètres",
                    customHintText: "Saisir les kilomètres",
                    customFocus: _kilometerFocusNode,
                    customRequestFocus: _kilometerFocusNode),
                const SizedBox(height: 10),
                CustomField(
                    context: context,
                    customLabel: "Puissance DIN",
                    customHintText: "Saisir la puissance DIN",
                    customFocus: _dinFocusNode,
                    customRequestFocus: _fiscPowerFocusNode),
                const SizedBox(height: 10),
                CustomField(
                    context: context,
                    customLabel: "Puissance fiscale",
                    customHintText: "Saisir puissance fiscale",
                    customFocus: _fiscPowerFocusNode,
                    customRequestFocus: _colorFocusNode),
                const SizedBox(height: 10),
                CustomField(
                    context: context,
                    customLabel: "Couleur",
                    customHintText: "Saisir la couleur principale",
                    customFocus: _colorFocusNode,
                    customRequestFocus: _colorFocusNode),
                const SizedBox(height: 10),
                const RadioDoor(),
                const RadioGearbox(),
                const RadioFuel(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.task_alt),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // send form at administrator email
                      submit();
                    }
                  },
                  label: const Text("Envoyez"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Envoie réussi')),
    );
  }
}

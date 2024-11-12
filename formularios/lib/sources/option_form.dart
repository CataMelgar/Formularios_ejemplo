import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Clase principal para el formulario de opciones
class OptionForm extends StatefulWidget {
  const OptionForm({super.key});

  // Método que crea el estado de este formulario
  @override
  State<OptionForm> createState() {
    return _OptionFormState();
  }
}
// Estado asociado al formulario de opciones
class _OptionFormState extends State<OptionForm> {
  final String title = 'Catalina Melgarejo 24/25';
  final _formKey = GlobalKey<FormBuilderState>();
  // Listado de opciones para ser usadas en el dropdown
  var speedOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  //Función que maneja los cambios de los valores del formulario
  void _onChanged(dynamic val) => debugPrint(val.toString());

  // Construcción del widget de la interfaz gráfica
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Cuerpo de la página con scroll habilitado para evitar desbordes
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Formulario con la llave para manejar su estado y validación
          child: FormBuilder(
            key: _formKey,
            onChanged: () {
              _formKey.currentState!.save();
              debugPrint(_formKey.currentState!.value.toString());
            },
            autovalidateMode: AutovalidateMode.disabled,
            skipDisabled: true,
            // Columnas que agrupan los diferentes campos del formulario
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Formulario para las opciones del "Choice Chip"
                      Center(
                        child: FormBuilderChoiceChip<String>(
                          name: 'choice_chips',
                          decoration: InputDecoration(
                            labelText: 'Choice Chips',
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Color opcional para el hintText
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                              borderSide: const BorderSide(color: Colors.grey), // Color del borde
                            ),
                          ),
                          alignment: WrapAlignment.center,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(200)
                          ),
                          options: const [
                              FormBuilderChipOption(
                                value: 'Flutter',
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Text(
                                    'F',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              FormBuilderChipOption(
                                value: 'Android',
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Text(
                                    'A',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              FormBuilderChipOption(
                                value: 'Chrome OS',
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  child: Text(
                                    'C',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                            selectedColor: Colors.purple,
                            backgroundColor: Colors.purple[100],
                            spacing: 8.0, // Espacio entre chips
                            onChanged: _onChanged,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Formulario para el interruptor (switch)
                      Center(
                        child: FormBuilderSwitch(
                          title: const Text('This is a Switch'),
                          name: 'switch',
                          initialValue: true,
                          decoration: InputDecoration(
                            labelText: 'Switch',
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Color opcional para el hintText
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                              borderSide: const BorderSide(color: Colors.grey), // Color del borde
                            ),
                          ),
                          onChanged: _onChanged,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Campo de texto (TextField) con validación
                      Center(
                        child: FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.always,
                          name: 'TextField',
                          decoration: InputDecoration(
                            labelText: 'Text Field',
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Color opcional para el hintText
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                              borderSide: const BorderSide(color: Colors.grey), // Color del borde
                            ),
                            counterText: '',
                          ),

                          maxLength: 15,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            } else if (value.length < 1) { // Límite mínimo de caracteres
                              return 'El texto debe tener al menos 1 caracteres';
                            }
                            return null; // Retorna null si la validación es exitosa
                          },
                          onChanged: _onChanged,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Dropdown (desplegable) para seleccionar opciones
                      Center(
                        child: FormBuilderDropdown<String>(
                          name: 'options',
                          decoration: InputDecoration(
                            labelText: 'Dropdrow Field',
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Color opcional para el hintText
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.grey)
                            ),
                          ),
                          items: speedOptions
                              .map((speed) => DropdownMenuItem(
                            alignment: AlignmentDirectional.centerStart,
                            value: speed,
                            child: Text(speed),
                          ))
                              .toList(),
                          borderRadius: BorderRadius.circular(8),
                          onChanged: _onChanged,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Grupo de botones de opcion (Radio Group)
                      Center(
                        child: FormBuilderRadioGroup<String>(
                          decoration: InputDecoration(
                            labelText: 'Radio Group Model',
                            hintStyle: const TextStyle(
                              color: Colors.grey, // Color opcional para el hintText
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.grey)
                            ),
                          ),
                          initialValue: null,
                          name: 'Radiogroup',
                          onChanged: _onChanged,
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()]),
                          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                              .map((km) => FormBuilderFieldOption(
                            value: km,
                            child: Text(km),
                          ))
                              .toList(growable: false),
                          controlAffinity: ControlAffinity.leading,
                          orientation: OptionsOrientation.vertical,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Botón flotante para guardar y validar el formulario.
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.upload),
          onPressed: (){
            _formKey.currentState?.saveAndValidate();
            String? formString = _formKey.currentState?.value.toString();
            alertDialog(context, formString!);
          }
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText){
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Submission Completed"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

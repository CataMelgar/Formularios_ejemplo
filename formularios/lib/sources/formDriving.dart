import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

// Widget principal que representa el formulario Driving
class FormDriving extends StatefulWidget {
  const FormDriving({super.key});

  // Método para crear el estado asociado a este widget
  @override
  State<FormDriving> createState() {
    return _FormDrivingState();
  }
}
// Estado asociado a FormDriving que gestiona la lógica del formulario
class _FormDrivingState extends State<FormDriving>  {
  final String title = 'Catalina Melgarejo 24/25';
  final _formKey = GlobalKey<FormBuilderState>(); // Clave única para identificar el formulario

  // Opciones de velocidad para un menú desplegable
  var speedOptions = ['High', 'Medium', 'Low'];
  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
            title,
            style: const TextStyle(color: Colors.white)
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Cuerpo del formulario, envuelto en un SingleChildScrollView para permitir desplazamiento
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const FormTitle(), // Titulo del formulario
            FormBuilder(
              key: _formKey, // Clave del formulario para manejar su estado
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Sección de grupo de radio para seleccionar la velocidad
                    FormLabelGroup(
                        title: 'Please prove the speed of vehicle?',
                        subtitle: 'Please select one option given below',
                    ),
                    FormBuilderRadioGroup<String>(
                      decoration: const InputDecoration(),
                      initialValue: null,
                      name: 'speed',
                      onChanged: _onChanged,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      options: ['Above 40km/h', 'Below 40km/h', '0km/h']
                          .map((km) => FormBuilderFieldOption(
                        value: km,
                        child: Text(km),
                      ))
                          .toList(growable: false),
                      controlAffinity: ControlAffinity.leading,
                      orientation: OptionsOrientation.vertical,
                    ),
                    const SizedBox(height: 20),
                    // Campo de tecto para ingresar observaciones
                    FormLabelGroup(
                      title: 'Enter Remarks',
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'Remarks',
                      decoration: InputDecoration(
                        hintText: 'Enter Remarks',
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
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    // Desplegable para seleccionar la velocidad
                    FormLabelGroup(
                      title: 'Please prove the high speed of vehicle?',
                      subtitle: 'Please select one option given below',
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDropdown<String>(
                      name: 'high speed',
                      decoration: InputDecoration(
                          hintText: 'Select Option',
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
                        alignment: AlignmentDirectional.center,
                        value: speed,
                        child: Text(speed),
                      ))
                          .toList(),
                      borderRadius: BorderRadius.circular(8),
                      onChanged: _onChanged,
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    // Grupo de checkboxes para seleccionar velocidades en la última hora
                    FormLabelGroup(
                      title: 'Please provide the speed of vehicle past 1 hour?',
                      subtitle: 'Please select one option given below',
                    ),
                    FormBuilderCheckboxGroup<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(),
                      name: 'languages',
                      // initialValue: const ['Dart'],
                      options: const [
                        FormBuilderFieldOption(value: '20km/h'),
                        FormBuilderFieldOption(value: '30km/h'),
                        FormBuilderFieldOption(value: '40km/h'),
                        FormBuilderFieldOption(value: '50km/h'),
                      ],
                      onChanged: _onChanged,
                      separator: const VerticalDivider(
                        width: 10,
                        thickness: 5,
                        color: Colors.red,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(1),
                        FormBuilderValidators.maxLength(3),
                      ]
                      ),
                      orientation: OptionsOrientation.vertical,
                    ),
                  ],
                ),
              )
            ),
            const SizedBox(height: 20),
          ]
        ),
      ),
      // Botób flotante para enviar el formulario
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: (){
          _formKey.currentState?.saveAndValidate();
          String? formString = _formKey.currentState?.value.toString();
          alertDialog(context, formString!); // Muestra un cuadro de diálogo con los datos enviados
        }
      ),
    );
  }
}

// Componente que muestra tl título del formulario
class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Driving Form',
            style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text('Form example', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

// Clase para mostrar título y subtítulo opcional en cada grupo del formulario
class FormLabelGroup extends StatelessWidget{
  FormLabelGroup({super.key, required this.title, this.subtitle});

  String title;
  String? subtitle;

  // Muestra el subtítulo si está presente
  Widget conditionalSubtitle(BuildContext context){
    if(subtitle != null){
      return Text(subtitle!,
          style: Theme.of(context).textTheme.labelLarge?.apply(
            fontSizeFactor: 0.9,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)));
    } else{
      return Container();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 18, // Especifica el tamaño de la fuente aquí
          ),

        ),
        const SizedBox(height: 2), // Espacio entre el título y el subtítulo
        conditionalSubtitle(context),
      ],
    );
  }
}

// Función para mostrar un cuadro de diálogo con el contenido del formulario
void alertDialog(BuildContext context, String contentText){
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Submission Completed"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText), // Muestra el contenido del formulario
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context, 'Close'),
            child: const Text('Close'),
        ),
      ],
    ),
  );
}
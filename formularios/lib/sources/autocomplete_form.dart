import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

//Constructor de la clase que acepta una clave (key) para el widget
class FormAutocomplete extends StatefulWidget {
  const FormAutocomplete({super.key});

  // Crea el estado asociado con este formulario
  @override
  State<FormAutocomplete> createState() {
    return _FormAutocompleteState();
  }
}

class _FormAutocompleteState extends State<FormAutocomplete> {
  final String title = 'Catalina Melgarejo 24/25';
  // Llave global para manejar el estado del formulario
  final _formKey = GlobalKey<FormBuilderState>();
  // Controlador de tecto para el campo de autocompletado
  final TextEditingController _textController = TextEditingController();

  // Lista de países para la funcionalidad de autocompletado
  List<String> countries = [
    'Albania',
    'Alemania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaiyán',
    'Bélgica',
    'Bielorrusia',
    'Bosnia y Herzegovina',
    'Bulgaria',
    'Chipre',
    'Ciudad del Vaticano',
    'Croacia',
    'Dinamarca',
    'Eslovaquia',
    'Eslovenia',
    'España',
    'Estonia',
    'Finlandia',
    'Francia',
    'Georgia',
    'Grecia',
    'Hungría',
    'Islandia',
    'Irlanda',
    'Italia',
    'Kazajistán',
    'Kosovo',
    'Letonia',
    'Liechtenstein',
    'Lituania',
    'Luxemburgo',
    'Malta',
    'Moldavia',
    'Mónaco',
    'Montenegro',
    'Noruega',
    'Países Bajos',
    'Polonia',
    'Portugal',
    'Reino Unido',
    'República Checa',
    'Rumanía',
    'Rusia',
    'San Marino',
    'Serbia',
    'Suecia',
    'Suiza',
    'Turquía',
    'Ucrania'
  ];

  // Función que se ejecuta cuando cambia el valor de un campo en el formulario
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
        // Cuerpo de la página con scroll habilitado para evitar desbordes
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Campo de autocompletado con la lista de países
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          // No muestra opciones si el campo está vacío
                          return const Iterable<String>.empty();
                        }
                        return countries.where((String option) {
                          return option.toLowerCase().contains(
                            // Filtro por coincidencia parcial
                              textEditingValue.text.toLowerCase());
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return FormBuilderTextField(
                          controller: textEditingController, // Controlador de texto para el campo
                          name: 'autocomplete', // Nombre del campo en el formulario
                          focusNode: focusNode,
                            onChanged: _onChanged, // Función que maneja los cambios en el campo
                          decoration: InputDecoration(
                            labelText: 'Autocomplete', // Etiqueta del campo
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Campo de selección de fecha utilizando un sector de fecha
                    FormBuilderDateTimePicker(
                      name: 'Date Picket',
                      initialEntryMode: DatePickerEntryMode.calendarOnly, // Modo de entrada solo con calendario
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        labelText: 'Date Picket',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                          borderSide: const BorderSide(color: Colors.grey), // Color del borde
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {
                            _formKey.currentState!.fields['date']?.didChange(null); // Resetear el campo
                          },
                        ),
                      ),
                      initialTime: const TimeOfDay(hour: 8, minute: 0), // Hora inicial si es necesario
                      // locale: const Locale.fromSubtags(languageCode: 'fr'),
                    ),
                    const SizedBox(height: 20),
                    // Campo de selección de rango de fechas
                    FormBuilderDateRangePicker(
                      name: 'date_range',
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2030),
                      format: DateFormat('yyyy-MM-dd'),
                      onChanged: _onChanged,
                      decoration: InputDecoration(
                        labelText: 'Date Range',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                          borderSide: const BorderSide(color: Colors.grey), // Color del borde
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['date_range']
                                ?.didChange(null);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de selección de hora
                    FormBuilderDateTimePicker(
                      name: 'date',
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      inputType: InputType.time,
                      decoration: InputDecoration(
                        labelText: 'Date Picket',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                          borderSide: const BorderSide(color: Colors.grey), // Color del borde
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () {
                            _formKey.currentState!.fields['date']?.didChange(null);
                          },
                        ),
                      ),
                      initialTime: const TimeOfDay(hour: 8, minute: 0),
                      // locale: const Locale.fromSubtags(languageCode: 'fr'),
                    ),
                    const SizedBox(height: 20),
                    // Campo de selección de chips (filtro) con varias opciones
                    FormBuilderFilterChip(
                      name: 'language',
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
                        borderRadius: BorderRadius.circular(20)
                      ),
                      options: const [
                        FormBuilderChipOption(
                          value: 'HTML',
                        ),
                        FormBuilderChipOption(
                          value: 'CSS',
                        ),
                        FormBuilderChipOption(
                          value: 'React',
                        ),
                        FormBuilderChipOption(
                          value: 'Dart',
                        ),
                        FormBuilderChipOption(
                          value: 'TypeScript',
                        ),
                        FormBuilderChipOption(
                          value: 'Angular',
                        ),
                      ],
                      selectedColor: Colors.purple,
                      backgroundColor: Colors.purple[100],
                      spacing: (8.0),
                      runSpacing: (8.0),// Espacio entre chips
                      onChanged: _onChanged,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.upload),
          onPressed: (){
            _formKey.currentState?.saveAndValidate();
            String? formString = _formKey.currentState?.value.toString();
            alertDialog(context, formString!);
          },
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


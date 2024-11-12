// Importación de paquetes necesarios para la aplicación, entre ello los formularios que hemos creado
import 'package:formularios/sources/autocomplete_form.dart';
import 'package:formularios/sources/contact_form.dart';
import 'package:formularios/sources/formDriving.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formularios/sources/option_form.dart';

// Punto de entrada principal de la aplicación
void main() => runApp(const MyApp());

//Clase principal de la aplicación que define el widget raíz
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Sobrescribe el método buil para construir el widget principal de la aplicación
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter FormBuilder Demo', // Titulo de la aplicación
      debugShowCheckedModeBanner: false, // Oculta el banner de depuración
      localizationsDelegates: [ // Delegados para la localización del contenido
        FormBuilderLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales, // Idiomas soportados
      home: _HomePage(),
    );
  }
}

// Página de inicio de la aplicación que muestra una lista de opciones de formularios
class _HomePage extends StatelessWidget {
  const _HomePage();

  // Método build para construir el widget de la página de inicio
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra de título en la parte superior de la pantalla
        title: Container(
          color: Colors.purple,
          child: const Text(
            'Catalina Melgarejo 24/25',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      // Cuerpo de la página: una lista de elementos de formulario
      body: ListView(
        children: <Widget>[
          // Cada ListTile representa un formulario al que se puede navegar
          ListTile(
            title: const Text('Driving Form'), // Titulo del formulario
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FormDriving(),
                ),
              );
            },
          ),
          const Divider(), // Linea divisoria
          ListTile(
            title: const Text('Contact'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Option'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OptionForm(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Autocomplete'),
            trailing: const Icon(Icons.arrow_right_sharp),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormAutocomplete(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
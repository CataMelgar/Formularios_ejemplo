import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() {
    return _ContactFormState();
  }
}

class _ContactFormState extends State<ContactForm> {
  final String title = 'Catalina Melgarejo 24/25';
  final _formKey = GlobalKey<FormBuilderState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> stepTitles = ["Personal", "Contact", "Upload"];
  List<String> pageTitles = ["Personal", "Contact", "Upload"];
  List<String> pageDescriptions = [
    "Pulsi 'Contact' o pulsi el botó de 'Continue'",
    "Pulsi 'Upload' o pulsi el botó de 'Continue'",
    "Pulsi el botó 'End'"
  ];

  // Método que construye las páginas del formulario

  List<Widget> _buildPages() {
    return [
      _buildPageContent(0), // Página 1
      _buildPageContent(1), // Página 2
      _buildContactFormPage(), // Página 3 con formulario de contacto
    ];
  }

  // Método que genera el contenido para las paginas 1 y 2 del wizard

  Widget _buildPageContent(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            pageTitles[index],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8), // Espacio entre el título y la descripción
          Text(
            pageDescriptions[index],
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  // Método para construcción del formulario de la pagina 3

  Widget _buildContactFormPage() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          _buildTextField(
            icon: Icons.email,
            hintText: "Email",
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            icon: Icons.home,
            hintText: "Address",
          ),
          const SizedBox(height: 16),
          _buildTextField(
            icon: Icons.phone,
            hintText: "Mobile No",
          ),
        ],
      ),
    );
  }

  // Método para crear los campos de texto con icono

  Widget _buildTextField({required IconData icon, required String hintText}) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.purple),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.purple[200]),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.purple[100]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.purple),
        ),
        filled: true,
        fillColor: Colors.purple[50],
      ),
    );
  }

  // Métodos de navegación entre páginas

  void _nextPage(){
    if(_currentPage < 2){
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _goToPage(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
    });
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  // Método para informar que los datos se han guardado bien
  void _showDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Center(
          child: Text(
            "Los datos se han guardado correctamente.",
            style: TextStyle(color: Colors.white), // Color del texto
            textAlign: TextAlign.center, // Centrar el texto
          ),
        ),
        backgroundColor: Colors.green, // Cambia esto al color de fondo que prefieras
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating, // Hace que el SnackBar sea flotante
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
        ),
      ),
    );
  }

  // Generador de iconos de pasos
  Widget _buildStepIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GestureDetector(
            onTap: () => _goToPage(index),
            child: Row (
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: _currentPage == index ? Colors.purple : Colors.grey,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8), // Espacio entre el círculo y el texto
                Text(
                  stepTitles[index],
                  style: TextStyle(
                    color: _currentPage == index ? Colors.black : Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
              title,
              style: const TextStyle(color: Colors.white)
          ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _buildStepIcons(),
          ),
          const Divider(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index){
                setState(() {
                  _currentPage = index;
                });
              },
              children: _buildPages(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _currentPage == 0 ? null : _previousPage,
                    child: const Text("Cancel"),
                ),
                ElevatedButton(
                    onPressed: _currentPage == 2 ? (){_showDialog(context);}: _nextPage,
                    child: const Text("Continue"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
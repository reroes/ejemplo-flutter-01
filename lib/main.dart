import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Formulario';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombres = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController observacion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: nombres,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese un valor para nombres';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
            decoration: InputDecoration(
              hintText: 'Ángel',
              labelText: 'Nombres',
            ),
          ),
          TextFormField(
            controller: apellidos,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese un valor para apellidos';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
            decoration: InputDecoration(
              hintText: 'Carrión',
              labelText: 'Apellidos',
            ),
          ),
          TextFormField(
            controller: email,
            // The validator receives the text that the user has entered.
            validator: (value) => EmailValidator.validate(value)
                ? null
                : "Please enter a valid email",

            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
            decoration: InputDecoration(
              hintText: 'foo@example.com',
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: observacion,
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
            ),
            decoration: InputDecoration(
              hintText: 'indique sus observaciones',
              labelText: 'Observaciones',
            ),
            maxLines: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate() == true) {
                  _sendDataToSecondScreen(context);
                }
              },
              child: Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    String textNombres = nombres.text;
    String textApellidos = apellidos.text;
    String textEmail = email.text;
    String textObservacion = observacion.text;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
              name: textNombres,
              lastname: textApellidos,
              email: textEmail,
              observacion: textObservacion),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  final String name;
  final String lastname;
  final String email;
  final String observacion;

  // receive data from the FirstScreen as a parameter
  SecondScreen({
    Key key,
    @required this.name,
    @required this.lastname,
    @required this.email,
    @required this.observacion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Página 2')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Datos resumen",
          style: TextStyle(fontSize: 24, color: Colors.blue),
        ),
        Text(
          name,
          style: TextStyle(fontSize: 24),
        ),
        Text(
          lastname,
          style: TextStyle(fontSize: 24),
        ),
        Text(
          email,
          style: TextStyle(fontSize: 24),
        ),
        Text(
          observacion,
          style: TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}

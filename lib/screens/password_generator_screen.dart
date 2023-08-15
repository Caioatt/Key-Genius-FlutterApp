import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/models/password_settings.dart';
import '/screens/password_configuration_screen.dart';
import 'dart:math';
import '/screens/colors.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  bool _useNumbers = true;
  bool _useSpecialCharacters = true;
  int _passwordLength = 10;
  String _generatedPassword = '';

  void _generatePassword() {
    String characters = 'abcdefghijklmnopqrstuvwxyz';
    if (_useNumbers) characters += '0123456789';
    if (_useSpecialCharacters) characters += '!@#\$%^&*()-_=+[]{}|;:,.<>?';

    String generatedPassword = '';
    Random random = Random();

    for (int i = 0; i < _passwordLength; i++) {
      int index = random.nextInt(characters.length);
      generatedPassword += characters[index];
    }

    setState(() {
      _generatedPassword = generatedPassword;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedPassword));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Senha copiada para a área de transferência')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text('Key Genius'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Senha gerada:',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "roboto",
                ),
              ),
              SizedBox(height: 20),
              Text(
                _generatedPassword,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _copyToClipboard,
                child: Text('Copiar senha'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  minimumSize: Size(150, 40),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  minimumSize: Size(150, 40),
                ),
                onPressed: () {
                  _generatePassword();
                },
                child: Text('Gerar nova Senha'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final newSettings = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PasswordConfigurationScreen(
                  useNumbers: _useNumbers,
                  useSpecialCharacters: _useSpecialCharacters,
                  passwordLength: _passwordLength,
                ),
              ),
            );

            if (newSettings != null) {
              setState(() {
                _useNumbers = newSettings['useNumbers'];
                _useSpecialCharacters = newSettings['useSpecialCharacters'];
                _passwordLength = newSettings['passwordLength'];
                _generatedPassword = '';
              });
              _generatePassword();
            }
          },
          label: Text(
            'Configurar senha',
            style: TextStyle(
              fontFamily: 'roboto',
              fontSize: 17,
            ),
          ),
          icon: Icon(Icons.settings),
          backgroundColor: AppColors.primaryColor),
    );
  }
}

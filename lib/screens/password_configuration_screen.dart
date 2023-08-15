import 'package:flutter/material.dart';
import '/models/password_settings.dart';
import '/screens/colors.dart';

class PasswordConfigurationScreen extends StatefulWidget {
  final bool useNumbers;
  final bool useSpecialCharacters;
  final int passwordLength;

  PasswordConfigurationScreen({
    required this.useNumbers,
    required this.useSpecialCharacters,
    required this.passwordLength,
  });

  @override
  _PasswordConfigurationScreenState createState() =>
      _PasswordConfigurationScreenState();
}

class _PasswordConfigurationScreenState
    extends State<PasswordConfigurationScreen> {
  bool _currentUseNumbers = true;
  bool _currentUseSpecialCharacters = true;
  int _currentPasswordLength = 10;

  @override
  void initState() {
    super.initState();
    _currentUseNumbers = widget.useNumbers;
    _currentUseSpecialCharacters = widget.useSpecialCharacters;
    _currentPasswordLength = widget.passwordLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: AppColors.primaryColor,
        title: Text('Configure sua  senha'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selecione a quantidade de caracteres:',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'roboto',
                fontWeight: FontWeight.normal,
              ),
            ),
            Slider(
              value: _currentPasswordLength.toDouble(),
              min: 6,
              max: 18,
              divisions: 13,
              activeColor: AppColors.primaryColor,
              label: _currentPasswordLength.toString(),
              onChanged: (value) {
                setState(() {
                  _currentPasswordLength = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Incluir números:',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Switch(
                  activeColor: AppColors.primaryColor,
                  value: _currentUseNumbers,
                  onChanged: (value) {
                    setState(() {
                      _currentUseNumbers = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Incluir caracteres especiais:',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Switch(
                  activeColor: AppColors.primaryColor,
                  value: _currentUseSpecialCharacters,
                  onChanged: (value) {
                    setState(() {
                      _currentUseSpecialCharacters = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
              ),
              onPressed: () {
                // Retorna as configurações selecionadas de volta para a tela principal.
                Navigator.pop(
                  context,
                  {
                    'useNumbers': _currentUseNumbers,
                    'useSpecialCharacters': _currentUseSpecialCharacters,
                    'passwordLength': _currentPasswordLength,
                  },
                );
              },
              child: Text(
                'Aplicar Configuração',
                style: TextStyle(
                  fontSize: 17.5,
                  fontFamily: 'roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

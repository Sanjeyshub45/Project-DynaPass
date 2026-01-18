import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const PasswordGeneratorApp());
}

class PasswordGeneratorApp extends StatelessWidget {
  const PasswordGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PasswordGenerator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String _generatedPassword = '';
  int _passwordLength = 12;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _generatePassword();
  }

  void _generatePassword() {
    String chars = '';

    if (_includeUppercase) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (_includeLowercase) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (_includeNumbers) chars += '0123456789';
    if (_includeSymbols) chars += '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    if (chars.isEmpty) {
      setState(() {
        _generatedPassword = 'Select at least one option';
      });
      return;
    }

    String password = '';
    for (int i = 0; i < _passwordLength; i++) {
      password += chars[_random.nextInt(chars.length)];
    }

    setState(() {
      _generatedPassword = password;
    });
  }

  void _copyToClipboard() {
    if (_generatedPassword.isNotEmpty &&
        _generatedPassword != 'Select at least one option') {
      Clipboard.setData(ClipboardData(text: _generatedPassword));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Password Generator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Password Display Card
            Card(
              color: Colors.grey[800],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Generated Password',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            _generatedPassword,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.blue),
                          onPressed: _copyToClipboard,
                          tooltip: 'Copy password',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Password Length Slider
            Card(
              color: Colors.grey[800],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Length',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$_passwordLength',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _passwordLength.toDouble(),
                      min: 4,
                      max: 32,
                      divisions: 28,
                      label: _passwordLength.toString(),
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey[600],
                      onChanged: (double value) {
                        setState(() {
                          _passwordLength = value.toInt();
                        });
                        _generatePassword();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Options Card
            Card(
              color: Colors.grey[800],
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Include',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildOptionSwitch('Uppercase (A-Z)', _includeUppercase, (
                      value,
                    ) {
                      setState(() {
                        _includeUppercase = value;
                      });
                      _generatePassword();
                    }),
                    const SizedBox(height: 12),
                    _buildOptionSwitch('Lowercase (a-z)', _includeLowercase, (
                      value,
                    ) {
                      setState(() {
                        _includeLowercase = value;
                      });
                      _generatePassword();
                    }),
                    const SizedBox(height: 12),
                    _buildOptionSwitch('Numbers (0-9)', _includeNumbers, (
                      value,
                    ) {
                      setState(() {
                        _includeNumbers = value;
                      });
                      _generatePassword();
                    }),
                    const SizedBox(height: 12),
                    _buildOptionSwitch('Symbols (!@#...)', _includeSymbols, (
                      value,
                    ) {
                      setState(() {
                        _includeSymbols = value;
                      });
                      _generatePassword();
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Generate Button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _generatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Generate New Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionSwitch(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        Switch(value: value, onChanged: onChanged, activeColor: Colors.blue),
      ],
    );
  }
}

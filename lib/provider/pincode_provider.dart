import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class PinCodeProvider with ChangeNotifier {
  String _enteredPin = '';
  bool _isPinVisible = false;
  bool _isCompleted = false;
  bool _isValid = true;
  EmailAuth _emailAuth = EmailAuth(sessionName: "Password Recovery");
  String _email = '';


  String get enteredPin => _enteredPin;
  bool get isPinVisible => _isPinVisible;
  bool get isCompleted => _isCompleted;
  EmailAuth get emailAuthInstance => _emailAuth;
  String get email => _email;
  bool get isValid => _isValid;

  void addDigit(int digit) {
    if (_enteredPin.length < 4) {
      _enteredPin += digit.toString();
      if (_enteredPin.length == 4) {
        if (isValidPin(_enteredPin)) {
          print('true');
          _isCompleted = true;
        } else {
          // Handle invalid pin case
          print('false');
          _isValid = false;
          _enteredPin = '';
          print('rebuilding');
          notifyListeners();
          return;
        }
      }
      notifyListeners();
    }
  }


  bool isValidPin(String pin) {
    print('Validating pin: $pin');
    print('Email for validation: $_email');
    return _emailAuth.validateOtp(
      recipientMail: _email,
      userOtp: pin,
    );
  }

  void removeLastDigit() {
    if (_enteredPin.isNotEmpty) {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      notifyListeners();
    }
  }

  void togglePinVisibility() {
    _isPinVisible = !_isPinVisible;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    print('Email set to: $_email');
  }

  void setEmailAuth(EmailAuth emailAuthInstance) {
    _emailAuth = emailAuthInstance;
    notifyListeners();
  }

  void resetPin() {
    _enteredPin = '';
    notifyListeners();
  }
}
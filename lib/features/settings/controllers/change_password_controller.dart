import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/widgets/app_loading.dart';

class ChangePasswordController with ChangeNotifier {
  bool _isConfirmed = false;
  String _newPassword = '';

  bool get isConfirmed => _isConfirmed;
  String get newPassword => _newPassword;

  // Kriteria Validasi Password
  bool get hasMinLength => _newPassword.length >= 8;
  bool get hasUpperLower =>
      _newPassword.contains(RegExp(r'[a-z]')) &&
      _newPassword.contains(RegExp(r'[A-Z]'));
  bool get hasDigit => _newPassword.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar =>
      _newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  // Menghitung skor kekuatan password (0 - 4)
  int get passwordScore {
    int score = 0;
    if (hasMinLength) score++;
    if (hasUpperLower) score++;
    if (hasDigit) score++;
    if (hasSpecialChar) score++;
    return score;
  }

  // Kontrol apakah tombol update dapat ditekkan atau tidak
  bool get canUpdate => _isConfirmed && passwordScore >= 3;

  void setConfirmed(bool value) {
    _isConfirmed = value;
    notifyListeners();
  }

  void setNewPassword(String value) {
    _newPassword = value;
    notifyListeners();
  }

  Future<bool> updatePassword(BuildContext context) async {
    AppLoading.show(context, message: 'Updating your password...');
    
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      AppLoading.hide(context);
      return true;
    }
    return false;
  }
}

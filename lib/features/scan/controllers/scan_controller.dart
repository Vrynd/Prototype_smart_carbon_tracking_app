import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:smart_carbon_tracking/core/themes/app_theme.dart';

class ScanController extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;

  bool _isPicking = false;
  bool get isPicking => _isPicking;

  static const int _maxSizeInBytes = 5 * 1024 * 1024; // 5 MB
  static const List<String> _allowedExtensions = ['.png', '.jpg', '.jpeg'];

  Future<void> pickImageFromGallery(BuildContext context) async {
    if (_isPicking) return;

    _isPicking = true;
    notifyListeners();

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        _isPicking = false;
        notifyListeners();
        return;
      }

      final String extension = p.extension(image.path).toLowerCase();
      final File file = File(image.path);
      final int fileSize = await file.length();

      // 1. Validate Extension
      if (!_allowedExtensions.contains(extension)) {
        if (context.mounted) {
          _showError(
            context,
            'Invalid format! Only JPG, JPEG, or PNG are allowed.',
          );
        }
        _isPicking = false;
        notifyListeners();
        return;
      }

      // 2. Validate Size
      if (fileSize > _maxSizeInBytes) {
        if (context.mounted) {
          _showError(context, 'File too large! Maximum size is 5MB.');
        }
        _isPicking = false;
        notifyListeners();
        return;
      }

      // 3. Success
      _pickedFile = image;
      if (context.mounted) {
        _showSuccess(context, 'Receipt picked: ${p.basename(image.path)}');
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, 'Failed to pick image: $e');
      }
    } finally {
      _isPicking = false;
      notifyListeners();
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.colors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void clearPickedFile() {
    _pickedFile = null;
    notifyListeners();
  }
}

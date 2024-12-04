import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

Future<void> downloadPdf(BuildContext context) async {
  try {
    // Load the PDF from assets
    final byteData = await rootBundle.load('asset/muralidharanresume.pdf');

    // Open file picker to choose save location
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Resume PDF',
      fileName: 'Muralidharan_Resume.pdf',
    );

    // If user selects a location
    if (outputFile != null) {
      final file = File(outputFile);

      // Write the file
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resume downloaded to $outputFile')),
      );
    }
  } catch (e) {
    // Handle any errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to download resume: $e')),
    );
    print('Download error: $e');
  }
}

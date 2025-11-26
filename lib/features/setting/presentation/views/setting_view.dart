import 'dart:async';

import 'package:easacc_app/core/utils/router/app_routes.dart';
import 'package:easacc_app/core/utils/ui/app_bar.dart';
import 'package:easacc_app/core/utils/ui/custom_text_field.dart';
import 'package:easacc_app/core/utils/ui/show_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final TextEditingController _urlController = TextEditingController();
  String? selectedPrinter;
  List<String> printers = [];
  bool isScanning = false;
  StreamSubscription? _scanSub;

  @override
  void initState() {
    super.initState();
    _loadSavedUrl();
    _requestPermissionsAndScan();
  }

  Future<void> _loadSavedUrl() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedUrl = prefs.getString('website_url');
    if (savedUrl != null) {
      _urlController.text = savedUrl;
    }
  }

  Future<void> _saveUrl() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('website_url', _urlController.text.trim());
    showSnakBar(context, "تم حفظ الرابط بنجاح");
  }

  Future<void> _requestPermissionsAndScan() async {
    if (!mounted) return;
    setState(() {
      isScanning = true;
      selectedPrinter = null;
      printers.clear();
    });

    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    _scanSub = FlutterBluePlus.scanResults.listen((results) {
      if (!mounted) return;
      for (ScanResult r in results) {
        if (r.device.name.isNotEmpty && !printers.contains(r.device.name)) {
          setState(() {
            printers.add(r.device.name);
          });
        }
      }
    });

    // أمثلة طابعات واي فاي
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() {
      if (printers.isEmpty) {
        printers.addAll([
          "HP LaserJet Pro M404",
          "Brother HL-L2350DW",
          "Epson L3150 WiFi",
        ]);
      }
      isScanning = false;
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    _scanSub?.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings", isLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Website URL",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Enter website URL here",
              prefixIcon: Icon(Icons.link),
              controller: _urlController,
              keyboardType: TextInputType.url,
            ),

            const SizedBox(height: 10),
            ElevatedButton(onPressed: _saveUrl, child: const Text("save")),
            const SizedBox(height: 30),
            const Text(
              "Available Printers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(
                    printers.isEmpty
                        ? "No printers available"
                        : "Select Printer",
                  ),
                  value: printers.contains(selectedPrinter)
                      ? selectedPrinter
                      : null,
                  items: printers
                      .map(
                        (printer) => DropdownMenuItem(
                          value: printer,
                          child: Text(printer),
                        ),
                      )
                      .toList(),
                  onChanged: printers.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            selectedPrinter = value;
                          });
                        },
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: isScanning ? null : _requestPermissionsAndScan,
              icon: isScanning
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              label: Text(isScanning ? "Scanning..." : "Refresh Printer List"),
            ),
            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _urlController.text.trim().isEmpty
                  ? null
                  : () {
                      context.go(AppRoutes.kLinkView);
                    },
              child: const Text(
                "Open Website",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

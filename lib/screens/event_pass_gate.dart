import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart' as ml;
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/services.dart';
import 'package:sentinova/screens/qr_scanner_screen.dart';

import 'package:get/get.dart';

import '../components/key_input_field.dart';
import '../components/qr_cards.dart';
import '../services/apiservice.dart';
import 'dashboard.dart';



class EventPasswordGate extends StatefulWidget {
  //final Event event;

  const EventPasswordGate({super.key});

  @override
  State<EventPasswordGate> createState() => _EventPasswordGateState();
}

class _EventPasswordGateState extends State<EventPasswordGate> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isScanning = false;

  void _checkPassword(String input) async {
    if (input.trim().isNotEmpty) {
      final data = await ApiService.fetchEvents();
      if (data!.events.isEmpty)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect password')),
          );
          return;
        }
      bool matched = false;
      for(final event in data!.events)
        {
          if(event.location?.toLowerCase() == input.toLowerCase())
            {
              matched = true;
              Get.to(()=>Dashboard(event: event));
            }
        }
      if(!matched)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect password')),
          );
        }
      print("PASSED");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect password')),
      );
    }
  }

  void _startScanQR() async {
    setState(() {
      isScanning = true;
    });

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QRScannerScreen(onScan: (result) {
        print("Check Pass $result");
        Navigator.pop(context);
        _checkPassword(result);
      })),
    );

    setState(() {
      isScanning = false;
    });
  }

  void _uploadQR() async {
    XFile? image =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null)
      return;
    final inputImage = ml.InputImage.fromFilePath(image.path);
    final List<ml.BarcodeFormat> formats = [ml.BarcodeFormat.all];
    final barcodeScanner = ml.BarcodeScanner(formats: formats);
    final List<ml.Barcode> barcodes = await barcodeScanner.processImage(inputImage);

    if(barcodes.isEmpty || barcodes == null)
      return;
    final barcode = barcodes[0];
    final String? rawValue = barcode.rawValue;
    print(barcode.rawValue);
    _checkPassword(rawValue!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Enter Password")),
      body: Container(
        decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.2, -0.5),
                radius: 1.5,
                colors: const [
                  Color(0xFF190B34),
                  Color(0xFF0A0A0E),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icon2.png",
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(height: 20,),
                  Container(height: 0.5,width: 150,color: Colors.white,),
                  SizedBox(height: 0,),
                  Text(
                    "SENTINOVA",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 12.0,
                          color: Colors.white.withOpacity(0.7),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
              
                  Text(
                    "YOUR ALL IN ONE EVENT COMPANION",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 12.0,
                          color: Colors.white.withOpacity(0.7),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35,),
              
              
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      QRCard(icon: Icons.qr_code_scanner_rounded, label: "SCAN QR", onTap: _startScanQR),
                      QRCard(icon: Icons.image_outlined, label: "UPLOAD QR", onTap: _uploadQR)
                    ],
                  ),
              
                  SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 1,width: 55,color: Colors.white,),
                      Text(
                        "   OR   ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 12.0,
                              color: Colors.white.withOpacity(0.7),
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 1,width: 55,color: Colors.white,),
              
                    ],
                  ),
                  SizedBox(height: 20,),

                  KeyInputField(controller: _passwordController, onSubmit: () {  _checkPassword(_passwordController.text);},)
                ],
              ),
            ),
          )




          /*Column(
            children: [
              const Text("Enter event password to continue", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: _checkPassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _checkPassword(_passwordController.text),
                icon: const Icon(Icons.lock_open),
                label: const Text("Unlock"),
              ),
              const SizedBox(height: 10),
              const Text("or"),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _startScanQR,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Scan QR Code"),
              ),
            ],
          ),*/
        ),
      ),
    );
  }
}

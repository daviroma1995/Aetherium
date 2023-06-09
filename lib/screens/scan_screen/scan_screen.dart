import 'dart:developer';

import 'package:atherium_saloon_app/models/membership.dart';
import 'package:atherium_saloon_app/screens/client_details_screen/client_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../models/client.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      final clientUID = scanData.code;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('clients')
          .where('user_id', isEqualTo: clientUID)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        late Client client;
        final clientData = querySnapshot.docs.first.data();
        clientData['id'] = clientData['user_id'];
        client = Client.fromJson(clientData);
        var data = await FirebaseFirestore.instance
            .collection('appointments')
            .where('client_id', isEqualTo: client.id)
            .orderBy('date_timestamp', descending: true)
            .get();
        var docs = data.docs;
        if (docs.isEmpty) {
          log('Data not found');
        }

        var docData = docs[0].data();
        var id = docs[0].id;
        await FirebaseFirestore.instance
            .collection('appointments')
            .doc(id)
            .update({'status_id': '88aa7cf3-c6b6-4cab-91eb-247aa6445a05'}).then(
                (value) async {
          var data = await FirebaseFirestore.instance
              .collection('client_memberships')
              .doc(client.id)
              .get();
          var docData = data.data();
          Membership membership = Membership.fromJson(docData!);
          membership.points = membership.points! + 25;
          await FirebaseFirestore.instance
              .collection('client_memberships')
              .doc(client.id)
              .set(membership.toJson());
          Fluttertoast.showToast(msg: 'Appointmetn updated Successfully');
          Get.back();
        });
        // Send the clientData to another function to handle the data
        // Get.to(() => ClientDetailsScreen(client: client),
        //     arguments: client.userId,
        //     duration: const Duration(milliseconds: 300),
        //     transition: Transition.downToUp);
        // Do something with the client data
      } else {
        print('Client not found');
      }
      controller.resumeCamera();
    });
  }
}

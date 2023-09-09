import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/models/membership.dart';
import 'package:atherium_saloon_app/models/membership_type.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LoyalityCardController extends GetxController {
  RxBool isLoading = true.obs;
  String uid = FirebaseServices.cuid;
  late Membership? clientMembership;
  late MembershipType? membershipType;
  late Client client;
  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    var clientQuery =
        await FirebaseFirestore.instance.collection('clients').doc(uid).get();
    var clientDoc = clientQuery.data();
    client = Client.fromJson(clientDoc!);
    var data = await FirebaseFirestore.instance
        .collection('client_memberships')
        .doc(uid)
        .get();
    var document = data.data();
    document!['id'] = data.id;
    clientMembership = Membership.fromJson(document);
    isLoading.value = false;
    var membershiptypeData = await FirebaseFirestore.instance
        .collection('membership_type')
        .doc(clientMembership!.membershipTypeId)
        .get();
    var membershipDocument = membershiptypeData.data();
    membershipType = MembershipType.fromJson(membershipDocument!);
    isLoading.value = false;
  }
}

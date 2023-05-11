import 'package:atherium_saloon_app/models/membership.dart';
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:get/get.dart';

import '../../models/membership_type.dart';

class ClientDetailsController extends GetxController {
  var clientMembership = Membership().obs;
  var membershipType = MembershipType().obs;
  RxBool loading = true.obs;
  var args = Get.arguments;
  @override
  void onInit() async {
    var data = await FirebaseServices.getDataWhere(
        collection: 'client_memberships', key: 'client_id', value: args);
    clientMembership.value = Membership.fromJson(data!);
    var membershipData = await FirebaseServices.getDataWhere(
        collection: 'membership_type',
        key: 'id',
        value: clientMembership.value.membershipTypeId!);
    membershipType.value = MembershipType.fromJson(membershipData!);
    print(data);
    loading.value = false;
    super.onInit();
  }

  void handleBack() {
    Get.back();
  }
}

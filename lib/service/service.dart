import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class Service {
  makingPhoneCall(String phone) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phone);
  }
}

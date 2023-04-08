import 'package:contacts/models/contact_model.dart';
import 'package:contacts/service/localDb/local_db.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getcontactsProvider = FutureProvider.autoDispose((ref) async {
  return LocalDB().getallContact();
});
final addContactProvider =
    FutureProvider.autoDispose.family<dynamic, Contact>((ref, contact) {
  return LocalDB().addContact(contact);
});

final deleteProvider =
    FutureProvider.autoDispose.family<dynamic, int>((ref, id) {
  return LocalDB().deleteContact(id);
});
final updateContactProvider =
    FutureProvider.autoDispose.family<dynamic, Contact>((ref, contact) {
  return LocalDB().updateContact(contact);
});

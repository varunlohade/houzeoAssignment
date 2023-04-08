import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/style/custom_color.dart';
import '../../../models/contact_model.dart';
import '../../../service/localDb/providers_local.dart';

class DetailContact extends ConsumerStatefulWidget {
  final Contact contact;

  const DetailContact({super.key, required this.contact});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailContactState();
}

class _DetailContactState extends ConsumerState<DetailContact> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor:
                              const Color.fromARGB(255, 35, 39, 49),
                          child: SizedBox(
                            height: 150,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Do you want to delete ${widget.contact.contactName} from your contact?",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          context.pop(context);
                                        },
                                        child: const Text('Close'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref.watch(deleteProvider(
                                              widget.contact.id));
                                          ref.invalidate(getcontactsProvider);
                                          context.pop();
                                          context.pop();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: const Icon(Icons.delete_forever_outlined)),
            const SizedBox(
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  Contact contact = widget.contact;
                  context.push('/addContact', extra: contact);
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50,
                  child: Text(
                    widget.contact.contactName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.contact.contactName,
                  style: const TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Company name:",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    " ${widget.contact.companyName}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Email:",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    " ${widget.contact.emailAddress}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Phone number",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    " ${widget.contact.phoneNumber}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

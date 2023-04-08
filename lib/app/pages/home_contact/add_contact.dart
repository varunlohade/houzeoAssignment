import 'dart:math';

import 'package:contacts/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/style/custom_color.dart';
import '../../../service/localDb/providers_local.dart';

class AddContact extends ConsumerStatefulWidget {
  final Contact? contact;
  const AddContact({super.key, required this.contact});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddContactState();
}

class _AddContactState extends ConsumerState<AddContact> {
  final _formKey = GlobalKey<FormState>();
  Contact? editcontacts;
  var rng = Random();
  TextEditingController _name = TextEditingController();
  TextEditingController _sirname = TextEditingController();
  TextEditingController _companyname = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _emailAddress = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editcontacts = widget.contact;
    _name.text = widget.contact != null ? widget.contact!.contactName : "";
    _sirname.text =
        widget.contact != null ? widget.contact!.contactSirName : "";
    _companyname.text =
        widget.contact != null ? widget.contact!.contactName : "";
    _phoneNumber.text =
        widget.contact != null ? widget.contact!.phoneNumber : "";
    _emailAddress.text =
        widget.contact != null ? widget.contact!.emailAddress : "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (widget.contact == null) {
                    if (_formKey.currentState!.validate()) {
                      var id = rng.nextInt(6);
                      ref.watch(addContactProvider(Contact(
                          id: id,
                          contactName: _name.text,
                          contactSirName: _sirname.text,
                          companyName: _companyname.text,
                          phoneNumber: _phoneNumber.text,
                          emailAddress: _emailAddress.text)));

                      ref.invalidate(getcontactsProvider);

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Contact added')));
                      context.pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Add all the details')));
                    }
                  } else {
                    ref.watch(updateContactProvider(Contact(
                        id: widget.contact!.id,
                        contactName: _name.text,
                        contactSirName: _sirname.text,
                        companyName: _companyname.text,
                        phoneNumber: _phoneNumber.text,
                        emailAddress: _emailAddress.text)));
                    ref.invalidate(getcontactsProvider);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Edited')));
                    context.pop();
                  }
                },
                child: Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: const Center(
                      child: Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  )),
                ),
              ),
            )
          ],
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: widget.contact != null
              ? const Text("Edit contact")
              : const Text("Create contact"),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            onChanged: () {
              Form.of(primaryFocus!.context!).save();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _name,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "name",
                      hintStyle: TextStyle(color: Colors.white38),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: _sirname,
                    decoration: const InputDecoration(
                      hintText: "Sirname",
                      hintStyle: TextStyle(color: Colors.white38),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: _companyname,
                    decoration: const InputDecoration(
                      hintText: "Company name",
                      hintStyle: TextStyle(color: Colors.white38),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: _phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Phone number",
                      hintStyle: TextStyle(color: Colors.white38),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: _emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.white38),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

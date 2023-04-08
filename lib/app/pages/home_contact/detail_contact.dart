import 'package:flutter/material.dart';

import '../../../models/contact_model.dart';

class DetailContact extends StatefulWidget {
  final Contact contact;
  const DetailContact({super.key, required this.contact});

  @override
  State<DetailContact> createState() => _DetailContactState();
}

class _DetailContactState extends State<DetailContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [],
      ),
    );
  }
}

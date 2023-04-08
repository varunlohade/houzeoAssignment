import 'package:contacts/constants/style/custom_color.dart';
import 'package:contacts/service/service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../models/contact_model.dart';
import '../../../service/localDb/providers_local.dart';
import 'dart:math';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
// }

class HomeScreen extends HookConsumerWidget {
  var rng = Random();
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _searchList = useState<List<Contact>>([]);

    final allContact = ref.watch(getcontactsProvider);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
              elevation: 0,
              iconSize: 26,
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color.fromARGB(255, 172, 165, 165),
              backgroundColor: const Color.fromARGB(255, 35, 39, 49),
              items: const [
                BottomNavigationBarItem(
                    label: 'contacts', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'highlight',
                    icon: Icon(Icons.highlight_alt_outlined)),
                BottomNavigationBarItem(
                    label: 'Settings', icon: Icon(Icons.settings_sharp))
              ]),
        ),
        floatingActionButton: SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: const Color(0xff30447c),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              context.push('/addContact');
            },
            child: const Icon(Icons.add),
          ),
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 35, 39, 49)),
                child: TextField(
                  onChanged: (val) {},
                  controller: _search,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.more_vert_rounded,
                      color: Color.fromARGB(255, 211, 203, 203),
                    ),
                    prefixIcon: Icon(
                      Icons.menu,
                      color: Color.fromARGB(255, 211, 203, 203),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 170, 163, 163)),
                    hintText: "Search Contacts",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            color: Color.fromARGB(173, 189, 179, 179))),
                    padding: const EdgeInsets.all(1),
                    backgroundColor: CustomColor.backgroundColor,
                    label: SizedBox(
                      width: 105,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.person_2_outlined,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Phone Contacts",
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            color: Color.fromARGB(173, 189, 179, 179))),
                    padding: const EdgeInsets.all(1),
                    backgroundColor: CustomColor.backgroundColor,
                    label: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Email Address",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            color: Color.fromARGB(173, 189, 179, 179))),
                    padding: const EdgeInsets.all(1),
                    backgroundColor: CustomColor.backgroundColor,
                    label: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.apartment_outlined,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Company",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            allContact.when(
                data: (data) {
                  if (data == null || data.isEmpty) {
                    return const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Add contacts ",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            int randomint = rng.nextInt(4);
                            return ListTile(
                              onTap: () {
                                context.push('/detailContact',
                                    extra: data[index]);
                              },
                              onLongPress: () {
                                Service()
                                    .makingPhoneCall(data[index].phoneNumber);
                              },
                              trailing: const Icon(
                                Icons.navigate_next_rounded,
                                color: Colors.white,
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              leading: CircleAvatar(
                                backgroundColor:
                                    CustomColor().randomColor[randomint],
                                radius: 25,
                                child: Text(
                                  data[index]
                                      .contactName
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                              ),
                              title: Text(
                                data[index].contactName,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            );
                          }));
                },
                error: (error, st) {
                  return const Text("Error fetching data Please Restart App");
                },
                loading: () => const CircularProgressIndicator(
                      color: Colors.white,
                    ))
          ],
        ),
      ),
    );
  }
}

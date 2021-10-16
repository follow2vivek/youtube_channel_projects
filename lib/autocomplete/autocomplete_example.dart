import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import './user_model.dart' show Data, UserModel;

class AutocompleteExample extends StatefulWidget {
  const AutocompleteExample({Key? key}) : super(key: key);

  @override
  _AutocompleteExampleState createState() => _AutocompleteExampleState();
}

class _AutocompleteExampleState extends State<AutocompleteExample> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromApi();
  }

  void _getDataFromApi() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    setState(() {
      userModel = UserModel.fromJson(json.decode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Autocomplete<Data>(
          optionsBuilder: (TextEditingValue value) {
            if (value.text.isEmpty) {
              return List.empty();
            }
            return userModel!.data!
                .where((element) => element.firstName!
                    .toLowerCase()
                    .contains(value.text.toLowerCase()))
                .toList();
          },
          fieldViewBuilder: (BuildContext context,
                  TextEditingController controller,
                  FocusNode node,
                  Function onSubmit) =>
              TextField(
            controller: controller,
            focusNode: node,
            decoration: InputDecoration(hintText: 'Type here...'),
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
            ),
          ),
          optionsViewBuilder: (BuildContext context, Function onSelect,
              Iterable<Data> dataList) {
            return Material(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  Data d = dataList.elementAt(index);
                  return InkWell(
                    onTap: ()=> onSelect(d),
                    child: ListTile(
                      title: Text(d.firstName!),
                      leading: Image.network(
                        d.avatar!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            );
          },
          onSelected: (value) => print(value.firstName),
          displayStringForOption: (Data d) => '${d.firstName!} ${d.lastName!}',
        ),
      ),
    );
  }
}

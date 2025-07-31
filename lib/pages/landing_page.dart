import 'package:flutter/material.dart';
import '../widgets/general_widgets/search_text_field.dart';

class InitialSearchPage extends StatefulWidget {
  const InitialSearchPage({super.key});

  @override
  State<InitialSearchPage> createState() => _InitialSearchPageState();
}

class _InitialSearchPageState extends State<InitialSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Set Your Default Location',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: const SearchTextField(),
    );
  }
}

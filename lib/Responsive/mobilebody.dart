import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/config/colors.dart';

class Mobilebody extends StatefulWidget {
  const Mobilebody({super.key});

  @override
  State<Mobilebody> createState() => _MobilebodyState();
}

class _MobilebodyState extends State<Mobilebody> {
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: parchment,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenheight * 0.05),
        child: AppBar(
          backgroundColor: appbar,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: cards,
              height: screenheight * 0.5,
              child: Column(
                children: <Widget>[
                  Text(
                    'Hi I am\nMuralidharan K',
                    style: GoogleFonts.poppins(
                        color: appbar, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

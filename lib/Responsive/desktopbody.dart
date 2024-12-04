import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/Responsive/PDF/resume.dart';

import 'package:portfolio_app/config/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class Desktopbody extends StatefulWidget {
  const Desktopbody({super.key});

  @override
  State<Desktopbody> createState() => _DesktopbodyState();
}

class _DesktopbodyState extends State<Desktopbody>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Timer _timer;
  late AnimationController _animationController;
  List<Node> nodes = [];
  final int numberOfNodes = 15;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    final random = Random();
    for (int i = 0; i < numberOfNodes; i++) {
      nodes.add(Node(
        position: Offset(
          random.nextDouble() * 2 - 1,
          random.nextDouble() * 2 - 1,
        ),
        velocity: Offset(
          (random.nextDouble() - 0.5) * 0.03,
          (random.nextDouble() - 0.5) * 0.03,
        ),
      ));
    }

    _timer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 2,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );

        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        }
      }
    });
  }

  void _updateNodes() {
    for (var node in nodes) {
      node.position += node.velocity * 0.3;

      if (node.position.dx.abs() > 1) {
        node.velocity = Offset(-node.velocity.dx, node.velocity.dy);
      }
      if (node.position.dy.abs() > 1) {
        node.velocity = Offset(node.velocity.dx, -node.velocity.dy);
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaff,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenheight * 0.08),
        child: AppBar(
          backgroundColor: app_bar,
        ),
      ),
      body: Stack(
        children: [
          // Grid Background
          CustomPaint(
            size: Size.infinite,
            painter: GridPainter(),
          ),

          // Animated Nodes
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              _updateNodes();
              return CustomPaint(
                size: Size.infinite,
                painter: NodesPainter(nodes: nodes),
              );
            },
          ),

          SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: screenheight * 0.08,
                  right: screenwidth * 0.10,
                  left: screenwidth * 0.10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi I am\nMuralidharan K',
                              style: GoogleFonts.montserrat(
                                color: linen,
                                fontWeight: FontWeight.bold,
                                fontSize: screenwidth * 0.035,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenheight * 0.01),
                              child: Text(
                                'A Passionate Flutter Developer\nCross platform Application Developer',
                                style: GoogleFonts.raleway(
                                  color: lightGrey1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenwidth * 0.015,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: screenwidth * 0.18),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer glow effect
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: _animationController.value * 2 * pi,
                                    child: Container(
                                      width: screenwidth * 0.015,
                                      height: screenwidth * 0.015,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: SweepGradient(
                                          colors: [
                                            spruce.withOpacity(0.2),
                                          ],
                                          stops: [0.0, 0.3, 0.6, 1.0],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              Container(
                                width: screenwidth * 0.18,
                                height: screenwidth * 0.18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: app_bar,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: app_bar.withOpacity(0.5),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                    BoxShadow(
                                      color: linen.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'images/profile.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenheight * 0.05),
                      child: Row(
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'https://drive.google.com/file/d/1U5hMdcNjCHvkWB3efxc5hO1VLXZYEwda/view?usp=drivesdk');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not Load');
                              }
                            },
                            label: Text(
                              'Resume',
                              style: GoogleFonts.poppins(
                                color: parchment,
                                fontSize: screenwidth * 0.01,
                              ),
                            ),
                            icon: Icon(
                              Icons.download_rounded,
                              color: parchment,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appbar,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  screenheight * 0.01,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenwidth * 0.01),
                          InkWell(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  'https://www.linkedin.com/in/muralidharan-k-46b534258?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app');
                              if (!await launchUrl(url)) {
                                throw Exception("Could not open Link");
                              }
                            },
                            child: Image.asset(
                              'images/linkedin.png',
                              width: screenwidth * 0.035,
                              height: screenwidth * 0.035,
                            ),
                          ),
                          SizedBox(width: screenwidth * 0.01),
                          InkWell(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  'https://leetcode.com/u/muralidharank01/');
                              if (!await launchUrl(url)) {
                                throw Exception("Could not open Link");
                              }
                            },
                            child: Image.asset(
                              'images/leetcode.png',
                              width: screenwidth * 0.03,
                              height: screenwidth * 0.03,
                            ),
                          ),
                          SizedBox(width: screenwidth * 0.01),
                          InkWell(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  'https://github.com/MuralidharanKrishnamoorthy');
                              if (!await launchUrl(url)) {
                                throw Exception("Could not open Link");
                              }
                            },
                            child: Image.asset(
                              'images/github.png',
                              width: screenwidth * 0.03,
                              height: screenwidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenheight * 0.05),
                    SizedBox(
                      height: screenheight * 0.3,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          final logos = [
                            'images/flutter.png',
                            'images/java.png',
                            'images/firebase.png',
                            'images/nodejs.png',
                            'images/figma.png',
                            'images/MongodB.png',
                            'images/Postman.png'
                          ];
                          final colors = [cards];

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenwidth * 0.01,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    width: screenwidth * 0.12,
                                    height: screenheight * 0.08,
                                    decoration: BoxDecoration(
                                      color: colors[index % colors.length],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: screenwidth * 0.02),
                                    child: Image.asset(
                                      logos[index % logos.length],
                                      width: screenwidth * 0.08,
                                      height: screenheight * 0.08,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: screenheight * 0.08,
                      child: Text(
                        'Projects',
                        style: GoogleFonts.raleway(
                            color: linen,
                            fontSize: screenwidth * 0.019,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Container(
                            width: screenwidth * 0.3,
                            height: screenheight * 0.8,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white.withOpacity(0.03),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.03),
                                width: 0.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                child: Padding(
                                  padding: EdgeInsets.all(screenwidth * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Decentralized Carbon Credit Marketplace',
                                        style: GoogleFonts.raleway(
                                          color: linen,
                                          fontSize: screenwidth * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: screenheight * 0.02),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          'images/DCCM.jpg',
                                          width: double.infinity,
                                          height: screenheight * 0.25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: screenheight * 0.05),
                                      Text(
                                        'Climate change is one of the most pressing global challenges that currently face the world. Carbon credits, which provide the possibility for companies to counterbalance their carbon emissions by financing environmental projects, are a vital move in such a fight.',
                                        style: GoogleFonts.poppins(
                                          color: lightGrey2,
                                          fontSize: screenwidth * 0.01,
                                        ),
                                        maxLines: 7,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                      ),
                                      Spacer(), // This will push the button to the bottom
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          onPressed: () async {
                                            final Uri url = Uri.parse(
                                                'https://github.com/MuralidharanKrishnamoorthy/DCCM.git');
                                            if (!await launchUrl(url)) {
                                              throw Exception(
                                                  'Could not load project');
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenwidth * 0.015,
                                              vertical: screenheight * 0.01,
                                            ),
                                          ),
                                          child: Text(
                                            'View Project',
                                            style: GoogleFonts.poppins(
                                              color: linen,
                                              fontSize: screenwidth * 0.01,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenwidth * 0.15),
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Container(
                              width: screenwidth * 0.3,
                              height: screenheight * 0.8,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white.withOpacity(0.03),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.03),
                                  width: 0.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                  child: Padding(
                                    padding: EdgeInsets.all(screenwidth * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'TurfMaster',
                                          style: GoogleFonts.raleway(
                                            color: linen,
                                            fontSize: screenwidth * 0.015,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenheight * 0.02),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            'images/turf.jpg',
                                            width: double.infinity,
                                            height: screenheight * 0.25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: screenheight * 0.05),
                                        Text(
                                          'TurfMaster is a comprehensive mobile application designed to revolutionize sports venue booking. It provides users with an intuitive platform to seamlessly browse, select, and reserve turf facilities across different locations with real-time availability and instant booking capabilities.',
                                          style: GoogleFonts.poppins(
                                            color: lightGrey2,
                                            fontSize: screenwidth * 0.01,
                                          ),
                                          maxLines: 7,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                        ),
                                        Spacer(), // This will push the button to the bottom
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                            onPressed: () async {
                                              final Uri url = Uri.parse(
                                                  'https://github.com/MuralidharanKrishnamoorthy/TurfMaster.git');
                                              if (!await launchUrl(url)) {
                                                throw Exception(
                                                    'Could not load project');
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: screenwidth * 0.015,
                                                vertical: screenheight * 0.01,
                                              ),
                                            ),
                                            child: Text(
                                              'View Project',
                                              style: GoogleFonts.poppins(
                                                color: linen,
                                                fontSize: screenwidth * 0.01,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenheight * 0.06,
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Container(
                            width: screenwidth * 0.3,
                            height: screenheight * 0.8,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white
                                  .withOpacity(0.03), // Reduced transparency
                              border: Border.all(
                                color: Colors.white
                                    .withOpacity(0.03), // Very subtle border
                                width: 0.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 2, sigmaY: 2), // Reduced blur
                                child: Padding(
                                  padding: EdgeInsets.all(screenwidth * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ChatBot',
                                        style: GoogleFonts.raleway(
                                          color: linen,
                                          fontSize: screenwidth * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: screenheight * 0.02),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          'images/chat.jpg',
                                          width: double.infinity,
                                          height: screenheight * 0.25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: screenheight * 0.05),
                                      Text(
                                        'Developed a highly responsive AI-powered chatbot using Java and integrated with OpenAIs GPT-4 model. The chatbot demonstrates advanced natural language processing (NLP) capabilities, enabling it to engage users in meaningful and human-like conversations.',
                                        style: GoogleFonts.poppins(
                                          color: lightGrey2,
                                          fontSize: screenwidth * 0.01,
                                        ),
                                        maxLines: 7,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                      ),
                                      Spacer(), // This will push the button to the bottom
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          onPressed: () async {
                                            final Uri url = Uri.parse(
                                                'https://github.com/MuralidharanKrishnamoorthy/CHATBOT.git');
                                            if (!await launchUrl(url)) {
                                              throw Exception(
                                                  'Could not load project');
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenwidth * 0.015,
                                              vertical: screenheight * 0.01,
                                            ),
                                          ),
                                          child: Text(
                                            'View Project',
                                            style: GoogleFonts.poppins(
                                              color: linen,
                                              fontSize: screenwidth * 0.01,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenwidth * 0.15),
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Container(
                              width: screenwidth * 0.3,
                              height: screenheight * 0.8,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                                    .withOpacity(0.03), // Reduced transparency
                                border: Border.all(
                                  color: Colors.white
                                      .withOpacity(0.03), // Very subtle border
                                  width: 0.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 2, sigmaY: 2), // Reduced blur
                                  child: Padding(
                                    padding: EdgeInsets.all(screenwidth * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Portfolio',
                                          style: GoogleFonts.raleway(
                                            color: linen,
                                            fontSize: screenwidth * 0.015,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenheight * 0.02),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            'images/portfolio.jpg',
                                            width: double.infinity,
                                            height: screenheight * 0.25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: screenheight * 0.05),
                                        Text(
                                          'With Flutter, I dont just build apps; I craft experiences.',
                                          style: GoogleFonts.poppins(
                                            color: lightGrey2,
                                            fontSize: screenwidth * 0.01,
                                          ),
                                          maxLines: 7,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                        ),
                                        Spacer(), // This will push the button to the bottom
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                            onPressed: () {
                                              // Add your navigation logic here
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: screenwidth * 0.015,
                                                vertical: screenheight * 0.01,
                                              ),
                                            ),
                                            child: Text(
                                              'View Project',
                                              style: GoogleFonts.poppins(
                                                color: linen,
                                                fontSize: screenwidth * 0.01,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Certificates',
                          style: GoogleFonts.raleway(
                              color: linen,
                              fontSize: screenwidth * 0.019,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenheight * 0.05,
                    ),
                    Row(
                      children: [
                        Text(
                          'Dart & Flutter\nThe Complete Flutter Development Course',
                          style: GoogleFonts.raleway(
                              color: lightGrey1, fontSize: screenwidth * 0.012),
                        ),
                        Container(
                          height: 40, // Adjust height as needed
                          width: 1, // Divider thickness
                          color: lightGrey1, // Divider color
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  screenwidth * 0.03), // Optional margin
                        ),
                        Text(
                          'MongoDB with Node JS\nBackend CRUD Performance',
                          style: GoogleFonts.raleway(
                              color: lightGrey1, fontSize: screenwidth * 0.012),
                        ),
                        Container(
                          height: 40, // Adjust height as needed
                          width: 1, // Divider thickness
                          color: lightGrey1, // Divider color
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  screenwidth * 0.03), // Optional margin
                        ),
                        Text(
                          'Node Js & MongoDB\nThe Complete Backend Development Course',
                          style: GoogleFonts.raleway(
                              color: lightGrey1, fontSize: screenwidth * 0.012),
                        ),
                      ],
                    ),
                    Container(
                      height: screenheight * 0.1,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '"If you can imagine it, I can build it—with Flutter"',
                            style: GoogleFonts.raleway(
                                color: linen,
                                fontSize: screenwidth * 0.012,
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: screenheight * 0.08,
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class Node {
  Offset position;
  Offset velocity;

  Node({required this.position, required this.velocity});
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    final cellSize = size.width / 20;

    // Draw vertical lines
    for (var i = 0; i <= size.width; i += cellSize.toInt()) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (var i = 0; i <= size.height; i += cellSize.toInt()) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NodesPainter extends CustomPainter {
  final List<Node> nodes;

  NodesPainter({required this.nodes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepOrange.withOpacity(0.6)
      ..strokeWidth = 1.5;

    List<Offset> screenNodes = nodes
        .map((node) => Offset(
              (node.position.dx + 1) / 2 * size.width,
              (node.position.dy + 1) / 2 * size.height,
            ))
        .toList();

    // Draw connections
    for (int i = 0; i < screenNodes.length; i++) {
      for (int j = i + 1; j < screenNodes.length; j++) {
        final distance = (screenNodes[i] - screenNodes[j]).distance;
        if (distance < size.width * 0.2) {
          final opacity = 1 - (distance / (size.width * 0.2));
          paint.color = Colors.deepOrange.withOpacity(opacity * 0.3);
          canvas.drawLine(screenNodes[i], screenNodes[j], paint);
        }
      }
    }

    // Draw nodes
    paint.color = Colors.deepOrange;
    for (var node in screenNodes) {
      canvas.drawCircle(node, 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

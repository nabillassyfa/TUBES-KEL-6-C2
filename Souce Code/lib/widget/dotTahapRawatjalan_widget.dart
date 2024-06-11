
import 'dart:ui';
import 'package:timelines/timelines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tp2/Fitur/bottomNavBar.dart';
import 'package:tp2/Fitur/denah.dart';
import 'package:tp2/Fitur/pembayaran.dart';
import 'package:tp2/models/jadwalJanjiTemu.dart';
import 'package:tp2/widget/dotTahapRawatjalan_widget.dart';
// import 'beri_review.dart';

const completeColor = Color.fromARGB(255, 108, 108, 108);
const inProgressColor = Color.fromARGB(255, 1, 101, 252);
const todoColor = Colors.grey;

class RawatJalanTimeLine extends StatefulWidget {
  const RawatJalanTimeLine({Key? key, required this.processIndex}) : super(key: key);

  final int processIndex;

  @override
  _RawatJalanTimeLineState createState() => _RawatJalanTimeLineState();
}

class _RawatJalanTimeLineState extends State<RawatJalanTimeLine> {
  int getAdjustedProcessIndex() {
    if (widget.processIndex == 2) {
      return 1;
    
    } else if(widget.processIndex == 3){
      return 2;
    } 
    else if (widget.processIndex == 4) {
      return 3;
    }
    else if (widget.processIndex == 5) {
      return 3;
    }
    else if (widget.processIndex == 6) {
      return 4;
    }
    else {
      return widget.processIndex;
    }
  }

  Color getColor(int index) {
    int adjustedProcessIndex = getAdjustedProcessIndex();
    if (index == adjustedProcessIndex) {
      return inProgressColor;
    } else if (index < adjustedProcessIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int adjustedProcessIndex = getAdjustedProcessIndex();

    return SizedBox(
      height: 100,
      child: Timeline.tileBuilder(
        physics: NeverScrollableScrollPhysics(),
        theme: TimelineThemeData(
          direction: Axis.horizontal, // Atur arah timeline menjadi horizontal
          connectorTheme: ConnectorThemeData(
            space: 20.0, // Spasi antara titik dalam timeline
            thickness: 4.0, // Ketebalan garis connector
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, index) {
            return MediaQuery.of(context).size.width / 5 - 8; // Lebar dikurangi 8
          },
          itemCount: 5,
          contentsBuilder: (context, index) {
            if (adjustedProcessIndex == index) {
              return Column(
                crossAxisAlignment: adjustedProcessIndex == 0
                    ? CrossAxisAlignment.start
                    : (adjustedProcessIndex == 5 - 1
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.center),
                children: [
                  SizedBox(height: 5),
                  Image.asset(
                    "assets/icons/Polygon 2.png",
                    scale: 1.5,
                  ),
                  SizedBox(height: 5),
                ],
              );
            } else {
              return SizedBox.shrink(); // Mengembalikan widget kosong jika proses belum dipilih
            }
          },
          indicatorBuilder: (_, index) {
            Color color;
            if (index == adjustedProcessIndex) {
              color = inProgressColor;
            } else if (index < adjustedProcessIndex) {
              color = completeColor;
            } else {
              color = todoColor;
            }

            if (index <= adjustedProcessIndex) {
              return Stack(
                children: [
                  DotIndicator(
                    size: 24.0,
                    color: color,
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  DotIndicator(
                    size: 20.0,
                    color: color,
                  ),
                ],
              );
            }
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == adjustedProcessIndex) {
                final prevColor = getColor(index - 1);
                final color = getColor(index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)!
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: getColor(index),
                );
              }
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  int? _selectedIndex;
  int? _selectedIndex2;
  ui.Image? _customPImage;
  ui.Image? _customNImage;
  ui.Image? _customCommentImage;
  ui.Image? _customResponseImage;
  ui.Image? _customPositiveAbnormalImage;
  final ScrollController _scrollController = ScrollController();
  double _chartWidth = 1000;

  final List<Map<String, dynamic>> jsonData = [
    {
      "date": "01 Jan",
      "value": 10,
      "refMin": 4,
      "refMax": 20,
      "type": "numeric",
      "status": "normal",
      "institute": "Central Medical Lab"
    },
    {
      "date": "05 Feb",
      "value": 6,
      "refMin": 2,
      "refMax": 12,
      "type": "numeric",
      "status": "normal",
      "institute": "City General Hospital"
    },
    {
      "date": "15 Mar",
      "value": 5,
      "refMin": 3,
      "refMax": 15,
      "type": "numeric",
      "status": "abnormal",
      "institute": "City General Hospital"
    },
    {
      "date": "10 Apr",
      "value": 15,
      "refMin": 10,
      "refMax": 20,
      "type": "numeric",
      "status": "normal",
      "institute": "MedFirst Diagnostics"
    },
    {
      "date": "20 May",
      "value": -5,
      "type": "qualitative",
      "result": "positive",
      "status": "abnormal",
      "institute": "Regional Health Center"
    },
    {
      "date": "12 Jun",
      "value": 9,
      "refMin": 5,
      "refMax": 15,
      "type": "numeric",
      "status": "normal",
      "institute": "Premier Medical Labs"
    },
    {
      "date": "23 Jul",
      "value": -5,
      "type": "qualitative",
      "result": "positive",
      "status": "abnormal",
      "institute": "Regional Health Center"
    },
    {
      "date": "18 Aug",
      "value": 12,
      "refMin": 8,
      "refMax": 18,
      "type": "numeric",
      "status": "normal",
      "institute": "HealthScope Labs"
    },
    {
      "date": "05 Sep",
      "value": 22,
      "refMin": 15,
      "refMax": 25,
      "type": "numeric",
      "status": "abnormal",
      "institute": "HealthScope Labs"
    },
    {
      "date": "30 Oct",
      "value": 7,
      "refMin": 4,
      "refMax": 10,
      "type": "numeric",
      "status": "normal",
      "institute": "City Medical Center"
    },
    {
      "date": "11 Nov",
      "value": -5,
      "type": "qualitative",
      "result": "pending",
      "status": "comment",
      "institute": "Metropolitan Lab Services"
    },
    {
      "date": "25 Dec",
      "value": 14,
      "refMin": 10,
      "refMax": 20,
      "type": "numeric",
      "status": "normal",
      "institute": "Advanced Diagnostic Solutions"
    },
    {
      "date": "09 Jan",
      "value": 18,
      "refMin": 10,
      "refMax": 30,
      "type": "numeric",
      "status": "normal",
      "institute": "MedFirst Diagnostics"
    },
    {
      "date": "10 Feb",
      "value": 8,
      "refMin": 5,
      "refMax": 12,
      "type": "numeric",
      "status": "normal",
      "institute": "City General Hospital"
    },
    {
      "date": "14 Mar",
      "value": -5,
      "type": "qualitative",
      "result": "above_normal",
      "status": "comment",
      "institute": "Premier Medical Labs"
    },
    {
      "date": "17 Apr",
      "value": 13,
      "refMin": 10,
      "refMax": 20,
      "type": "numeric",
      "status": "normal",
      "institute": "HealthScope Labs"
    },
    {
      "date": "23 May",
      "value": 22,
      "refMin": 15,
      "refMax": 30,
      "type": "numeric",
      "status": "abnormal",
      "institute": "City Medical Center"
    },
    {
      "date": "21 Jun",
      "value": -5,
      "type": "qualitative",
      "result": "pending",
      "status": "comment",
      "institute": "Premier Medical Labs"
    },
    {
      "date": "09 Jul",
      "value": 16,
      "refMin": 12,
      "refMax": 22,
      "type": "numeric",
      "status": "normal",
      "institute": "Metropolitan Lab Services"
    },
    {
      "date": "03 Aug",
      "value": 19,
      "refMin": 14,
      "refMax": 25,
      "type": "numeric",
      "status": "normal",
      "institute": "Regional Health Center"
    },
    {
      "date": "12 Sep",
      "value": -5,
      "type": "qualitative",
      "result": "negative",
      "status": "normal",
      "institute": "City General Hospital"
    },
    {
      "date": "28 Oct",
      "value": 24,
      "refMin": 18,
      "refMax": 28,
      "type": "numeric",
      "status": "abnormal",
      "institute": "MedFirst Diagnostics"
    },
    {
      "date": "05 Nov",
      "value": 22,
      "refMin": 15,
      "refMax": 25,
      "type": "numeric",
      "status": "abnormal",
      "institute": "HealthScope Labs"
    },
    {
      "date": "20 Dec",
      "value": 14,
      "refMin": 10,
      "refMax": 20,
      "type": "numeric",
      "status": "normal",
      "institute": "Advanced Diagnostic Solutions"
    },
    {
      "date": "01 Jan",
      "value": 17,
      "refMin": 12,
      "refMax": 22,
      "type": "numeric",
      "status": "normal",
      "institute": "Central Medical Lab"
    },
    {
      "date": "14 Feb",
      "value": 20,
      "refMin": 15,
      "refMax": 28,
      "type": "numeric",
      "status": "normal",
      "institute": "Metropolitan Lab Services"
    },
    {
      "date": "09 Mar",
      "value": 12,
      "refMin": 8,
      "refMax": 18,
      "type": "numeric",
      "status": "normal",
      "institute": "City Medical Center"
    },
    {
      "date": "22 Apr",
      "value": -5,
      "type": "qualitative",
      "result": "positive",
      "status": "abnormal",
      "institute": "Regional Health Center"
    },
    {
      "date": "30 May",
      "value": 21,
      "refMin": 16,
      "refMax": 26,
      "type": "numeric",
      "status": "normal",
      "institute": "Premier Medical Labs"
    },
    {
      "date": "14 Jun",
      "value": 10,
      "refMin": 6,
      "refMax": 15,
      "type": "numeric",
      "status": "normal",
      "institute": "HealthScope Labs"
    },
    {
      "date": "08 Jul",
      "value": 25,
      "refMin": 20,
      "refMax": 30,
      "type": "numeric",
      "status": "abnormal",
      "institute": "MedFirst Diagnostics"
    },
    {
      "date": "30 Aug",
      "value": -5,
      "type": "qualitative",
      "result": "above_normal",
      "status": "comment",
      "institute": "Metropolitan Lab Services"
    },
    {
      "date": "10 Sep",
      "value": 14,
      "refMin": 9,
      "refMax": 18,
      "type": "numeric",
      "status": "normal",
      "institute": "City General Hospital"
    },
    {
      "date": "25 Oct",
      "value": 23,
      "refMin": 18,
      "refMax": 27,
      "type": "numeric",
      "status": "abnormal",
      "institute": "Advanced Diagnostic Solutions"
    },
    {
      "date": "19 Nov",
      "value": 8,
      "refMin": 5,
      "refMax": 12,
      "type": "numeric",
      "status": "normal",
      "institute": "Regional Health Center"
    },
    {
      "date": "12 Dec",
      "value": 6,
      "refMin": 4,
      "refMax": 10,
      "type": "numeric",
      "status": "normal",
      "institute": "Advanced Diagnostic Solutions"
    }
  ];

  ui.Image? getImageForResult(String? result, String? status) {
    final condition = ('$result-$status');
    switch (condition) {
      case 'positive-abnormal':
        return _customPositiveAbnormalImage;
      case 'positive-normal':
        return _customPImage;
      case 'negative-normal':
        return _customNImage;
      case 'negative-abnormal':
        return _customNImage;
      case 'response':
        return _customResponseImage;
      default:
        return _customCommentImage;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCustomImages();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate chart width after initial build
      _calculateChartWidth();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateChartWidth() {
    final newWidth = jsonData.length * 60.0;
    if (newWidth != _chartWidth) {
      setState(() {
        _chartWidth = newWidth;
      });
    }
  }

  Future<void> _loadCustomImages() async {
    final ByteData data = await rootBundle.load('assets/images/negative_abnormal.png');
    final ByteData data2 = await rootBundle.load('assets/images/positive.png');
    final ByteData data3 = await rootBundle.load('assets/images/comment.png');
    final ByteData data4 = await rootBundle.load('assets/images/no_response.png');
    final ByteData data5 = await rootBundle.load('assets/images/positive_abnormal.png');
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.Codec codec2 = await ui.instantiateImageCodec(data2.buffer.asUint8List());
    final ui.Codec codec3 = await ui.instantiateImageCodec(data3.buffer.asUint8List());
    final ui.Codec codec4 = await ui.instantiateImageCodec(data4.buffer.asUint8List());
    final ui.Codec codec5 = await ui.instantiateImageCodec(data5.buffer.asUint8List());
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.FrameInfo frameInfo2 = await codec2.getNextFrame();
    final ui.FrameInfo frameInfo3 = await codec3.getNextFrame();
    final ui.FrameInfo frameInfo4 = await codec4.getNextFrame();
    final ui.FrameInfo frameInfo5 = await codec5.getNextFrame();
    setState(() {
      _customPImage = frameInfo2.image;
      _customNImage = frameInfo.image;
      _customCommentImage = frameInfo3.image;
      _customResponseImage = frameInfo4.image;
      _customPositiveAbnormalImage = frameInfo5.image;
    });
  }

  String _formatDate(String date) {
    final parts = date.split(' ');
    if (parts.length >= 2) {
      return '${parts[1]}\n${parts[0]}';
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {

    final List<int> numericIndices = [];
    final List<FlSpot> numericSpots = [];
    final List<int> qualitativeIndices = [];
    final List<FlSpot> qualitativeSpots = [];

    for (int i = 0; i < jsonData.length; i++) {
      final item = jsonData[i];
      if (item['type'] == 'numeric') {
        numericIndices.add(i);
        numericSpots.add(FlSpot(i.toDouble(), (item['value'] as num).toDouble()));
      } else if (item['type'] == 'qualitative') {
        qualitativeIndices.add(i);
        qualitativeSpots.add(FlSpot(i.toDouble(), (item['value'] as num).toDouble()));
      }
    }

    final yValues = jsonData
        .where((item) => item['type'] == 'numeric')
        .map((item) => (item['value'] as num).toDouble())
        .toList();

    // Get qualitative values (they're all -5 in your data)
    final qualValues = jsonData
        .where((item) => item['type'] == 'qualitative')
        .map((item) => (item['value'] as num).toDouble())
        .toList();

    // Combine all values
    final allValues = [...yValues, ...qualValues];

    // Calculate min and max with padding
    final double minY = (allValues.isNotEmpty ? allValues.reduce((a, b) => a < b ? a : b) : 0);
    final double maxY = (yValues.isNotEmpty ? yValues.reduce((a, b) => a > b ? a : b) : 0) + 5;

    final xLabels = jsonData.map((item) => _formatDate(item['date'])).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Graph Representation'),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border(bottom: BorderSide()),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 19),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Parameter History',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.show_chart,
                          color: Colors.purple,
                        ),
                      ),
                      Icon(Icons.menu),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '6 Months',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade500),
                  ),
                  Text(
                    '1 Year',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade500),
                  ),
                  Text(
                    '3 Years',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade500),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      'All',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedIndex != null)
              _buildPointDetails(_selectedIndex!),
            if (_selectedIndex2 != null)
              _buildPointDetails(_selectedIndex2!),
            if (_selectedIndex == null && _selectedIndex2 == null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    'Select a point on the graph to see details.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ),
              ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 12,),
                      Container(
                        color: Colors.green,
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Normal',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey.shade900),
                      ),
                    ],
                  ),
                  SizedBox(width: 18,),
                  Row(
                    children: [
                      SizedBox(width: 12,),
                      Container(
                        color: Colors.red,
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Abnormal',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: _chartWidth,
                    height: 251,
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: jsonData.length.toDouble() - 1,
                        minY: minY,
                        maxY: maxY,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(
                          show: false,
                        ),

                        titlesData: FlTitlesData(
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              getTitlesWidget: (value, meta) {
                                if (value > 0) {
                                  return Text(value.toInt().toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.grey.shade500));
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                int index = value.round();
                                if (index >= 0 && index < xLabels.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      xLabels[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        lineBarsData: [
                          // Numeric data line
                          LineChartBarData(
                            spots: numericSpots,
                            isCurved: false,
                            color: Colors.transparent,
                            barWidth: 0,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: false),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                int originalIndex = numericIndices[index];
                                bool isSelected = _selectedIndex == originalIndex;
                                final item = jsonData[originalIndex];
                                final isNormal = item['status'] == 'normal';
                
                                return FlDotCirclePainter(
                                  radius: 10,
                                  color: isNormal ? Colors.green : Colors.red,
                                  strokeColor: isSelected ? Colors.grey : Colors.transparent,
                                  strokeWidth: 6,
                                );
                              },
                            ),
                          ),
                          // Qualitative data line
                          LineChartBarData(
                            spots: qualitativeSpots,
                            isCurved: false,
                            color: Colors.transparent,
                            barWidth: 0,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: false),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                int originalIndex = qualitativeIndices[index];
                                bool isSelected = _selectedIndex2 == originalIndex;
                                final item = jsonData[originalIndex];
                
                                return CustomImagePainter(
                                  getImageForResult(item['result'],item['status']) ?? _customCommentImage!,
                                  isSelected: isSelected,
                                );
                              },
                            ),
                          ),
                        ],

                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (List<LineBarSpot> touchedSpots) => [],
                          ),
                          handleBuiltInTouches: true,
                          touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                            if (touchResponse != null && touchResponse.lineBarSpots != null && touchResponse.lineBarSpots!.isNotEmpty) {
                              setState(() {
                                if (touchResponse.lineBarSpots!.first.barIndex == 0) {
                                  // Numeric data
                                  int originalIndex = numericIndices[touchResponse.lineBarSpots!.first.spotIndex];
                                  _selectedIndex = originalIndex;
                                  _selectedIndex2 = null;
                                } else if (touchResponse.lineBarSpots!.first.barIndex == 1) {
                                  // Qualitative data
                                  int originalIndex = qualitativeIndices[touchResponse.lineBarSpots!.first.spotIndex];
                                  _selectedIndex2 = originalIndex;
                                  _selectedIndex = null;
                                }
                              });
                            } else {
                              setState(() {
                                _selectedIndex = null;
                                _selectedIndex2 = null;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointDetails(int index) {
    final item = jsonData[index];
    final isNumeric = item['type'] == 'numeric';

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Colors.grey.shade500),
                    ),
                    Text(
                      item['date'],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade900),
                    )
                  ],
                ),
                if (isNumeric)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Reference Range',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.grey.shade500),
                      ),
                      Text(
                        '${item['refMin']} - ${item['refMax']}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade900),
                      )
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Result',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.grey.shade500),
                      ),
                      Text(
                        item['result']?.toString() ?? 'N/A',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade900),
                      )
                    ],
                  ),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Value',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.grey.shade500),
                ),
                Text(
                  isNumeric ? item['value'].toString() : (item['status']?.toString() ?? 'N/A'),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900),
                )
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Institute',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.grey.shade500),
                ),
                Text(
                  item['institute'],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDotPainter extends FlDotPainter {
  final double radius;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;
  final String value;
  final String institute;
  final bool isSelected;

  CustomDotPainter({
    required this.radius,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
    required this.value,
    required this.institute,
    required this.isSelected,
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offset) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw the dot
    canvas.drawCircle(offset, radius, paint);
    canvas.drawCircle(offset, radius, strokePaint);

    // Draw the custom widget above the dot if selected

      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: 'I\nI\nI',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
    final TextPainter textPainter2 = TextPainter(
      text: TextSpan(
        text: value,
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
      textPainter.layout();
    textPainter2.layout();

      final double textX = offset.dx - textPainter.width / 4;
      final double textY = offset.dy - radius - textPainter.height - 0;
    final double text2X = offset.dx - textPainter2.width / -3;
    final double text2Y = offset.dy - radius - textPainter2.height - 15;

      // Draw a background for the text
      final Paint backgroundPaint = Paint()..color = Colors.transparent;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(textX - 4, textY - 4, textPainter.width + 8, textPainter.height + 8),
          Radius.circular(4),
        ),
        backgroundPaint,
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(text2X - 4, text2Y - 4, textPainter2.width + 8, textPainter2.height + 8),
        Radius.circular(4),
      ),
      backgroundPaint,
    );
      // Draw the text
      textPainter.paint(canvas, Offset(textX, textY));
    textPainter2.paint(canvas, Offset(text2X, text2Y));

  }

  @override
  Size getSize(FlSpot spot) {
    // TODO: implement getSize
    throw UnimplementedError();
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CustomImagePainter extends FlDotPainter {
  final ui.Image image;
  final bool isSelected; // Add this to track selection

  CustomImagePainter(this.image, {this.isSelected = false}); // Add isSelected parameter

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final double imageSize = 20.0; // Adjust as needed
    final paint = Paint();

    // Draw the image
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromCenter(center: offsetInCanvas, width: imageSize, height: imageSize),
      paint,
    );

    // Draw a stroke around the image if selected
    if (isSelected) {
      final strokePaint = Paint()
        ..color = Colors.grey // Stroke color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0; // Stroke width
      canvas.drawCircle(offsetInCanvas, imageSize / 2 + 2, strokePaint); // Adjust radius as needed
    }
  }

  @override
  Size getSize(FlSpot spot) => const Size(20, 20); // Adjust size as needed

  FlDotPainter copyWith({ui.Image? newImage, bool? isSelected}) {
    return CustomImagePainter(
      newImage ?? image,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is CustomImagePainter && b is CustomImagePainter) {
      return CustomImagePainter(
        b.image, // Use the image from the second painter
        isSelected: b.isSelected, // Use the selection state from the second painter
      );
    }
    return this;
  }

  @override
  Color get mainColor => Colors.transparent; // Not used for this custom painter

  @override
  List<Object?> get props => [image, isSelected]; // Include isSelected in props
}

class CustomIconDotPainter extends FlDotPainter {
  final IconData icon;
  final Color color;
  final bool isSelected;

  CustomIconDotPainter({
    required this.icon,
    required this.color,
    required this.isSelected,
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 24,
          color: color,
          fontFamily: icon.fontFamily,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(offsetInCanvas.dx - textPainter.width / 2, offsetInCanvas.dy - textPainter.height / 2),
    );

    if (isSelected) {
      final Paint strokePaint = Paint()
        ..color = Colors.grey
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(offsetInCanvas, 12, strokePaint);
    }
  }

  @override
  Size getSize(FlSpot spot) {
    // TODO: implement getSize
    throw UnimplementedError();
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

  @override
  // TODO: implement mainColor
  Color get mainColor => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

void main() {
  runApp(MaterialApp(home: GraphPage()));
}
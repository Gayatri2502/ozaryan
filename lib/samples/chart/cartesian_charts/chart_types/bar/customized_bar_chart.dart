/// Dart imports
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../../model/sample_view.dart';

/// Render the customized bar chart sample.
class BarCustomization extends SampleView {
  /// Creates the customized bar chart sample.
  const BarCustomization(Key key) : super(key: key);

  @override
  _BarCustomizationState createState() => _BarCustomizationState();
}

/// dashed array image renders inside of  bars
ui.Image? image;

/// Set image loaded info
bool isImageloaded = false;

/// State class of the customized bar chart.
class _BarCustomizationState extends SampleViewState {
  _BarCustomizationState();

  TooltipBehavior? _tooltipBehavior;

  void _loadImage() {
    final Completer<ImageInfo> completer = Completer<ImageInfo>();
    const ImageProvider imageProvider = AssetImage('images/dashline.png');
    imageProvider
        .resolve(ImageConfiguration.empty)
        .addListener(ImageStreamListener((ImageInfo info, bool _) async {
      isImageloaded = true;
      completer.complete(info);
      final ImageInfo imageInfo = await completer.future;

      image = imageInfo.image;
    }));
  }

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, canShowMarker: false, header: '');
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomizedBarChart();
  }

  /// Returns the customized cartesian bar chart.
  SfCartesianChart _buildCustomizedBarChart() {
    return SfCartesianChart(
      title: ChartTitle(
          text: isCardView
              ? ''
              : 'Popular Android apps in the Google play store'),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          title: AxisTitle(text: isCardView ? '' : 'Downloads in Billion'),
          minimum: 0,
          maximum: model.isWebFullView ? 4.5 : 5,
          interval: model.isWebFullView ? 0.5 : 1,
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: <ChartSeries<ChartSampleData, String>>[
        BarSeries<ChartSampleData, String>(
          onCreateRenderer: (ChartSeries<ChartSampleData, String> series) {
            return _CustomBarSeriesRenderer();
          },
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'Facebook', y: 4.119, pointColor: Colors.redAccent),
            ChartSampleData(
                x: 'FB Messenger', y: 3.408, pointColor: Colors.indigo),
            ChartSampleData(x: 'WhatsApp', y: 2.979, pointColor: Colors.grey),
            ChartSampleData(
                x: 'Instagram', y: 1.843, pointColor: Colors.orange),
            ChartSampleData(x: 'Skype', y: 1.039, pointColor: Colors.green),
            ChartSampleData(
                x: 'Subway Surfers', y: 1.025, pointColor: Colors.yellow),
          ],
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
        )
      ],
      tooltipBehavior: _tooltipBehavior,
    );
  }
}

/// Custom bar series class that extend the original bar series
/// to create Customized bar chart.
class _CustomBarSeriesRenderer extends BarSeriesRenderer {
  _CustomBarSeriesRenderer();

  @override
  BarSegment createSegment() {
    return BarCustomPainter();
  }
}

/// custom bar painter for the customized bar chart series.
class BarCustomPainter extends BarSegment {
  @override
  void onPaint(Canvas canvas) {
    final Float64List deviceTransform = Float64List(16)
      ..[0] = 0.05
      ..[5] = 0.05
      ..[10] = 1.0
      ..[15] = 2.0;

    final Paint linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 40
      ..shader = image == null
          ? null
          : ImageShader(
              image!, TileMode.repeated, TileMode.repeated, deviceTransform);

    final double devicePixelRatio = ui.window.devicePixelRatio;

    if (isImageloaded && devicePixelRatio > 0) {
      super.onPaint(canvas);
      final Rect rect = Rect.fromLTRB(segmentRect.left, segmentRect.top,
          segmentRect.right * animationFactor, segmentRect.bottom);
      canvas.drawRect(rect, linePaint);
    }
  }
}

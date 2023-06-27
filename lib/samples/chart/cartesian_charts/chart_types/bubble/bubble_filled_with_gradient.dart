/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../../model/sample_view.dart';

/// Renders the bubble with gradient chart sample
class BubbleGradient extends SampleView {
  /// Creates the bubble with gradient chart sample
  const BubbleGradient(Key key) : super(key: key);

  @override
  _BubbleGradientState createState() => _BubbleGradientState();
}

/// State class of bubble with gradient chart
class _BubbleGradientState extends SampleViewState {
  _BubbleGradientState();

  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGradientBubbleChart();
  }

  /// Returns the cartesian bubble cahrt with gradient
  SfCartesianChart _buildGradientBubbleChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: isCardView ? '' : 'Circket World cup statistics - till 2015'),
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          title: AxisTitle(text: isCardView ? '' : 'Country'),
          labelIntersectAction: AxisLabelIntersectAction.multipleRows),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          title: AxisTitle(text: isCardView ? '' : 'Finals count'),
          minimum: 0,
          maximum: 4,
          interval: 1),
      series: _getGradientBubbleSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the list of chart series which need to render on the bubble chart
  List<BubbleSeries<ChartSampleData, String>> _getGradientBubbleSeries() {
    return <BubbleSeries<ChartSampleData, String>>[
      BubbleSeries<ChartSampleData, String>(
        /// To apply the gradient colors for bubble chart here.
        gradient: LinearGradient(
            colors: <Color>[Colors.blue[50]!, Colors.blue[200]!, Colors.blue],
            stops: const <double>[0.0, 0.5, 1.0]),
        dataSource: <ChartSampleData>[
          ChartSampleData(
              x: 'England',
              y: 3,
              yValue: 0,
              pointColor: const Color.fromRGBO(233, 132, 30, 1)),
          ChartSampleData(
              x: 'India',
              y: 3,
              yValue: 2,
              pointColor: const Color.fromRGBO(0, 255, 255, 1)),
          ChartSampleData(
              x: 'Pakistan',
              y: 2,
              yValue: 1,
              pointColor: const Color.fromRGBO(255, 200, 102, 1)),
          ChartSampleData(
              x: 'West\nIndies',
              y: 3,
              yValue: 2,
              pointColor: const Color.fromRGBO(0, 0, 0, 1)),
          ChartSampleData(
              x: 'Sri\nLanka',
              y: 3,
              yValue: 1,
              pointColor: const Color.fromRGBO(255, 340, 102, 1)),
          ChartSampleData(
              x: 'New\nZealand',
              y: 1,
              yValue: 0,
              pointColor: const Color.fromRGBO(200, 0, 102, 1))
        ],
        minimumRadius: 5,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        sizeValueMapper: (ChartSampleData sales, _) => sales.yValue,
      )
    ];
  }
}

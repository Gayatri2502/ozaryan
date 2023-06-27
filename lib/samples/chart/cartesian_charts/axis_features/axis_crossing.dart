/// Chart import
/// Package import
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../model/sample_view.dart';
import '../../../../widgets/custom_button.dart';

/// Renders the spline chart with axis crossing sample.
class AxisCrossing extends SampleView {
  ///Creates default axis crossing sample, chart widget
  const AxisCrossing(Key key) : super(key: key);

  @override
  _AxisCrossingState createState() => _AxisCrossingState();
}

/// State class of the spline chart with axis crossing.
class _AxisCrossingState extends SampleViewState {
  _AxisCrossingState();
  List<String>? _axis;
  late String _selectedSeriesType;
  //ignore: unused_field
  late String _selectedSeries;
  late String _selectedAxisType;
  late String _selectedAxis;
  late double _crossAt = 0;
  bool? _isPlaceLabelsNearAxisLine = true;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _axis = <String>['x', 'y'].toList();
    _selectedAxisType = 'x';
    _selectedAxis = 'x';
    _selectedSeriesType = 'column';
    _selectedSeries = 'column';
    _crossAt = 0;
    _isPlaceLabelsNearAxisLine = true;
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAxisCrossingSample();
  }

  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Axis  ',
                  style: TextStyle(fontSize: 16.0, color: model.textColor)),
              Container(
                padding: const EdgeInsets.fromLTRB(138, 0, 0, 0),
                child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    underline:
                        Container(color: const Color(0xFFBDBDBD), height: 1),
                    value: _selectedAxis,
                    items: _axis!.map((String value) {
                      return DropdownMenuItem<String>(
                          value: (value != null) ? value : 'X',
                          child: Text(value,
                              style: TextStyle(color: model.textColor)));
                    }).toList(),
                    onChanged: (dynamic value) {
                      _onAxisTypeChange(value.toString());
                      stateSetter(() {});
                    }),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Cross at  ',
                  style: TextStyle(fontSize: 16.0, color: model.textColor)),
              Container(
                padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                child: CustomDirectionalButtons(
                  minValue: -8,
                  maxValue: 8,
                  initialValue: _crossAt,
                  onChanged: (double val) => setState(() {
                    _crossAt = val;
                  }),
                  step: 2,
                  iconColor: model.textColor,
                  style: TextStyle(fontSize: 20.0, color: model.textColor),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Labels near axis line',
                  style: TextStyle(color: model.textColor, fontSize: 16)),
              SizedBox(
                  width: 75,
                  child: CheckboxListTile(
                      activeColor: model.backgroundColor,
                      value: _isPlaceLabelsNearAxisLine,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPlaceLabelsNearAxisLine = value;
                          stateSetter(() {});
                        });
                      })),
            ],
          ),
        ],
      );
    });
  }

  /// Returns the spline chart with axis crossing at provided axis value.
  SfCartesianChart _buildAxisCrossingSample() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: isCardView ? '' : 'Spline Interpolation'),
      legend: Legend(isVisible: !isCardView),
      primaryXAxis: NumericAxis(
          minimum: -8,
          maximum: 8,
          interval: 2,
          placeLabelsNearAxisLine: isCardView
              ? true
              : _selectedAxisType == 'x'
                  ? _isPlaceLabelsNearAxisLine ?? true
                  : true,
          crossesAt: _selectedAxisType == 'x' ? _crossAt : 0,
          minorTicksPerInterval: 3),
      primaryYAxis: NumericAxis(
          minimum: -8,
          maximum: 8,
          interval: 2,
          placeLabelsNearAxisLine: isCardView
              ? true
              : _selectedAxisType == 'y'
                  ? _isPlaceLabelsNearAxisLine ?? true
                  : true,
          crossesAt: _selectedAxisType == 'y' ? _crossAt : 0,
          minorTicksPerInterval: 3),
      series: _getSeries(_selectedSeriesType),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns the list of chart series which need to render on
  /// the spline chart with axis crossing.

  List<ChartSeries<ChartSampleData, num>> _getSeries(String seriesType) {
    return <ChartSeries<ChartSampleData, num>>[
      SplineSeries<ChartSampleData, num>(
          dataSource: <ChartSampleData>[
            ChartSampleData(x: -7, y: -3),
            ChartSampleData(x: -4.5, y: -2),
            ChartSampleData(x: -3.5, y: 0),
            ChartSampleData(x: -3, y: 2),
            ChartSampleData(x: 0, y: 7),
            ChartSampleData(x: 3, y: 2),
            ChartSampleData(x: 3.5, y: 0),
            ChartSampleData(x: 4.5, y: -2),
            ChartSampleData(x: 7, y: -3),
          ],
          xValueMapper: (ChartSampleData sales, _) => sales.x as num,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          color: const Color.fromRGBO(20, 122, 20, 1),
          name: 'Cubic Interpolation',
          width: 2),
    ];
  }

  /// Method for updating the axis type on change.
  void _onAxisTypeChange(String item) {
    _selectedAxis = item;
    if (_selectedAxis == 'x') {
      _selectedAxisType = 'x';
    } else if (_selectedAxis == 'y') {
      _selectedAxisType = 'y';
    }
    setState(() {
      /// update the axis type changes
    });
  }

  @override
  void dispose() {
    _axis!.clear();
    super.dispose();
  }
}

/// Package imports
import 'package:flutter/material.dart';

/// Barcode import
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Local import
import '../../../../model/sample_view.dart';
import '../../datagridsource/stock_datagridsource.dart';

/// Render data grid with conditional styling
class ConditionalStylingDataGrid extends SampleView {
  /// Creates data grid with conditional styling
  const ConditionalStylingDataGrid({Key? key}) : super(key: key);

  @override
  _ConditionalStylingDataGridState createState() =>
      _ConditionalStylingDataGridState();
}

class _ConditionalStylingDataGridState extends SampleViewState {
  /// DataGridSource required for SfDataGrid to obtain the row data.
  final ConditionalStyleDataGridSource conditionalStyleDataGridSource =
      ConditionalStyleDataGridSource();

  late bool isWebOrDesktop;

  @override
  void initState() {
    super.initState();
    isWebOrDesktop = model.isWeb || model.isDesktop;
  }

  SfDataGrid _buildDataGrid() {
    return SfDataGrid(
      source: conditionalStyleDataGridSource,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'name',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 150 : double.nan,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Name',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'qs1',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 150 : double.nan,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text(
                'Q1',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        GridColumn(
          columnName: 'qs2',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 150 : double.nan,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text(
                'Q2',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        GridColumn(
          columnName: 'qs3',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 150 : double.nan,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text(
                'Q3',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        GridColumn(
          columnName: 'qs4',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 150 : double.nan,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text(
                'Q4',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDataGrid();
  }
}

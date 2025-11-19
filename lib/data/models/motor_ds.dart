import 'package:flutter/material.dart';
import 'package:sfm_logistic/data/models/loading_row.dart';
import 'package:sfm_logistic/services/motor_model_list_service.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ChassisDataSource extends DataGridSource {
  final MotorModelListService motorModelService;
  ChassisDataSource({
    required List<LoadingRow> chassisList,
    required this.motorModelService,
  }) {
    _chassisList = chassisList
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'chassis',
                value: e.sasiNo,
              ),
              DataGridCell<String>(
                columnName: 'motor',
                value: e.motorNo,
              ),
              DataGridCell<String>(
                columnName: 'modelRef',
                value: e.modelReferansNo,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _chassisList = [];

  @override
  List<DataGridRow> get rows => _chassisList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent),
          ),
          padding: EdgeInsets.all(1.0),
          child: Text(
            dataGridCell.value.toString(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget? buildGroupCaptionCellWidget(
    RowColumnIndex rowColumnIndex,
    String summaryValue,
  ) {
    String clearValue = summaryValue
        .replaceAll('modelRef : ', '')
        .replaceAll('Items', 'Adet');
    String modelString = clearValue.substring(0, 4);
    String motorValue = clearValue.replaceAll(
      modelString,
      motorModelService.getModelById(int.parse(modelString)),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Text(motorValue),
    );
  }

  @override
  String performGrouping(String columnName, DataGridRow row) {
    if (columnName == 'modelRef') {
      final modelCode = row
          .getCells()
          .firstWhere((DataGridCell cell) => cell.columnName == 'modelRef')
          .value;

      // modelCode int olduğu için string'e çeviriyoruz
      return modelCode;
    }

    // Diğer kolonlar için varsayılan davranış
    return super.performGrouping(columnName, row);
  }
}

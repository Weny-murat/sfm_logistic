// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfm_logistic/data/models/loading_row.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sfm_logistic/data/models/motor_ds.dart';
import 'package:sfm_logistic/services/motor_model_list_service.dart';

class ShowGrid extends StatefulWidget {
  final List<LoadingRow> chassisList;
  const ShowGrid({super.key, required this.chassisList});

  @override
  State<ShowGrid> createState() => _ShowGridState();
}

class _ShowGridState extends State<ShowGrid> {
  @override
  Widget build(BuildContext context) {
    final ds = ChassisDataSource(
      chassisList: widget.chassisList,
      motorModelService: context.read<MotorModelListService>(),
    );
    ds.addColumnGroup(ColumnGroup(name: 'modelRef', sortGroupRows: true));
    return LoadingGrid(ds: ds);
  }
}

class LoadingGrid extends StatelessWidget {
  const LoadingGrid({super.key, required this.ds});

  final ChassisDataSource ds;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      horizontalScrollPhysics: NeverScrollableScrollPhysics(),
      verticalScrollPhysics: NeverScrollableScrollPhysics(),
      source: ds,
      allowExpandCollapseGroup: true,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'chassis',
          minimumWidth: MediaQuery.sizeOf(context).width / 2 - 40,
          label: Container(
            alignment: Alignment.centerLeft,
            child: Text('Şasi'),
          ),
        ),
        GridColumn(
          columnName: 'motor',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            child: Text('Motor'),
          ),
        ),
        GridColumn(
          columnName: 'modelRef',
          visible: false,
          label: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text('Model-Renk'),
          ),
        ),
      ],
    );
  }
}

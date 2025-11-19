import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfm_logistic/blocs/loading_list_cubit/loading_list_cubit.dart';
import 'package:sfm_logistic/core/utils.dart';
import 'package:sfm_logistic/data/models/loading_row.dart';
import 'package:sfm_logistic/data/models/motor_ds.dart';
import 'package:sfm_logistic/services/motor_model_list_service.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SecondStep extends StatefulWidget {
  const SecondStep({super.key});

  @override
  State<SecondStep> createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingListCubit, List<LoadingRow>>(
      builder: (context, state) {
        final ds = ChassisDataSource(
          chassisList: state.toLoadingList(),
          motorModelService: context.read<MotorModelListService>(),
        );
        ds.addColumnGroup(ColumnGroup(name: 'modelRef', sortGroupRows: true));
        return LoadingGrid(ds: ds);
      },
    );
  }
}

class LoadingGrid extends StatelessWidget {
  const LoadingGrid({super.key, required this.ds});

  final ChassisDataSource ds;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: ds,
      allowExpandCollapseGroup: true,
      allowSwiping: true,
      endSwipeActionsBuilder: (context, dataGridRow, rowIndex) {
        return IconButton(
          onPressed: () => context.read<LoadingListCubit>().remove(
            dataGridRow.getCells()[0].value,
          ),
          icon: Icon(Icons.delete, color: Colors.redAccent),
        );
      },
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

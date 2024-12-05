import '/flutter_flow/flutter_flow_util.dart';
import 'company_list_widget.dart' show CompanyListWidget;
import 'package:flutter/material.dart';

class CompanyListModel extends FlutterFlowModel<CompanyListWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}

import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class ApiResponseFutureBuilder extends StatefulWidget {
  final Future<ApiResponse> future;
  final Widget child;
  const ApiResponseFutureBuilder(
      {super.key, required this.future, required this.child});

  @override
  State<ApiResponseFutureBuilder> createState() =>
      _ApiResponseFutureBuilderState();
}

class _ApiResponseFutureBuilderState extends State<ApiResponseFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    print('Built the widget');
    return FutureBuilder<ApiResponse>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: UiUtils.loadingIndicator(context));
        } else if (snapshot.hasError) {
          print('Snapshot has error');
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData && snapshot.data!.status == Status.error) {
          print('Snapshot status is an error');
          return Center(
            child: Text(snapshot.data!.errorMessage ?? snapshot.data!.message),
          );
        } else {
          return widget.child;
        }
      },
    );
    // return Scaffold(
    //   body: Center(
    //     child: FutureBuilder<ApiResponse>(
    //       future: future,
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(child: UiUtils.loadingIndicator(context));
    //         } else if (snapshot.hasError) {
    //           return Center(child: Text(snapshot.error.toString()));
    //         } else if (snapshot.hasData &&
    //             snapshot.data!.status == Status.error) {
    //           return Center(child: Text(snapshot.data!.message));
    //         } else {
    //           return child;
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}

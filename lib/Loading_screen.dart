import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.black54,
          size: 60.0,
        ),
      ),
    );
  }
}

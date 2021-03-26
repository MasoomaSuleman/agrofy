import 'package:flutter/material.dart';

//added dependencies
import 'package:google_fonts/google_fonts.dart';

class CustomTile extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final String _value;
  final Size _size;
  CustomTile(this._icon, this._title, this._value, this._size);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (_size.width * 0.05), vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _icon,
              color: Colors.black,
              size: 22,
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$_title',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                (_value != null)
                    ? Text(
                        '$_value',
                        style: GoogleFonts.poppins(fontSize: 12),
                        maxLines: 4,
                      )
                    : Text('')
              ],
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class TextfieldIO extends StatefulWidget {
  String title, hint;
  var onchanged;
  Widget? prefix = Container(), suffix = Container();
  TextEditingController? textEditingController = TextEditingController();

  String? errorText;

  TextfieldIO(this.title, this.hint, this.onchanged,
      {this.prefix,
      this.suffix,
      this.textEditingController,
      this.errorText = null,
      Key? key})
      : super(key: key);

  @override
  State<TextfieldIO> createState() => _TextfieldIOState();
}

class _TextfieldIOState extends State<TextfieldIO> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
          errorText: widget.errorText,
          prefix: widget.prefix,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 9),
          suffix: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 3, 0), child: widget.suffix),
          labelText: widget.title,
          hintText: widget.hint,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(9),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.blue),
            borderRadius: BorderRadius.circular(9),
          )),
      onChanged: widget.onchanged,
    );
  }
}

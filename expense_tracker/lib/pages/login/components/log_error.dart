import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Error extends StatelessWidget {
  const Error({
    super.key,
    required this.errors,
  });

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors.length, (index) => erroText(error: errors[index])),
    );
  }

  Row erroText({required String error}) {
  return Row(
    children: [
      const Icon(LineAwesomeIcons.exclamation_circle, size: 30, color: Colors.red,),
      const SizedBox(width: 10,),
      Text(error),
    ],
  );
}
}
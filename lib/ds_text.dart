import 'package:flutter/material.dart';

class DSText extends StatelessWidget {
  final String text;

  const DSText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final span = rich(text, style: const TextStyle(fontSize: 20));
    return Text.rich(span);
  }

  TextSpan rich(String input, {TextStyle? style}) {
    const styles = {
      '_': TextStyle(fontStyle: FontStyle.italic),
      '*': TextStyle(fontWeight: FontWeight.bold),
      '~': TextStyle(decoration: TextDecoration.lineThrough),
      '```': TextStyle(fontFamily: 'monospace', color: Colors.black87),
    };
    final spans = <TextSpan>[];
    final pattern = RegExp(r'([_*~]|`{3})(.*?)\1');
    input.trim().splitMapJoin(pattern, onMatch: (m) {
      final input = m.group(2)!;
      final style = styles[m.group(1)];
      spans.add(pattern.hasMatch(input)
          ? rich(input, style: style)
          : TextSpan(text: input, style: style));
      return '';
    }, onNonMatch: (String text) {
      spans.add(TextSpan(text: text));
      return '';
    });
    return TextSpan(style: style, children: spans);
  }
}

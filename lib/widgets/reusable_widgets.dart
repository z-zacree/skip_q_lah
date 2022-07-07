import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  const TextHeader({Key? key, this.text, this.style}) : super(key: key);

  final String? text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text ?? 'Skip Q Lah',
        style: style ??
            const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class TextSubHeader extends StatelessWidget {
  const TextSubHeader(this.text, {Key? key, this.style}) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

// class Text

class RoundedOutlineInput extends StatelessWidget {
  const RoundedOutlineInput({
    Key? key,
    required this.label,
    required this.validator,
    this.padding,
    this.hint,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  final String label;
  final String? hint;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.child, this.onPressed, this.style})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: style ??
          ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            minimumSize: const Size(double.infinity, 45),
            primary: Theme.of(context).primaryColor,
          ),
      child: child,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key, required this.child, this.onPressed, this.style})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: style ??
          ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            minimumSize: const Size(double.infinity, 45),
          ),
      child: child,
    );
  }
}

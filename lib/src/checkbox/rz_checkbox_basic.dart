import 'package:flutter/material.dart';

class RzCheckboxBasic extends StatelessWidget {
  const RzCheckboxBasic({
    super.key,
    required this.value,
    required this.onChanged,

    // Text
    this.text,
    this.textWidget,
    this.textStyle,

    // Position
    this.controlAffinity = ListTileControlAffinity.leading,

    // Colors
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.overlayColor,

    // Border
    this.shape,
    this.side,

    // State
    this.enabled = true,
    this.autofocus = false,
    this.tristate = false,
    this.isError = false,

    // Density
    this.dense,
    this.contentPadding,
    this.visualDensity,

    // Callback
    this.onTap,
  });

  //--------------------------------------------------------------------------
  // Value
  //--------------------------------------------------------------------------

  final bool? value;
  final ValueChanged<bool?>? onChanged;

  //--------------------------------------------------------------------------
  // Text
  //--------------------------------------------------------------------------

  final String? text;
  final Widget? textWidget;
  final TextStyle? textStyle;

  //--------------------------------------------------------------------------
  // Position
  //--------------------------------------------------------------------------

  final ListTileControlAffinity controlAffinity;

  //--------------------------------------------------------------------------
  // Colors
  //--------------------------------------------------------------------------

  final Color? activeColor;
  final Color? checkColor;
  final WidgetStateProperty<Color?>? fillColor;
  final WidgetStateProperty<Color?>? overlayColor;

  //--------------------------------------------------------------------------
  // Border
  //--------------------------------------------------------------------------

  final OutlinedBorder? shape;
  final BorderSide? side;

  //--------------------------------------------------------------------------
  // State
  //--------------------------------------------------------------------------

  final bool enabled;
  final bool autofocus;
  final bool tristate;
  final bool isError;

  //--------------------------------------------------------------------------
  // Density
  //--------------------------------------------------------------------------

  final bool? dense;
  final EdgeInsetsGeometry? contentPadding;
  final VisualDensity? visualDensity;

  //--------------------------------------------------------------------------
  // Callback
  //--------------------------------------------------------------------------

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final title = textWidget ??
        (text != null
            ? Text(
          text!,
          style: textStyle,
        )
            : null);

    //--------------------------------------------------------------------------
    // Checkbox only
    //--------------------------------------------------------------------------

    if (title == null) {
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: enabled
            ? () {
          onTap?.call();

          if (onChanged != null) {
            if (tristate) {
              if (value == null) {
                onChanged!(false);
              } else if (value == false) {
                onChanged!(true);
              } else {
                onChanged!(null);
              }
            } else {
              onChanged!(!(value ?? false));
            }
          }
        }
            : null,
        child: IgnorePointer(
          child: Checkbox(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: activeColor,
            checkColor: checkColor,
            fillColor: fillColor,
            overlayColor: overlayColor,
            shape: shape,
            side: side,
            autofocus: autofocus,
            tristate: tristate,
            isError: isError,
            visualDensity: visualDensity,
          ),
        ),
      );
    }

    //--------------------------------------------------------------------------
    // Checkbox with label
    //--------------------------------------------------------------------------

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: enabled
          ? () {
        onTap?.call();

        if (onChanged != null) {
          if (tristate) {
            if (value == null) {
              onChanged!(false);
            } else if (value == false) {
              onChanged!(true);
            } else {
              onChanged!(null);
            }
          } else {
            onChanged!(!(value ?? false));
          }
        }
      }
          : null,
      child: IgnorePointer(
        child: CheckboxListTile(
          value: value,
          onChanged: enabled ? onChanged : null,
          title: title,
          controlAffinity: controlAffinity,
          activeColor: activeColor,
          checkColor: checkColor,
          fillColor: fillColor,
          overlayColor: overlayColor,
          shape: shape,
          side: side,
          autofocus: autofocus,
          tristate: tristate,
          isError: isError,
          dense: dense,
          contentPadding: contentPadding,
          visualDensity: visualDensity,
        ),
      ),
    );
  }
}
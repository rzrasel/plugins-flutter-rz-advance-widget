# RzIconTextFormFieldExtended

A modern, highly customizable Flutter TextFormField with animated floating label on border, icon support, clear button, and all FormField features.

Built for production - supports controller/focusNode handling, validation, and Material 3.

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue)
![Platform](https://img.shields.io/badge/platform-all%20platforms-green)
![License](https://img.shields.io/badge/License-MIT-orange)

## About it / Description

`RzIconTextFormFieldExtended` is an extended version of `TextFormField` that shows the label as a floating label on the border top (like outlined Material field) with animation.

- Label floats to border when focused or has text
- Hint hides on focus (optional)
- Prefix/Suffix icon with IconData or Widget
- Clear icon (X) that shows only when typing
- Clear + suffix both visible together
- Fully customizable border, radius, colors, padding
- Supports controller OR initialValue
- Auto handles internal FocusNode & Controller

If you want a clean, modern input with border label animation - use this.

## Features

- ✅ Animated floating label on border (-8 top position)
- ✅ hideHintOnFocus - hide hint when focused
- ✅ hideLabelOnFocusOut - label only shows when focused
- ✅ prefixIcon / suffixIcon as Widget
- ✅ prefixIconData / suffixIconData as IconData
- ✅ onPrefixIconTap / onSuffixIconTap
- ✅ showClearIcon + clearIcon / clearIconData
- ✅ Clear + suffixIcon both show together (Row)
- ✅ borderRadius as num OR BorderRadius
- ✅ focusedBorderColor, borderColor, error colors
- ✅ filled + fillColor
- ✅ validator, onSaved, autoValidateMode
- ✅ All TextFormField properties (keyboardType, maxLength, inputFormatters etc)
- ✅ Works with Form

## Installation

```dart
import 'package:flutter/material.dart';
import 'package:rz_widget_set_basic/rz_widget_set_basic.dart';
```

<details open>
<summary>Basic:</summary>

```dart
RzIconTextFormFieldExtended(
  hintText: 'Enter your name',
  labelText: 'Name',
)
```
```dart
RzIconTextFormFieldExtended(
  hintText: 'Search...',
  prefixIconData: Icons.search,
)
```
```dart
RzIconTextFormFieldExtended(
  hintText: 'Email',
  labelText: 'Email Address',
  keyboardType: TextInputType.emailAddress,
  validator: (v) => v!.isEmpty ? 'Required' : null,
)
```
</details>

<details>
<summary>Full Feature Usage - All Properties:</summary>

```dart
RzIconTextFormFieldExtended(
  // Controller & Focus
  controller: _controller,
  focusNode: _focusNode,
  initialValue: null, // use if controller is null

  // Texts
  hintText: 'Enter email',
  labelText: 'Email',
  helperText: 'We will not share',
  errorText: null,

  // Prefix / Suffix Widget (priority over IconData)
  prefix: null,
  suffix: null,
  prefixIcon: Icon(Icons.email),
  suffixIcon: Icon(Icons.check),

  // Prefix / Suffix IconData
  prefixIconData: Icons.person,
  suffixIconData: Icons.visibility,
  prefixIconColor: Colors.grey,
  suffixIconColor: Colors.blue,
  prefixIconSize: 22,
  suffixIconSize: 22,
  onPrefixIconTap: () => print('prefix tap'),
  onSuffixIconTap: () => print('suffix tap'),

  // NEW: Clear Icon
  showClearIcon: true,
  clearIcon: Icon(Icons.cancel, color: Colors.grey),
  clearIconData: Icons.clear, // used if clearIcon is null
  clearIconColor: Colors.grey,
  clearIconSize: 22,
  onClearIconTap: () => print('cleared'),

  // Styles
  style: TextStyle(fontSize: 14, color: Colors.black),
  hintStyle: TextStyle(color: Colors.grey),
  labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),

  // Input
  keyboardType: TextInputType.text,
  textInputAction: TextInputAction.next,
  textCapitalization: TextCapitalization.none,
  textAlign: TextAlign.start,
  enabled: true,
  readOnly: false,
  autofocus: false,
  obscureText: false,
  enableSuggestions: true,
  autocorrect: true,
  maxLines: 1,
  minLines: null,
  maxLength: 100,
  expands: false,

  // Decoration
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  borderRadius: 8, // num or BorderRadius.circular(8)
  borderColor: Colors.grey,
  focusedBorderColor: Colors.blue,
  errorBorderColor: Colors.red,
  focusedErrorBorderColor: Colors.red,
  errorBorderWidth: 1,
  focusedErrorBorderWidth: 1.5,
  fillColor: Colors.grey.shade100,
  filled: true,
  cursorColor: Colors.blue,
  cursorHeight: null,
  cursorWidth: 2,

  // Formatters & Validation
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  validator: (v) => v!.isEmpty ? 'Required' : null,
  onSaved: (v) => print(v),
  autoValidateMode: AutovalidateMode.onUserInteraction,

  // Callbacks
  onChanged: (v) => print(v),
  onTap: () => print('tap'),
  onEditingComplete: () => print('complete'),
  onFieldSubmitted: (v) => print('submitted $v'),
  onTapOutside: (e) => FocusScope.of(context).unfocus(),

  // Behaviors
  hideHintOnFocus: true, // hint hides when focused
  hideLabelOnFocusOut: true, // label shows only when focused, false = shows when has text too
)
```
</details>

<details>
<summary>1. Search field with clear + search icon:</summary>

```dart
RzIconTextFormFieldExtended(
  hintText: 'Search...',
  labelText: 'Search',
  prefixIconData: Icons.search,
  showClearIcon: true,
  suffixIconData: Icons.tune,
  onSuffixIconTap: () => openFilter(),
  borderRadius: BorderRadius.circular(500),
  filled: true,
  fillColor: Colors.grey.shade100,
)
```
</details>

<details>
<summary>2. With Form validation:</summary>

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      RzIconTextFormFieldExtended(
        hintText: 'Email',
        labelText: 'Email',
        keyboardType: TextInputType.emailAddress,
        validator: (v) {
          if (v!.isEmpty) return 'Email required';
          if (!v.contains('@')) return 'Invalid email';
          return null;
        },
        showClearIcon: true,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        child: Text('Submit'),
      )
    ],
  ),
)
```
</details>

<details>
<summary>3. Clear button with custom widget:</summary>

```dart
RzIconTextFormFieldExtended(
  hintText: 'Enter name',
  labelText: 'Name',
  showClearIcon: true,
  clearIcon: Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: Icon(Icons.close, size: 12, color: Colors.white),
  ),
  onClearIconTap: () => print('custom clear tapped'),
)
```
</details>

<details>
<summary>4. Controller handling:</summary>

```dart
final controller = TextEditingController();

RzIconTextFormFieldExtended(
  controller: controller,
  hintText: 'Type...',
  labelText: 'With Controller',
  showClearIcon: true,
  onChanged: (v) => print('Text: $v'),
)

IconButton(
  onPressed: () => controller.clear(),
  icon: Icon(Icons.clear),
)
```
</details>

<details>
<summary>All Properties:</summary>

| Property | Type | Default | Description |
|---|---|---|---|
| `controller` | `TextEditingController?` | `null` | Text controller |
| `focusNode` | `FocusNode?` | `null` | Focus node |
| `initialValue` | `String?` | `null` | Initial value if controller is null |
| `hintText` | `String?` | `null` | Hint inside field |
| `labelText` | `String?` | `null` | Floating label on border |
| `helperText` | `String?` | `null` | Helper text below field |
| `errorText` | `String?` | `null` | Error text |
| `prefix` | `Widget?` | `null` | Prefix widget |
| `suffix` | `Widget?` | `null` | Suffix widget |
| `prefixIcon` | `Widget?` | `null` | Prefix icon widget (priority) |
| `suffixIcon` | `Widget?` | `null` | Suffix icon widget (priority) |
| `prefixIconData` | `IconData?` | `null` | Prefix icon data |
| `suffixIconData` | `IconData?` | `null` | Suffix icon data |
| `prefixIconColor` | `Color?` | `null` | Prefix icon color |
| `suffixIconColor` | `Color?` | `null` | Suffix icon color |
| `prefixIconSize` | `double` | `22` | Prefix icon size |
| `suffixIconSize` | `double` | `22` | Suffix icon size |
| `onPrefixIconTap` | `VoidCallback?` | `null` | Prefix icon tap callback |
| `onSuffixIconTap` | `VoidCallback?` | `null` | Suffix icon tap callback |
| `showClearIcon` | `bool` | `false` | Show clear X when field has text |
| `clearIcon` | `Widget?` | `null` | Custom clear widget |
| `clearIconData` | `IconData?` | `null` | Clear icon data (default `Icons.clear`) |
| `clearIconColor` | `Color?` | `null` | Clear icon color |
| `clearIconSize` | `double` | `22` | Clear icon size |
| `onClearIconTap` | `VoidCallback?` | `null` | Clear icon tap callback |
| `style` | `TextStyle?` | `FontSize 14` | Input text style |
| `hintStyle` | `TextStyle?` | `null` | Hint style |
| `labelStyle` | `TextStyle?` | `null` | Floating label style |
| `keyboardType` | `TextInputType?` | `null` | Keyboard type |
| `textInputAction` | `TextInputAction?` | `null` | Text input action |
| `textCapitalization` | `TextCapitalization` | `none` | Text capitalization |
| `textAlign` | `TextAlign` | `start` | Text alignment |
| `enabled` | `bool` | `true` | Enable/disable field |
| `readOnly` | `bool` | `false` | Read-only field |
| `autofocus` | `bool` | `false` | Auto focus |
| `obscureText` | `bool` | `false` | Obscure text |
| `enableSuggestions` | `bool` | `true` | Enable suggestions |
| `autocorrect` | `bool` | `true` | Enable autocorrect |
| `maxLines` | `int?` | `1` | Maximum lines |
| `minLines` | `int?` | `null` | Minimum lines |
| `maxLength` | `int?` | `null` | Maximum character length |
| `expands` | `bool` | `false` | Expand field to fill available space |
| `contentPadding` | `EdgeInsetsGeometry?` | `H16 V14` | Input content padding |
| `borderRadius` | `dynamic` | `8` | Border radius; supports number or `BorderRadius` |
| `borderColor` | `Color?` | `grey` | Default border color |
| `focusedBorderColor` | `Color?` | `primary` | Focused border color |
| `errorBorderColor` | `Color?` | `red` | Error border color |
| `focusedErrorBorderColor` | `Color?` | `red` | Focused error border color |
| `errorBorderWidth` | `double?` | `1.0` | Error border width |
| `focusedErrorBorderWidth` | `double?` | `1.5` | Focused error border width |
| `fillColor` | `Color?` | `null` | Field fill color |
| `filled` | `bool` | `false` | Enable field background fill |
| `cursorColor` | `Color?` | `null` | Cursor color |
| `cursorHeight` | `double?` | `null` | Cursor height |
| `cursorWidth` | `double` | `2` | Cursor width |
| `inputFormatters` | `List<TextInputFormatter>?` | `null` | Input formatters |
| `validator` | `FormFieldValidator<String>?` | `null` | Form validator |
| `onSaved` | `FormFieldSetter<String>?` | `null` | Called when form is saved |
| `autoValidateMode` | `AutovalidateMode?` | `null` | Auto-validation mode |
| `onChanged` | `ValueChanged<String>?` | `null` | Called when text changes |
| `onTap` | `GestureTapCallback?` | `null` | Called when field is tapped |
| `onEditingComplete` | `VoidCallback?` | `null` | Called when editing is complete |
| `onFieldSubmitted` | `ValueChanged<String>?` | `null` | Called when field is submitted |
| `onTapOutside` | `TapRegionCallback?` | `null` | Called when tapping outside field |
| `hideHintOnFocus` | `bool` | `true` | Hide hint when field is focused |
| `hideLabelOnFocusOut` | `bool` | `true` | Show label only when field is focused |
</details>

<details>
<summary>Support:</summary>

### Support:
- Android ✅
- iOS ✅
- Web ✅
- Windows ✅
- macOS ✅
- Linux ✅

Flutter 3.0+ required.

### License:
MIT
</details>

# Author
Rz Rasel
# RzSearchableComboBox

A highly customizable, searchable dropdown combo box for Flutter. Works on **Android, iOS, Web, Windows, macOS, Linux** - no platform-specific code.

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue)
![Platform](https://img.shields.io/badge/platform-all%20platforms-green)
![License](https://img.shields.io/badge/License-MIT-orange)

## Features

- 🔍 Searchable dropdown with debounce (300ms)
- 🌐 Async API search with `onSearch`
- ⌨️ Keyboard navigation (Arrow Up/Down, Enter, Esc)
- 🎨 Fully customizable - border colors, background, icons, itemBuilder
- ✅ Validation support
- 🏷️ Label + Required asterisk
- 📏 Visible item count limit with scroll
- ✨ Smooth animation
- 🧹 Clear icon, Prefix/Suffix icon toggle
- ♿ Disabled state
- 💯 Zero warnings - `KeyboardListener` + `withValues(alpha:)`

### Usages:

## Installation

```dart
import 'package:flutter/material.dart';
import 'package:rz_widget_set_basic/rz_widget_set_basic.dart';
```

<details open>
<summary>Basic:</summary>

```dart
RzSearchableComboBox(
  items: ['English', 'Bangla', 'Hindi', 'Arabic'],
  labelBuilder: (e) => e,
  hintText: 'Search language...',
  onSelected: (index) {
    print('Selected index: $index');
  },
)
```

> Or

```dart
RzSearchableComboBox<String>(
  items: ['English', 'Bangla', 'Hindi', 'Arabic'],
  labelBuilder: (e) => e,
  hintText: 'Search language...',
  onSelected: (index) {
    print('Selected index: $index');
  },
)
```
</details>

<details>
<summary>Full Feature Usage - All Properties:</summary>

```dart
RzSearchableComboBox<User>(
  // ========== REQUIRED ==========
  items: users, // List<T> - your data list
  labelBuilder: (user) => user.name, // String Function(T) - display text
  onSelected: (index) {
    // ValueChanged<int> - returns index of selected item (from filtered list)
    print('Selected original index: $index, User: ${users[index].name}');
  },

  // ========== OPTIONAL CALLBACKS ==========
  onChanged: (text) {
    // ValueChanged<String>? - called on every typing
    print('Typing: $text');
  },
  onSearch: (query) async {
    // Future<List<T>> Function(String)? - Async API search
    // Return new list based on query
    final res = await http.get(Uri.parse('https://api.com?q=$query'));
    return parseUsers(res.body);
  },
  validator: (value) {
    // String? Function(String?)? - validation
    if (value == null || value.isEmpty) return 'Required field';
    return null;
  },
  itemBuilder: (context, user, isSelected, isHighlighted) {
    // Widget Function(BuildContext, T, bool isSelected, bool isHighlighted)?
    // Custom UI for each row
    return Container(
      color: isHighlighted
       ? Colors.blue.withValues(alpha: 0.08)
        : (isSelected? Colors.grey.withValues(alpha: 0.15) : null),
      child: ListTile(
        selected: isSelected,
        leading: CircleAvatar(child: Text(user.name[0])),
        title: Text(user.name, style: TextStyle(fontWeight: isSelected? FontWeight.bold : FontWeight.normal)),
        subtitle: Text(user.email),
        trailing: isSelected? Icon(Icons.check, color: Colors.blue) : null,
      ),
    );
  },

  // ========== INITIAL & TEXTS ==========
  initialIndex: 0, // int? - pre-selected index, shows text on load
  hintText: 'Search user...', // String - placeholder in input
  labelText: 'Select User', // String - label above input
  isRequired: true, // bool - shows red * after labelText
  noResultText: 'No users found!', // String - when filter empty
  errorText: null, // String? - external error (if validator null, use internal _validationError)

  // ========== FONT STYLES ==========
  fontSize: 14, // double - input text + list text size
  fontWeight: FontWeight.w500, // FontWeight - input + list weight
  fontColor: Colors.black87, // Color - input + list color
  noResultFontSize: 13, // double - noResultText size
  noResultFontWeight: FontWeight.w400, // FontWeight - noResult weight
  noResultFontColor: Colors.grey, // Color - noResult color

  // ========== COLORS & BORDER ==========
  comboBoxBackgroundColor: Colors.white, // Color - TextField background
  listBackgroundColor: Colors.white, // Color - dropdown list background
  comboBoxBorderColor: Colors.blue, // Color - TextField border
  listBorderColor: Colors.blue.shade200, // Color - dropdown list border
  borderColor: Color(0xFFE0E0E0), // Color - fallback for both if above not set
  borderRadius: 8, // double - border radius for both

  // ========== DIVIDER ==========
  showDivider: true, // bool - show divider between items
  dividerColor: Color(0xFFEEEEEE), // Color - divider color
  dividerHeight: 1, // double - divider thickness

  // ========== ICONS ==========
  showPrefixIcon: true, // bool - show/hide prefix
  prefixIcon: Icon(Icons.person, color: Colors.blue), // Widget? - custom prefix, default Icons.search
  showSuffixIcon: true, // bool - show/hide dropdown arrow
  suffixIcon: Icon(Icons.keyboard_arrow_down), // Widget? - custom suffix
  showClearIcon: true, // bool - show/hide clear X when text not empty
  clearIcon: Icon(Icons.close, size: 18), // Widget? - custom clear icon

  // ========== BEHAVIOR ==========
  enabled: true, // bool - false = disabled, grey background
  autoSort: true, // bool - auto sort A-Z after filter
  caseSensitive: false, // bool - false = case-insensitive search
  debounceMs: 400, // int - debounce for typing (ms), 300 default
  showScrollbar: true, // bool - show scrollbar in list

  // ========== LIST SIZE ==========
  visibleItemCount: 4, // int - how many items visible, rest scroll. -1 = full list max 300px height
  itemHeight: 56, // double - height of each row
)
```
</details>

<details>
<summary>Validation:</summary>

```dart
RzSearchableComboBox<String>(
  items: items,
  labelBuilder: (e) => e,
  labelText: 'Country',
  isRequired: true,
  validator: (v) => v!.isEmpty? 'Country is required' : null,
  onSelected: (i) {},
)
```
</details>

<details>
<summary>With Label & Borders:</summary>

```dart
RzSearchableComboBox<String>(
  items: ['English', 'Bangla', 'Hindi'],
  labelBuilder: (e) => e,
  labelText: 'Select Language',
  isRequired: true,
  comboBoxBorderColor: Colors.blue,
  listBorderColor: Colors.blue.shade200,
  comboBoxBackgroundColor: Colors.white,
  listBackgroundColor: Colors.grey.shade50,
  borderRadius: 8,
  onSelected: (index) {},
)
```
</details>

<details>
<summary>Custom Item UI (Avatar, Subtitle):</summary>

```dart
RzSearchableComboBox<User>(
  items: users,
  labelBuilder: (u) => u.name,
  itemBuilder: (context, user, isSelected, isHighlighted) {
    return ListTile(
      selected: isSelected,
      tileColor: isHighlighted? Colors.blue.withValues(alpha: 0.08) : null,
      leading: CircleAvatar(child: Text(user.name[0])),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  },
  onSelected: (index) {},
)
```
</details>

<details>
<summary>Async Search (API):</summary>

```dart
RzSearchableComboBox<User>(
  items: initialUsers,
  labelBuilder: (u) => u.name,
  debounceMs: 400,
  onSearch: (query) async {
    // Call your API
    final response = await http.get(Uri.parse('https://api.com/users?q=$query'));
    return parseUsers(response.body);
  },
  onSelected: (index) {},
)
```
</details>

<details>
<summary>GetX Binding:</summary>

### Controller:

```dart
class UserController extends GetxController {
  var users = <User>[].obs;
  var lastFiltered = <User>[].obs;

  Future<List<User>> searchUsers(String query) async {
    await Future.delayed(Duration(milliseconds: 400));
    List<User> result = query.isEmpty
     ? users
      : users.where((u) => u.name.toLowerCase().contains(query.toLowerCase())).toList();
    lastFiltered.value = result;
    return result;
  }

  void onUserSelected(int filteredIndex) {
    final user = lastFiltered[filteredIndex];
    print('Selected: ${user.name}');
  }
}
```

### Binding:
```dart
class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
```

### View:
```dart
class UserPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => RzSearchableComboBox<User>(
      items: controller.users,
      labelBuilder: (u) => u.name,
      onSearch: (q) => controller.searchUsers(q),
      onSelected: (i) => controller.onUserSelected(i),
    ));
  }
}
```
</details>

<details>
<summary>All Properties:</summary>

| Property | Type | Default | Description |
|---|---|---|---|
| `items` | `List<T>` | `required` | List of data |
| `labelBuilder` | `String Function(T)` | `required` | Display text |
| `onSelected` | `ValueChanged<int>` | `required` | Returns selected index |
| `onChanged` | `ValueChanged<String>?` | `null` | Called when typing |
| `onSearch` | `Future<List<T>> Function(String)?` | `null` | Async API search |
| `itemBuilder` | `Widget Function?` | `null` | Custom item UI |
| `validator` | `String? Function?` | `null` | Validation |
| `initialIndex` | `int?` | `null` | Pre-selected index |
| `hintText` | `String` | `'Search...'` | Hint text |
| `labelText` | `String` | `''` | Top label |
| `isRequired` | `bool` | `false` | Show `*` |
| `noResultText` | `String` | `'No result found'` | Empty result text |
| `errorText` | `String?` | `null` | Error text |
| `comboBoxBorderColor` | `Color` | `#E0E0E0` | Input border color |
| `listBorderColor` | `Color` | `#E0E0E0` | List border color |
| `borderColor` | `Color` | `#E0E0E0` | Both borders (fallback) |
| `comboBoxBackgroundColor` | `Color` | `white` | Input background color |
| `listBackgroundColor` | `Color` | `white` | List background color |
| `borderRadius` | `double` | `6` | Border radius |
| `showPrefixIcon` | `bool` | `true` | Show/hide search icon |
| `prefixIcon` | `Widget?` | `Icon(search)` | Custom prefix icon |
| `showSuffixIcon` | `bool` | `true` | Show/hide dropdown arrow |
| `suffixIcon` | `Widget?` | `Icon(arrow_drop_down)` | Custom suffix icon |
| `showClearIcon` | `bool` | `true` | Show/hide clear icon |
| `clearIcon` | `Widget?` | `Icon(clear)` | Custom clear icon |
| `showDivider` | `bool` | `true` | Show/hide divider between items |
| `visibleItemCount` | `int` | `5` | Visible items; `-1` = full list, max 300px |
| `itemHeight` | `double` | `48` | Item height |
| `enabled` | `bool` | `true` | Enable/disable widget |
| `autoSort` | `bool` | `false` | Auto-sort A-Z |
| `caseSensitive` | `bool` | `false` | Case-sensitive search |
| `debounceMs` | `int` | `300` | Search debounce duration in milliseconds |
| `showScrollbar` | `bool` | `true` | Show/hide scrollbar |
</details>

<details>
<summary>Support:</summary>

## Keyboard Support:
- Arrow Down - Next item
- Arrow Up - Previous item
- Enter - Select highlighted
- Esc - Close dropdown

## Platform Support:
- Android ✅
- iOS ✅
- Web ✅
- Windows ✅
- macOS ✅
- Linux ✅

## License:
MIT
</details>

# Author
Rz Rasel
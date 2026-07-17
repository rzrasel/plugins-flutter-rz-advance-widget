# rz_advance_widget

**Flutter Plugins Rz Widget Set Basic** is a lightweight, production-ready collection of essential Flutter widgets that you use in every app.

Instead of writing same TextField decoration again and again, this package gives you ready-made, highly customizable basic widgets with modern UI - animated floating label on border, clear button, password visibility toggle, searchable dropdown with async API support, and full Form validation.

### Built with:
- No third-party dependency (only Flutter SDK)
- All platforms support (Android, iOS, Web, Windows, macOS, Linux)
- Zero warnings - using `withValues(alpha:)` and `KeyboardListener`
- Proper internal handling of `FocusNode` & `TextEditingController` (no memory leak)
- MIT Licensed

This is the **Basic Set** - contains only core inputs. More sets coming (Buttons, Layouts, Animations).

Repo: https://github.com/rzrasel/plugins-flutter-rz-advance-widget

## Installation

Add the dependency to your `pubspec.yaml`:

```bash
cached_network_image: ^3.4.1
```

```yaml
dependencies:
  rz_advance_widget:
    git:
      url: https://github.com/rzrasel/plugins-flutter-rz-advance-widget.git
      ref: v1.0.0
```

```bash
git tag v1.0.0
git push origin v1.0.0
```

## Features

<details>
<summary>General Features (All Widgets):</summary>

- ✅ Works on All Platforms
- ✅ No External Package Dependency
- ✅ Fully Customizable - Colors, Borders, Radius, Fonts, Padding, Icons
- ✅ Form Support - validator, onSaved, autoValidateMode
- ✅ Controller + initialValue both supported
- ✅ Production Ready - internal FocusNode/Controller management
</details>

<details>
<summary>Text Field Features:</summary>

- ✅ Animated floating label on border (Extended version) - label floats to top -8 with animation
- ✅ hideHintOnFocus - hint hides when focused
- ✅ hideLabelOnFocusOut - control when label shows (only on focus or on text too)
- ✅ floatHintToBorder - hint floats to border like label
- ✅ prefixIcon / suffixIcon as Widget OR IconData
- ✅ onPrefixIconTap / onSuffixIconTap
- ✅ showClearIcon + clearIcon - X button shows only when typing
- ✅ Clear + suffixIcon both visible together (Row)
- ✅ clearIconData, clearIconColor, clearIconSize, onClearIconTap
- ✅ borderRadius accepts both `num` (8) or `BorderRadius.circular(8)`
- ✅ borderColor, focusedBorderColor, errorBorderColor, widths
- ✅ filled, fillColor, contentPadding, cursor customization
- ✅ style, hintStyle, labelStyle
</details>

<details>
<summary>Password Field Features:</summary>

- ✅ All TextField features +
- ✅ obscureText with visibility toggle
- ✅ showVisibilityToggle
- ✅ visibilityIcon / visibilityOffIcon
- ✅ showClearIcon + visibility toggle both together (X + eye)
</details>

<details>
<summary>Searchable ComboBox Features:</summary>

- ✅ Generic `RzSearchableComboBox<T>` - works with String, Model, any object
- ✅ labelBuilder to show text from object
- ✅ Searchable with debounce (default 300ms, customizable)
- ✅ Async API search - onSearch returns `Future<List<T>>`
- ✅ Keyboard navigation - Arrow Up/Down, Enter to select, Esc to close
- ✅ Custom itemBuilder - avatar, subtitle, check icon
- ✅ showPrefixIcon / showSuffixIcon / showClearIcon toggle
- ✅ showDivider + dividerColor
- ✅ visibleItemCount + itemHeight - control dropdown height
- ✅ autoSort, caseSensitive, showScrollbar
- ✅ comboBoxBorderColor vs listBorderColor separate control
- ✅ Smooth animation + overlay positioning
</details>

---

## 🧰 Git Commands

```bash
git init
git remote add origin https://github.com/rzrasel/plugins-flutter-rz-advance-widget.git
git remote -v
git fetch && git checkout master
git add .
git commit -m "Add Readme & Git Commit File"
git pull
git push --all
git status
git status
```

Recommended fix
```bash
git fetch origin
git pull --rebase origin master
git push origin master
```

⚠️ This permanently discards your uncommitted changes:

```bash
git restore .
git pull --rebase origin master
git push origin master
```

Since you're working on the README/workflow and likely want to keep your changes, use:

```bash
git stash
git pull --rebase origin master
git stash pop
git push origin master
```

## Fix - recommended

Delete all Pub cache - Bash

```bash
rm -rf ~/.pub-cache

rm -rf "$LOCALAPPDATA/Pub/Cache"
```

If you only want to delete Git plugin caches

```bash
rm -rf "$LOCALAPPDATA/Pub/Cache/git"
```

Close your Flutter IDE and run:

```bash

flutter pub cache repair
flutter clean
flutter pub get

```

## 🧩 Git Delete All Tag(s) From Remote:

```bash
git ls-remote --tags origin
git tag -l | xargs -n 1 git tag -d
git ls-remote --tags origin \
  | awk -F/ '/refs\/tags\// && !/\^\{\}$/ {print $3}' \
  | while read tag; do
      git push origin --delete "$tag"
    done
```

If you only want to delete vref-* tags

```bash
git tag -l "vref-*" | while read tag; do
    git tag -d "$tag"
    git push origin --delete "$tag"
done
```

## 🧩 Git Rebase Squash (Interactive)

```bash
git rebase -i HEAD~2
i
[delete word: pick [make it] squash/s]
esc:wq↵

i
[change commit comment by #]
esc:wq↵

------------------------------------

git rebase -i 4daac6b7
i
[delete word: pick [make it] squash/s]
esc:wq↵

i
[change commit comment by #]
esc:wq↵

git push --force
//git push -f --set-upstream origin master

------------------------------------

git rebase -i --root
i
[delete word: pick [make it] squash/s]
esc:wq↵

i
[change commit comment by #]
esc:wq↵

git push --force

//git push -f --set-upstream origin master
```

---

## ⏰ PHP Date Example

```php
echo date("D", (time() + 6 * 60 * 60)) . "day " . date("F j, Y, G:i:s", (time() + 6 * 60 * 60));
```

---

## 📚 Learn More

👉 https://youtu.be/V5KrD7CmO4o

---

## ✅ Done!
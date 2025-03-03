# Step 5: Setup layout

The main focus of this step is to setup the layout of the application. We'll use the `Placeholder` widget to simulate the components, such as chat list and text input. The text input will have a fixed height, and the chat list will take the rest of the space.

    +----------------------------------+
    | +------------------------------+ |
    | |              ▲               | |
    | |              │               | |
    | |              │               | |
    | |              │               | |
    | |              │               | |
    | |     Placeholder(ChatList)    | |
    | |              │               | |
    | |              │               | |
    | |              │               | |
    | |              │               | |
    | |              ▼               | |
    | +------------------------------+ |
    | +------------------------------+ |
    | |    Placeholder(TextInput)    | |
    | |                              | |
    | +------------------------------+ |
    +----------------------------------+

---

## Lay out multiple widgets vertically and horizontally (Column and Row)

One of the most common layout patterns is to arrange widgets vertically or horizontally. You can use a `Row` widget to arrange widgets horizontally and a `Column` widget to arrange widgets vertically.

To create a row or column in Flutter, you add a list of children widgets to a `Row` or `Column` widget. In turn, each child can itself be a row or column, and so on. The following example shows how it is possible to nest rows or columns inside of rows or columns.

```dart
Column( // Or Row for horizontal layout
  children: [
    SomeWidget(),
    SomeOtherWidget(),
  ],
)
```

[Flex documentation](https://api.flutter.dev/flutter/widgets/Flex-class.html)

## Expanded and Flexible

`Expanded` and `Flexible` are widgets that can be used to expand or shrink a widget to fill the available space. Those two widgets are used to fill the available space under `Flex` widgets (`Column` or `Row`).  

Using an `Expanded` widget makes a child of a `Row`, `Column`, or `Flex` expand to fill the available space along the main axis (e.g., horizontally for a `Row` or vertically for a `Column`). If multiple children are expanded, the available space is divided among them according to the flex factor.

Using a `Flexible` widget gives a child of a `Row`, `Column`, or `Flex` the flexibility to expand to fill the available space in the main axis (e.g., horizontally for a `Row` or vertically for a `Column`), but, unlike `Expanded`, `Flexible` does not require the child to fill the available space.

```dart
Expanded(
  child: Text('Hello'),
)
```

[Expanded documentation](https://api.flutter.dev/flutter/widgets/Expanded-class.html)  
[Flexible documentation](https://api.flutter.dev/flutter/widgets/Flexible-class.html)

## Placeholder

The `Placeholder` is a useful `Widget` during development and prototyping user interface time. Just put `Placeholder` in your code, and you'll see a box with a cross in it. It's a great way to see the layout of your app without implementing the entire UI.
You can think this way, `Placeholder` is [Lorem Ipsum](https://www.lipsum.com/) for `Widget`.

Placeholder has a `fallbackHeight` property to specify the height or `fallbackWidth` property to specify the width of the placeholder.

```dart
Placeholder(
  // optional
  fallbackHeight: 64,
)
```

[Placeholder documentation](https://api.flutter.dev/flutter/widgets/Placeholder-class.html)

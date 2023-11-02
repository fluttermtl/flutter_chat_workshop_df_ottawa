# Step 4: First page

We just finished the basic setup of our application. Let's create the first page.
In this step, we'll practice how to use `Scaffold` and `AppBar` to create a page.

---

## Scaffold

`Scaffold` describes the Material Design visual layout structure. It makes it easy to implement the Material Design layout and use some Material Design features like `AppBar` or `FloatingActionButton`, along with features like dialog, bottom sheet, etc.

- `AppBar`: An app bar to display at the top of the `Scaffold`.
- `body`: The primary content of the `Scaffold`.
- `floatingActionButton`: A button displayed floating above `body`, in the bottom right corner.

```dart
Scaffold(
  appBar: AppBar(
    title: Text('Title'),
  ),
  body: Text('Body'),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)
```

[Scaffold documentation](https://api.flutter.dev/flutter/material/Scaffold-class.html)

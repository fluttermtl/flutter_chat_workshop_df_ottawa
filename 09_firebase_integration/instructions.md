# Step 9: Firebase Integration

Now, we want to make our app able to send and receive remotely. We'll use Firebase as the database. We'll send a message to store in the database. Once the message is stored, the application displays the updated list of messages.

*You don't need to worry about Firebase Configuration for this Workshop. We'll provide a pre-configured Firebase for you.*

Here is the document structure in the Firestore database:

- `name` [String] Name of the user
- `message` [String] Text of the message
- `time` [int] Date and time of the message in milliseconds(Epoch)

---

## Firestore collection and document

Firestore collection is accessible using the `collection` method that returns a `CollectionReference`. It has an `orderBy` method to sort the documents by a property.

```dart
final regularCollection = FirebaseFirestore.instance.collection("subject");

// from Z to A
final orderedCollection = collectionReference.orderBy("name", descending: true);
```

The `get` method of a `CollectionReference` returns documents of the collection. To be notified of changes in the collection, use the `snapshots` method. It returns a `Stream<QuerySnapshot>`.

```dart
final stream = collectionReference.snapshots();
```

[CollectionReference documentation](https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/CollectionReference-class.html)  
[orderBy documentation](https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/Query/orderBy.html)  
[snapshots documentation](https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/Query/snapshots.html)

## StreamBuilder

`StreamBuilder` is a widget that builds itself based on the latest snapshot of interaction with a `Stream`. It automatically synchronizes the widget with the latest data and changes in the stream.

```dart
StreamBuilder<T>(
  stream: stream,
  builder: (context, snapshot) {
    // snapshot.connectionState for status
    // snapshot.hasData to know if data is available
    // snapshot.hasError to know if there is an error

    return Text(snapshot.hasData ? snapshot.data!.toString() : '');
  }
)
```

[StreamBuilder documentation](https://pub.dev/documentation/flutter/widgets/StreamBuilder-class.html)

## Create a document / message

To create a document in a collection, we use the `add()` method of the `CollectionReference` class.

```dart
final data = <String, dynamic>{
  "firstname": 'John',
  "height": 6,
};

FirebaseFirestore.instance.collection("subject").add(data);
```

[add documentation](https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/CollectionReference/add.html)

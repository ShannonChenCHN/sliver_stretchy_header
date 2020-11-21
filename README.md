# sliver_stretch_header

Flutter implementation of stretchable header with a background as a sliver.

```
             /--------------/  --
            /              /   /
           /  background  /   /  
          /              /   /
       /-------------/  /   /  stretchable 
      /    child    /  /   /
     /             /  /   /
    /-------------/  /   /
     /--------------/  --
``` 

## Features

* Accepts one widget as child.
* Accepts one widget as a background.
* No other arguments required besides `minStretchExtent`.
* Can stretch to fill the over-scroll area when the user over-scrolls.

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  sliver_stretch_header:
```

In your library add the following import:

```dart
import 'package:sliver_stretch_header/sliver_stretch_header.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## SliverStretchHeader

You can place your `SliverStretchHeader` inside a `CustomScrollView`(normally at 1st or 2nd place).

```dart
SliverStretchHeader(
  minStretchExtent: 100,    
  background: Container(
                color: Colors.red,
              ),
  child: Container(
          color: Colors.green,
          height: 60,
          child: Center(child: Text("Child Widget")),
         ),
),
```

You can find more details in the [Example](https://github.com/ShannonChenCHN/sliver_stretch_header/tree/master/example) project.

## Thanks

:clap: Thanks to [flutter_sticky_header](https://github.com/letsar/flutter_sticky_header) for giving me inspiration and encouragement to work in this project.

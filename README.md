# sliver_stretchy_header

A sliver that contains a bottom-aligned box child and a stretchy box background.

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

* Accepts one box widget as child.
* Accepts one box widget as a background.
* No other arguments required besides `minBlankExtent`.
* Can stretch to fill the over-scroll area when the user over-scrolls.

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  sliver_stretchy_header:
```

In your library add the following import:

```dart
import 'package:sliver_stretchy_header/sliver_stretchy_header.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Usage

You can place your `SliverStretchyHeader` inside a `CustomScrollView`, Typically this will be the first or the second sliver in a viewport.

```dart
SliverStretchyHeader(
  minBlankExtent: 100,    
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

You can find more details in the [Example](https://github.com/ShannonChenCHN/sliver_stretchy_header/tree/master/example) project.

## Thanks

:clap: Thanks to [flutter_sticky_header](https://github.com/letsar/flutter_sticky_header) for giving me inspiration and encouragement to work in this project.

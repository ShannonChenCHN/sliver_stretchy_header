# sliver_stretch_header

A sliver that contains a bottom-aligned box child and a stretchy box background.

[![Pub](https://img.shields.io/pub/v/sliver_stretch_header)](https://pub.dev/packages/sliver_stretch_header)

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
  sliver_stretch_header:
```

In your library add the following import:

```dart
import 'package:sliver_stretch_header/sliver_stretch_header.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Usage

You can place your `SliverStretchHeader` inside a `CustomScrollView`(normally at 1st or 2nd place).

```dart
SliverStretchHeader(
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

You can find more details in the [Example](https://github.com/ShannonChenCHN/sliver_stretch_header/tree/master/example) project.

## Thanks

:clap: Thanks to [flutter_sticky_header](https://github.com/letsar/flutter_sticky_header) for giving me inspiration and encouragement to work in this project.

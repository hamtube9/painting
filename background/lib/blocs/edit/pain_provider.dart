
import 'package:background/blocs/edit/paint_bloc.dart';
import 'package:flutter/material.dart';

class PaintProvider extends InheritedWidget {
  final PaintBloc? bloc;
  final Widget child;

  const PaintProvider({
    Key? key,
    this.bloc,
    required this.child,
  }) : super(key: key, child: child);

  static PaintBloc? of(BuildContext context) => context.findAncestorWidgetOfExactType<PaintProvider>()?.bloc;

  @override
  bool updateShouldNotify(covariant PaintProvider oldWidget) => true;
}
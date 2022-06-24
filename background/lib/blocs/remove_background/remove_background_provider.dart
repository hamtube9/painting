
import 'package:background/blocs/edit/paint_bloc.dart';
import 'package:background/blocs/remove_background/remove_background_bloc.dart';
import 'package:flutter/material.dart';

class RemoveBackgroundProvider extends InheritedWidget {
  final RemoveBackgroundBloc? bloc;
  final Widget child;

  const RemoveBackgroundProvider({
    Key? key,
    this.bloc,
    required this.child,
  }) : super(key: key, child: child);

  static RemoveBackgroundBloc? of(BuildContext context) => context.findAncestorWidgetOfExactType<RemoveBackgroundProvider>()?.bloc;

  @override
  bool updateShouldNotify(covariant RemoveBackgroundProvider oldWidget) => true;
}
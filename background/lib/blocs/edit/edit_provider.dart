
import 'package:background/blocs/edit/edit_bloc.dart';
import 'package:flutter/material.dart';

class EditProvider extends InheritedWidget {
  final EditBloc? bloc;
  final Widget child;

  const EditProvider({
    Key? key,
    this.bloc,
    required this.child,
  }) : super(key: key, child: child);

  static EditBloc? of(BuildContext context) => context.findAncestorWidgetOfExactType<EditProvider>()?.bloc;

  @override
  bool updateShouldNotify(covariant EditProvider oldWidget) => true;
}
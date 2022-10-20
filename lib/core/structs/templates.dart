import 'dart:developer';

import 'package:format/format.dart';

enum TemplateAction { create, move, copy, delete }

class TemplatesFiles {
  final String? root;
  final TemplateAction action;
  final List<String>? tree;
  Map<String, String>? variables;
  final String? name;
  final String? ext;
  String? content;

  TemplatesFiles(
      {this.root = 'austro',
      this.action = TemplateAction.create,
      this.tree,
      this.variables,
      this.name,
      this.ext,
      this.content});

  String? build() {
    if (variables != null) {
      final String formatear = content!.format(variables!);
      return formatear;
    }

    log('Error al parsear cadena de contenido con variables');
    return null;
  }
}

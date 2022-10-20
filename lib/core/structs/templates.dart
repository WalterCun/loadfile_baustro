enum TemplateAction { create, move, copy, delete }

class TemplatesFiles {
  final String? root;
  final TemplateAction action;
  final List<String>? tree;
  final String? name;
  final String? ext;
  final String? content;

  TemplatesFiles(
      {this.root = 'austro',
      this.action = TemplateAction.create,
      this.tree,
      this.name,
      this.ext,
      this.content});
}

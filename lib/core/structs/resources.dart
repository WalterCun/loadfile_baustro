import 'package:loadfile_baustro/apps/home/shops.dart';

class GenericResources {
  late final String path;
  late final String? tree;
  late final String? filename;
  late final String? ext;

  GenericResources({required this.path}) {
    final data = getData(this.path);

    this.tree = data['tree'];
    this.filename = data['filename'];
    this.ext = data['ext'];
  }

  Map getData(String path) {
    String fileName = path.split("\/").last;
    String treeDir = path.replaceAll('/$fileName', '');

    if (!fileName.contains('.')) {
      return {'filename': fileName, 'ext': null};
    }

    String fileExtension = fileName.split('.').last;

    return {'tree': treeDir, 'filename': fileName, 'ext': fileExtension};
  }
}

class Imagen extends GenericResources {
  Imagen({required super.path});
}

class Gif extends GenericResources{
  Gif({required super.path});
}

class Video extends GenericResources {
  Video({required super.path});
}

class Audio extends GenericResources {
  Audio({required super.path});
}

class Fonts extends GenericResources {
  Fonts({required super.path});
}

class Plantillas extends GenericResources {
  Plantillas({required super.path});
}

class Keys extends GenericResources {
  Keys({required super.path});
}

class Configuraciones extends GenericResources {
  Configuraciones({required super.path});
}

class Certificados extends GenericResources {
  Certificados({required super.path});
}

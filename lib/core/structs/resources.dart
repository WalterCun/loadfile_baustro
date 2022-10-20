import 'dart:developer';

class GenericResources {
  String path;
  String? tree;
  String? filename;
  String? ext;

  GenericResources({required this.path}) {
    final data = _getData(path);

    tree = data['tree'];
    filename = data['filename'];
    ext = data['ext'];
  }

  Map _getData(String path) {
    log('Crear MetaData de $path');
    final Map meta = {};

    String fileName = path.split(RegExp(r"[\|/]")).last;
    meta.addAll({'filename': fileName});

    String treeDir = path.replaceAll('$fileName', '');
    meta.addAll({'tree': treeDir});

    String fileExtension = fileName.split('.').last;
    meta.addAll({'ext': fileExtension});

    if (!fileName.contains('.')) {
      meta.addAll({'ext': null});
    }

    return meta;
  }
}

class Imagen extends GenericResources {
  Imagen({required super.path});
}

class Gif extends GenericResources {
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

import 'dart:developer';

import 'package:format/format.dart';
import 'package:loadfile_baustro/core/db/manager.dart';
import 'package:path/path.dart';

import '../../core/archives/manipulations.dart';

final data = DataProvider();

void createShopFiles() {
  log('${data.pathInput!}');
  log('${data.nameShop!}');
  log('${'logo_{:012d}'.format(int.parse(data.codeShop!))}');
  log('${data.pathLogo}');

  if (data.pathLogo != null) {
    String output = join(data.pathInput!, data.nameShop!, 'austro', 'logos',
        'logo_{:012d}.bmp'.format(int.parse(data.codeShop!)));
    transfer(data.pathInput, to: output);

    // log(output,name: 'createShopFile');
  }

  // writeFile(pathFilename: '', content: '');
}

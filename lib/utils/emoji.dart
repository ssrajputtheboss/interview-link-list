
import 'package:flutter/cupertino.dart';

final EMOJI_DIMENSION = 16.0;
Image imageByAsset(String path){
  return Image(image: AssetImage(path),width: EMOJI_DIMENSION,height: EMOJI_DIMENSION,);
}
class Emoji{
  static final Map<String,Image> get = {
    ':pepe_dance:' : imageByAsset('assets/images/pepe_dance.gif'),
    ':among_us_dance:' : imageByAsset('assets/images/among_us_dance.gif'),
    ':celebration:' : imageByAsset('assets/images/celebration.png'),
    ':doge_dance:' : imageByAsset('assets/images/doge-dance.gif'),
    ':blob_guitar:' : imageByAsset('assets/images/blob_guitar.gif'),
    ':node_js:': imageByAsset('assets/images/node_js.png'),
    ':verify_black:': imageByAsset('assets/images/verify_black.gif'),
    ':pepe_coolclap:': imageByAsset('assets/images/pepe_coolclap.gif'),
    ':cool_doge:': imageByAsset('assets/images/cool_doge.gif'),
    ':jerry_vibe:': imageByAsset('assets/images/jerry_vibe.gif'),
    ':vscode:': imageByAsset('assets/images/vscode.png'),
    ':code_blocks:': imageByAsset('assets/images/code_blocks.png'),
    ':java:': imageByAsset('assets/images/java.png'),
    ':cat_dance:': imageByAsset('assets/images/cat_dance.gif'),
  };
}
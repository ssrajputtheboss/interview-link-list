import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

Map<String, Map> indexJson = Map();

Future<void> setIndexJSON() async {
  indexJson = Map.from(await jsonDecode(
      (await rootBundle.loadString("assets/data/index.json",cache: true)).toString()));
  indexJson.forEach((key, value) {
    indexJson[key] = Map.from(value);
    indexJson[key]?.forEach((k, v) {
      indexJson[key]?[k] = List<int>.from(v);
    });
  });
}

List<int> search(String channel, List<String> keywords) {
  HashSet<int> set = HashSet();
  if (indexJson.isEmpty) return set.toList();
  for (String keyword in keywords) {
    keyword = keyword.toLowerCase();
    if (indexJson.containsKey(keyword))
      set.addAll(indexJson[keyword]?['$channel']);
  }
  return set.toList();
}

Future<void> indexer() async {
  final channels = ['javascript', 'java','node_js','react_js','mongodb','postgresql','python','android'];
  var indexMap = new Map<String,Map<String,List<int>>>();
  final re = RegExp(r"([^a-zA-Z0-9'_])+", dotAll: true);
  final doWork = () async {
    channels.forEach((String channel) async {
      final data =
          (await rootBundle.loadString("assets/data/$channel.json")).toString();
      int i = 0;
      (jsonDecode(data))[channel].forEach((e) {
        e['msg'].split(re).toSet().forEach((String word) {
          word = word.toLowerCase();
          if (word.trim().isNotEmpty) {
            indexMap[word] =
                indexMap.containsKey(word) ? indexMap[word]! : Map<String,List<int>>();
            if(!indexMap[word]!.containsKey('$channel'))
              indexMap[word]?['$channel'] = [];
            indexMap[word]?['$channel']?.add(i);
          }
        });
        ++i;
      });
    });
  };
  await doWork();
  String encoded = jsonEncode(indexMap);
  final file = File('assets/data/index.json');
  if (file.existsSync())
    file.writeAsStringSync(beautifyJson(encoded.toString()));
}

String beautifyJson(String jsonString, {final tabSpace = 1}) {
  final tab = " " * tabSpace;
  int i = 0;
  var ans = '';
  for (int k = 0; k < jsonString.length; ++k) {
    if ('{['.contains(jsonString[k])) {
      i++;
      ans += jsonString[k] + '\n' + tab * i;
    } else if (',' == jsonString[k])
      ans += jsonString[k] + '\n' + tab * i;
    else if ('}]'.contains(jsonString[k])) {
      --i;
      ans += '\n' + tab * i + jsonString[k];
    } else
      ans += jsonString[k];
  }
  return ans;
}

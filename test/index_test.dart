import 'package:flutter_test/flutter_test.dart';
import 'package:interview_link_list/algorithm/index.dart';

void main() {
  //added this because test function doesn't work without it
  group('all indexing tests', () {
    testWidgets('nothing', (t) async {
      return;
    });

    test('indexer test', () async {
      await indexer();
    });

    test('search test', () async {
      await setIndexJSON();
      assert(search('java', ['oop', 'waste']).length == 1);
    });

    test('beautify test', () async {
      assert(beautifyJson('{}') == '{\n \n}');
    });
  });

}

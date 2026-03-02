import 'package:native_toolchain_c/native_toolchain_c.dart';
import 'package:logging/logging.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    final packageName = input.packageName;
    final cbuilder = CBuilder.library(
      name: packageName,
      assetName: packageName,
      language: Language.cpp,
      sources: [
        'src/flutter_dubov_system_native.cpp',
        'src/CPPDubovSystem/DubovSystem/Player.cpp',
        'src/CPPDubovSystem/DubovSystem/Tournament.cpp',
        'src/CPPDubovSystem/DubovSystem/explain.cpp',
        'src/CPPDubovSystem/DubovSystem/baku.cpp',
        'src/CPPDubovSystem/DubovSystem/LinkedList.cpp',
        'src/CPPDubovSystem/DubovSystem/graph util/Graph.cpp',
        'src/CPPDubovSystem/DubovSystem/graph util/Matching.cpp',
        'src/CPPDubovSystem/DubovSystem/graph util/BinaryHeap.cpp',
        'src/CPPDubovSystem/DubovSystem/trf util/trf.cpp',
        'src/CPPDubovSystem/DubovSystem/trf util/rtg.cpp',
      ],
    );
    await cbuilder.run(
      input: input,
      output: output,
      logger: Logger('')
        ..level = .ALL
        ..onRecord.listen((record) => print(record.message)),
    );
  });
}

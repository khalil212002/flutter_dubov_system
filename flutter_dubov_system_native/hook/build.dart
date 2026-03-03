import 'package:code_assets/code_assets.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';
import 'package:logging/logging.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    final packageName = input.packageName;
    final targetOS = input.config.code.targetOS;

    final cbuilder = CBuilder.library(
      name: packageName,
      assetName: packageName,
      language: Language.cpp,
      cppLinkStdLib: targetOS == OS.android ? 'c++_static' : null,
      sources: [
        'src/flutter_dubov_system_native.cpp',
        'src/CPPDubovSystem/DubovSystem/Player.cpp',
        'src/CPPDubovSystem/DubovSystem/Tournament.cpp',
        'src/CPPDubovSystem/DubovSystem/explain.cpp',
        'src/CPPDubovSystem/DubovSystem/baku.cpp',
        'src/CPPDubovSystem/DubovSystem/LinkedList.cpp',
        'src/CPPDubovSystem/DubovSystem/graph_util/Graph.cpp',
        'src/CPPDubovSystem/DubovSystem/graph_util/Matching.cpp',
        'src/CPPDubovSystem/DubovSystem/graph_util/BinaryHeap.cpp',
        'src/CPPDubovSystem/DubovSystem/trf_util/trf.cpp',
        'src/CPPDubovSystem/DubovSystem/trf_util/rtg.cpp',
      ],
      flags: [
        if (targetOS == OS.windows) ...[
          '/std:c++20',
          '/permissive-',
          '/EHsc',
        ] else if (targetOS == OS.android) ...[
          '-std=c++20',
          '-fexceptions',
          '-frtti',
          '-lc++abi',
          '-lunwind',
        ] else ...[
          '-std=c++20',
        ],
      ],
    );

    await cbuilder.run(
      input: input,
      output: output,
      logger: Logger('')
        ..level = .ALL
        // ignore: avoid_print
        ..onRecord.listen((record) => print(record.message)),
    );
  });
}

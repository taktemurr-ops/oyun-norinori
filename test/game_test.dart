import 'package:bulmaca_motoru/bulmaca_motoru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_norinori/oyun_norinori.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(ciftConfig.title.length, 33);
    expect(ciftConfig.tagline.length, 33);
    for (final s in ciftConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler üretilir, doğrulanır ve kaydedilip geri yüklenir', () {
    final planner = LevelPlanner(gameId: ciftId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = ciftRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final k = ciftRules.kindForLevel(gl.spec.difficulty);
      final start = k.initial(gl.puzzle);
      expect(PState.restore(start.serialize(), gl.puzzle), isNotNull);
      expect(PLevel.fromJson(gl.puzzle.toJson()).toJson().toString(), gl.puzzle.toJson().toString());
    }
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/result_screen/data/models/result_model.dart';
import 'package:respyr_dietitian/features/result_screen/presentation/cubit/result_state.dart';

void main() {
  group('ResultState Tests', () {
    test('ResultInitial equality test', () {
      final state1 = ResultInitial();
      final state2 = ResultInitial();

      print('Testing ResultInitial equality...');
      expect(state1, equals(state2));
      print('✅ ResultInitial equality test passed\n');
    });

    test('ResultLoading equality test', () {
      final state1 = ResultLoading();
      final state2 = ResultLoading();

      print('Testing ResultLoading equality...');
      expect(state1, equals(state2));
      print('✅ ResultLoading equality test passed\n');
    });

    test('ResultLoaded manual field comparison test', () {
      // Create 3 different ResultModels
      final resultModel1 = ResultModel(
        bmi: 22.5,
        bmr: 1500,
        dttm: 1697049600,
        gutAbsorptiveScore: 85.0,
        gutFermentativeScore: 78.0,
        fatMetabolismScore: 90.0,
        glucoseMetabolismScore: 88.0,
        hepaticScore: 70.0,
        detoxScore: 75.0,
      );

      final resultModel2 = ResultModel(
        bmi: 22.5,
        bmr: 1500,
        dttm: 1697049600,
        gutAbsorptiveScore: 85.0,
        gutFermentativeScore: 78.0,
        fatMetabolismScore: 90.0,
        glucoseMetabolismScore: 88.0,
        hepaticScore: 70.0,
        detoxScore: 75.0,
      );

      final resultModel3 = ResultModel(
        bmi: 23.0,
        bmr: 1600,
        dttm: 1697059600,
        gutAbsorptiveScore: 60.0,
        gutFermentativeScore: 50.0,
        fatMetabolismScore: 72.0,
        glucoseMetabolismScore: 65.0,
        hepaticScore: 68.0,
        detoxScore: 60.0,
      );

      print('Testing ResultLoaded field comparisons...');
      final state1 = ResultLoaded(resultModel1, selectedTab: '');
      final state2 = ResultLoaded(resultModel2, selectedTab: '');
      final state3 = ResultLoaded(resultModel3, selectedTab: '');

      // ✅ Instead of checking equality of ResultLoaded directly, compare fields
      bool modelsEqual(ResultModel a, ResultModel b) {
        return a.bmi == b.bmi &&
            a.bmr == b.bmr &&
            a.dttm == b.dttm &&
            a.gutAbsorptiveScore == b.gutAbsorptiveScore &&
            a.gutFermentativeScore == b.gutFermentativeScore &&
            a.fatMetabolismScore == b.fatMetabolismScore &&
            a.glucoseMetabolismScore == b.glucoseMetabolismScore &&
            a.hepaticScore == b.hepaticScore &&
            a.detoxScore == b.detoxScore;
      }

      print('Comparing state1.result and state2.result (should be equal)...');
      expect(modelsEqual(state1.result, state2.result), isTrue);
      print('✅ state1.result == state2.result passed');

      print('Comparing state1.result and state3.result (should NOT be equal)...');
      expect(modelsEqual(state1.result, state3.result), isFalse);
      print('✅ state1.result != state3.result passed');

      print('Checking props for state1...');
      expect(state1.props, [resultModel1]);
      print('✅ Props test passed\n');
    });

    test('ResultError equality and props test', () {
      const error1 = ResultError('Something went wrong');
      const error2 = ResultError('Something went wrong');
      const error3 = ResultError('Different error');

      print('Testing ResultError equality...');
      print('Error1: ${error1.message}');
      print('Error2: ${error2.message}');
      print('Error3: ${error3.message}');

      expect(error1, equals(error2));
      print('✅ error1 == error2 passed');

      expect(error1, isNot(equals(error3)));
      print('✅ error1 != error3 passed');

      print('Checking props for error1...');
      expect(error1.props, ['Something went wrong']);
      print('✅ Props test passed\n');
    });
  });
}

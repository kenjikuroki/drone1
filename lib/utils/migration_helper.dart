import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../config/app_identity.dart';
import 'prefs_helper.dart';

class MigrationHelper {
  static const String _migratedKey = 'migration_v2_completed';

  static Future<void> performMigration() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if migration has already been run
    if (prefs.getBool(_migratedKey) ?? false) {
      return;
    }

    debugPrint("MigrationHelper: Starting data migration...");

    // 1. Weak Questions (weak_questions remains the same, no action needed)

    // 2. Premium Status
    // Old key: 'is_premium_user'
    // New key: 'is_premium'
    final oldPremium = prefs.getBool('is_premium_user');
    if (oldPremium != null && oldPremium) {
      debugPrint("MigrationHelper: Migrated premium status.");
      await prefs.setBool('is_premium', true);
    }

    // 3. Quiz Completion Count
    // Old key: 'complete_quiz_count'
    // New key: 'quiz_completion_count'
    final oldQuizCount = prefs.getInt('complete_quiz_count');
    if (oldQuizCount != null) {
      debugPrint("MigrationHelper: Migrated quiz completion count.");
      await prefs.setInt('quiz_completion_count', oldQuizCount);
    }

    // 4. High Scores
    // Old: highscore_part1, highscore_part2...
    // New: highscore_航空法・ルール, highscore_機体・システム...
    final Map<String, String> categoryMap = {
      'part1': '航空法・ルール',
      'part2': '機体・システム',
      'part3': '運航・安全管理',
      'part4': '力学・気象・計算',
    };

    for (final entry in categoryMap.entries) {
      final oldScore = prefs.getInt('highscore_${entry.key}');
      if (oldScore != null && oldScore > 0) {
        final newKey = 'highscore_${entry.value}';
        final currentScore = prefs.getInt(newKey) ?? 0;
        if (oldScore > currentScore) {
          debugPrint(
            "MigrationHelper: Migrated highscore for ${entry.value} ($oldScore)",
          );
          await prefs.setInt(newKey, oldScore);
        }
      }
    }

    await _migrateStringList(
      prefs,
      from: PrefsHelper.legacyBookmarkKey,
      to: 'bookmark_questions_${AppIdentity.appId}',
    );
    await _migrateInt(
      prefs,
      from: PrefsHelper.legacyTotalAnsweredKey,
      to: 'total_answered_${AppIdentity.appId}',
    );
    await _migrateInt(
      prefs,
      from: PrefsHelper.legacyBestStreakKey,
      to: 'best_streak_${AppIdentity.appId}',
    );
    await _migrateString(
      prefs,
      from: PrefsHelper.legacyDailyAnsweredKey,
      to: 'daily_answered_${AppIdentity.appId}',
    );
    await _migrateString(
      prefs,
      from: PrefsHelper.legacyDailyBestStreakKey,
      to: 'daily_best_streak_${AppIdentity.appId}',
    );

    for (final key in prefs.getKeys()) {
      if (key.startsWith(PrefsHelper.legacyCatAnsweredPrefix)) {
        final suffix = key.substring(
          PrefsHelper.legacyCatAnsweredPrefix.length,
        );
        await _migrateInt(
          prefs,
          from: key,
          to: 'cat_answered_${AppIdentity.appId}_$suffix',
        );
      } else if (key.startsWith(PrefsHelper.legacyCatCorrectPrefix)) {
        final suffix = key.substring(PrefsHelper.legacyCatCorrectPrefix.length);
        await _migrateInt(
          prefs,
          from: key,
          to: 'cat_correct_${AppIdentity.appId}_$suffix',
        );
      }
    }

    // Mark as migrated
    await prefs.setBool(_migratedKey, true);
    debugPrint("MigrationHelper: Data migration to V2 completed.");
  }

  static Future<void> _migrateInt(
    SharedPreferences prefs, {
    required String from,
    required String to,
  }) async {
    if (prefs.containsKey(to)) return;
    final value = prefs.getInt(from);
    if (value != null) {
      await prefs.setInt(to, value);
    }
  }

  static Future<void> _migrateString(
    SharedPreferences prefs, {
    required String from,
    required String to,
  }) async {
    if (prefs.containsKey(to)) return;
    final value = prefs.getString(from);
    if (value != null && value.isNotEmpty) {
      await prefs.setString(to, value);
    }
  }

  static Future<void> _migrateStringList(
    SharedPreferences prefs, {
    required String from,
    required String to,
  }) async {
    if (prefs.containsKey(to)) return;
    final value = prefs.getStringList(from);
    if (value != null && value.isNotEmpty) {
      await prefs.setStringList(to, value);
    }
  }
}

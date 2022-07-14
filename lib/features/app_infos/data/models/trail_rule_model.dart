import 'dart:convert';

import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

class TrailRuleModel extends TrailRule {
  const TrailRuleModel({
    required super.ruleId,
    required super.rule,
    required super.note,
  });

  factory TrailRuleModel.fromMap(Map<String, dynamic> map) {
    return TrailRuleModel(
      ruleId: (map['rules_id'] as num).toString(),
      rule: map['rule'] as String,
      note: map['note'] as String,
    );
  }

  factory TrailRuleModel.fromJson(String source) =>
      TrailRuleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
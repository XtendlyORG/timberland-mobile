import '../../domain/entities/faq.dart';

class FAQModel extends FAQ {
  const FAQModel({
    // required super.faqId,
    required super.question,
    required super.answer,
    required super.subCategory,
  });

  factory FAQModel.fromMap(Map<String, dynamic> map) {
    return FAQModel(
      // faqId: (map['faq_id'] as num).toString(),
      question: map['question'] as String,
      answer: map['answer'] as String,
      subCategory: [],
    );
  }
}

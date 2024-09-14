import 'package:mood_diary/domain/entity/feeling.dart';
import 'package:mood_diary/resources/resources.dart';

class AppLists {
  AppLists._();

  static final feelings = <Feeling>[
    Feeling(name: 'Радость', imagePath: FeelingImages.joy, subFeelings: [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Очарование',
      'Осознанность',
      'Смелость',
      'Удовольствие',
      'Чувственность',
      'Энергичность',
      'Экстравагантность'
    ]),
    Feeling(name: 'Страх', imagePath: FeelingImages.fear, subFeelings: [
      'Тревога',
      'Паника',
      'Беспокойство',
      'Опасение',
      'Ужас',
      'Нервозность',
      'Паранойя',
      'Неуверенность',
      'Напряженность',
      'Шок'
    ]),
    Feeling(name: 'Бешенство', imagePath: FeelingImages.rage, subFeelings: [
      'Ярость',
      'Злоба',
      'Гнев',
      'Обида',
      'Раздражение',
      'Атака',
      'Агрессия',
      'Взрыв',
      'Неприязнь',
      'Враждебность'
    ]),
    Feeling(name: 'Грусть', imagePath: FeelingImages.sadness, subFeelings: [
      'Печаль',
      'Тоска',
      'Грусть',
      'Разочарование',
      'Одиночество',
      'Уныние',
      'Жалость к себе',
      'Безнадежность',
      'Тревожность',
      'Опустошение'
    ]),
    Feeling(
        name: 'Спокойствие',
        imagePath: FeelingImages.calmness,
        subFeelings: [
          'Расслабленность',
          'Умиротворение',
          'Баланс',
          'Гармония',
          'Безмятежность',
          'Покой',
          'Стабильность',
          'Непоколебимость',
          'Отрешенность'
        ]),
    Feeling(name: 'Сила', imagePath: FeelingImages.strength, subFeelings: [
      'Мощь',
      'Храбрость',
      'Стойкость',
      'Настойчивость',
      'Дерзость',
      'Выносливость',
      'Воля',
      'Независимость',
      'Уверенность',
      'Твердость'
    ]),
  ];
}

import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

Future<void> main(List<String> arguments) async {
  const BOT_TOKEN = '';
  final username = (await Telegram(BOT_TOKEN).getMe()).username;
  var teledart = TeleDart(BOT_TOKEN, Event(username!));

  teledart
      .onMessage(keyword: 'Fight for freedom')
      .listen((message) => message.reply('Stand with Hong Kong'));

  teledart.onCommand("start").listen((event) {
    print(event.toJson());
    event.reply("Hello ${event.from?.firstName}");
  });

  teledart
      .onMessage(keyword: 'dart')
      .where((message) => message.text?.contains('telegram') ?? false)
      .listen((message) => message.replyPhoto(
          //  io.File('example/dash_paper_plane.png'),
          'https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dash_paper_plane.png',
          caption: 'This is how the Dart Bird and Telegram are met'));

  teledart.onCommand("info").listen((event) {
    print("info command is running");
    event.reply("text form info <i><b>command</b></i>",
        parseMode: "HTML",
        replyMarkup: InlineKeyboardMarkup.fromJson({
          "inline_keyboard": [
            [
              {"text": "red", "callback_data": "rrred"}
            ],
            [
              {"text": "blue", "callback_data": "Blue"}
            ]
          ]
        }));

    // print(event.reply(text));
  });

  // await teledart.answerCallbackQuery("rrred",
  //     text: "adf");

  teledart.start();

  print("--Bot is running!--");
}

import 'package:flutter/cupertino.dart';

List<Map<String, Object>> WALKTHROUGH_ITEMS = [
  {
    'image': 'assets/images/shanna.png',
    'button_text': 'Continue',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'Welcome to SleepLah! Shanna, our mascot sheep, aims to help you develop good sleeping habits and have fun along the way😉',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "IndieFlower"))
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'Let\'s start!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: "IndieFlower")),
    ])),
  },
  {
    'image': 'assets/images/clock.png',
    'button_text': 'Continue',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'Set your customised sleeping and wakeup time goals, and get alarm reminders✨',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'IndieFlower',
              color: Color.fromARGB(255, 176, 44, 44))),
      TextSpan(
          text: '\nNever miss your bedtime and stay up late again!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'IndieFlower')),
    ]))
  },
  {
    'image': 'assets/images/reward.png',
    'button_text': 'Continue',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'When you sleep/wake up within 15 minutes margin of you goals, you can grab rewards the next day! Among the flower variants you have unlocked, you will get an additional one😁\n\nIf you continue with this for 7 consecutive days, you will get 30 coins on top of the flower reward.\nCoins can be used to unlock mysterious flower variants in the flower shop, and Shanna is looking forward to meet new flowers🤩\n\nNumber of consecutive days will be reset to zero if you break your good efforts🙃',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'IndieFlower'))
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'Accumulate your flower assets with Shanna in your garden😍',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              fontFamily: 'IndieFlower',
              color: Color.fromARGB(255, 176, 44, 44))),
      TextSpan(
          text: 'Get rewards for exercising good sleeping habits!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              fontFamily: 'IndieFlower')),
    ])),
  },
  {
    'image': 'assets/images/leaderboard.png',
    'button_text': 'Continue',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'View your ranking based on the number of total flowers owned & number of consecutive days of sleep',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
      TextSpan(
          text:
              '\nSend/accept friend request to exercise good sleeping habits with friends!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'Have fun by inviting friends to participate, and see your place on the leaderboard😎',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'IndieFlower',
              color: Color.fromARGB(255, 176, 44, 44))),
    ])),
  },
  {
    'image': 'assets/images/dashboard.png',
    'button_text': 'Continue',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'View the coins, number of days of sleep, and number of each flower owned at the moment',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
      TextSpan(
          text:
              '\nBe proud of how far you have come in sticking to your sleeping goals. WOW🏆',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'Garden Statistics Dashboard: take a look at your garden assets!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'IndieFlower',
              color: Color.fromARGB(255, 176, 44, 44))),
    ])),
  },
  {
    'image': 'assets/images/stats.png',
    'button_text': 'Continue',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'Start and end time of sleep, sleep duration, in weeks and months!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
      TextSpan(
          text:
              '\nKeep track of how long you have been sleeping for the past few days/months, and your usual sleep/wakeup time',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'See your personal sleeping statistics displayed in barcharts!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'IndieFlower',
              color: Color.fromARGB(255, 176, 44, 44))),
    ])),
  },
  {
    'image': 'assets/images/collection.png',
    'button_text': 'Continue',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'Unlocked flowers will be visible, ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
      TextSpan(
          text: 'mysterious flowers need to be purchased in flower shop🎃',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'Flower Collection Handbook: read the language of flowers and see how many mysterious flowers are still waiting for you!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'IndieFlower',
              color: Color.fromARGB(255, 176, 44, 44))),
    ])),
  },
  {
    'image': 'assets/images/profile.png',
    'button_text': 'Let\'s go!',
    'description_rich': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text:
              'Change your profile photo to your favourite flower among those unlocked(✿◡‿◡)',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'IndieFlower')),
    ])),
    'title': RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'More to explore on the settings page!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'IndieFlower',
              color: Color.fromARGB(255, 176, 44, 44))),
    ])),
  }
];

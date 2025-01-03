import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:stemquest/ui/responsiveness.dart';
import 'package:text_to_speech/text_to_speech.dart';

final images = [
  "https://github.com/ManasMalla/df-assets/blob/main/Cover.png?raw=true",
  "https://www.gutmicrobiotaforhealth.com/wp-content/uploads/2015/02/A-video-to-introduce-the-bacterial-communities-that-live-inside-the-human-body.jpg",
  "https://img.freepik.com/free-vector/floating-egg-fried-with-pan-cartoon-vector-icon-illustration-food-object-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-3815.jpg",
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Responsiveness.init(
          context,
          constraints.maxWidth,
          constraints.maxHeight,
        );
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            indicatorColor: Colors.white,
            selectedIndex: currentScreenIndex,
            onDestinationSelected: (i) {
              setState(() {
                currentScreenIndex = i;
              });
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.school_outlined),
                label: "Home",
                // on: () {},
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_rounded),
                label: "Library",
                // onPressed: () {},
              ),
              NavigationDestination(
                icon: Icon(Icons.gamepad_sharp),
                label: "Favorites",
                // onPressed: () {},
              ),
              NavigationDestination(
                icon: Icon(Icons.abc),
                label: "Profile",
                // onPressed: () {},
              ),
            ],
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(Icons.menu, color: const Color(0x901A1A1A)),
            actions:
                currentScreenIndex == 1
                    ? [Icon(Icons.search, color: const Color(0x901A1A1A))]
                    : [],
            title: Text(
              (currentScreenIndex == 1
                      ? "Library"
                      : currentScreenIndex == 2
                      ? "Training"
                      : "STEMQuest")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0x801A1A1A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          backgroundColor: Color(0xFFF6FBFF),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(16),
                  child: Transform.translate(
                    offset: Offset(0, -20),
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 32,
                            color: Color.fromARGB(144, 70, 161, 199),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ).copyWith(top: 16),
                  child:
                      currentScreenIndex == 1
                          ? LibraryPage()
                          : currentScreenIndex == 2
                          ? TrainingPage()
                          : Placeholder(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset("assets/images/card/race_card.svg"),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: SvgPicture.asset("assets/images/card/foxy_card.svg"),
            ),
            Expanded(
              child: SvgPicture.asset("assets/images/card/pixie_card.svg"),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: SvgPicture.asset("assets/images/card/froggie_card.svg"),
            ),
            Expanded(
              child: SvgPicture.asset("assets/images/card/beavy_card.svg"),
            ),
          ],
        ),
      ],
    );
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  var data = [
    {
      "title": "Adventure",
      "colors": [Color(0xFFD1A3F8), Color(0xFFAB95F7)],
    },
    {
      "title": "Fantasy",
      "colors": [Color(0xFF63C6F8), Color(0xFF6EACF8)],
    },
    {
      "title": "Girls",
      "colors": [Color(0xFFF0A4D4), Color(0xFFEE84D1)],
    },
    {
      "title": "Classics",
      "colors": [Color(0xFFF4C767), Color(0xFFF5C56A)],
    },
  ];
  final books = [
    Book(
      title: "The Last Sharman",
      author: "Naomi Novik",
      image: "assets/images/books/book1.png",
    ),
    Book(
      title: "The Last Sharman",
      author: "Naomi Novik",
      image: "assets/images/books/book1.png",
    ),
  ];
  var stories = [];
  var isLoading = true;
  var topics = [
    {
      "childName": "Kavya Chandana",
      "favoriteCharacterType": "SUPERHERO",
      "favoriteMediaInspiration": "Heroic",
      "preferredStoryLength": "SHORT",
      "storyGenre": "ADVENTURE",
      "stemConcept": "Trigonometry",
      "storySetting": "village",
      "characterSpecialAbility": "strong, confident, able to fly",
      "numberOfCharacters": 1,
      "targetAudience": "a 6 year old girl with low english proficiency",
      "difficulty": "Beginner with vague knowledge on englihs",
      "numberOfWordsPerParagraph": 50,
    },
    {
      "childName": "Manas Malla",
      "favoriteCharacterType": "SUPERHERO",
      "favoriteMediaInspiration": "Heroic",
      "preferredStoryLength": "SHORT",
      "storyGenre": "ADVENTURE",
      "stemConcept": "Human Body",
      "storySetting": "android land, technical chad",
      "characterSpecialAbility": "strong, confident, able to control minds",
      "numberOfCharacters": 5,
      "targetAudience": "a 8 year old boy with low english proficiency",
      "difficulty": "Beginner with vague knowledge on english",
      "numberOfWordsPerParagraph": 40,
    },
    {
      "childName": "Varshita Palleti",
      "favoriteCharacterType": "SUPERHERO",
      "favoriteMediaInspiration": "Heroic",
      "preferredStoryLength": "SHORT",
      "storyGenre": "ADVENTURE",
      "stemConcept": "Numbers",
      "storySetting": "village, cooking",
      "characterSpecialAbility": "strong, confident, able to fly",
      "numberOfCharacters": 1,
      "targetAudience": "a 6 year old girl with low english proficiency",
      "difficulty": "Beginner with vague knowledge on english",
      "numberOfWordsPerParagraph": 30,
    },
  ];
  Future<void> fetchStory() async {
    final functions = FirebaseFunctions.instanceFor(region: "us-central1");
    for (var d in topics) {
      final callable = await functions
          .httpsCallable('storyCustomSuggestionFlow')
          .call(<String, dynamic>{...d});
      print(callable.data);
      stories.add(callable.data);
      isLoading = false;
      setState(() {});
    }
  }

  // TextToSpeech tts = TextToSpeech();
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Featured Categories",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0x90000000),
                fontSize: getResponsiveHeight(17),
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Opacity(
              opacity: 0.4,
              child: Icon(
                Icons.more_horiz_rounded,
                size: getResponsiveHeight(28),
              ),
            ),
          ],
        ),
        SizedBox(height: getResponsiveHeight(12)),
        isLoading
            ? CircularProgressIndicator()
            : SizedBox(
              height: getResponsiveHeight(54),
              child: ListView.separated(
                clipBehavior: Clip.none,
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return FeaturedCategoriesWidget(
                    title: data[index]["title"].toString(),
                    onPressed: () {},
                    gradientColors: data[index]["colors"] as List<Color>,
                  );
                },
                separatorBuilder: (context, _) {
                  return SizedBox(width: getResponsiveWidth(12));
                },
              ),
            ),
        SizedBox(height: getResponsiveHeight(16)),
        Row(
          children: [
            Text(
              "Popular Book Series",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0x90000000),
                fontSize: getResponsiveHeight(17),
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Opacity(
              opacity: 0.4,
              child: Icon(
                Icons.more_horiz_rounded,
                size: getResponsiveHeight(28),
              ),
            ),
          ],
        ),
        SizedBox(height: getResponsiveHeight(12)),
        isLoading
            ? CircularProgressIndicator()
            : SizedBox(
              height: 170,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final book = stories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                leading: Icon(
                                  Icons.arrow_back,
                                  color: const Color(0x901A1A1A),
                                ),
                                actions: [
                                  Icon(
                                    Icons.text_increase,
                                    color: const Color(0x901A1A1A),
                                  ),
                                ],
                                title: Column(
                                  children: [
                                    Text(
                                      stories[index]["storyTitle"],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(
                                        color: const Color(0x801A1A1A),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "CHAPTER 1".toUpperCase(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge?.copyWith(
                                        color: const Color(0x801A1A1A),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor: Color(0xFFF6FBFF),
                              body: Column(
                                children: [
                                  PreferredSize(
                                    preferredSize: Size.fromHeight(16),
                                    child: Transform.translate(
                                      offset: Offset(0, -20),
                                      child: Container(
                                        height: 16,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 32,
                                              color: Color.fromARGB(
                                                144,
                                                70,
                                                161,
                                                199,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: ListView.builder(
                                        itemBuilder: (context, paraIndex) {
                                          var isPlayingRow = false;
                                          return StatefulBuilder(
                                            builder: (context, setRowState) {
                                              return Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                        ),
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        try {
                                                          if (isPlayingRow) {
                                                            await flutterTts
                                                                .stop();
                                                            setRowState(() {
                                                              isPlayingRow =
                                                                  false;
                                                            });
                                                            return;
                                                          }
                                                          isPlayingRow =
                                                              !isPlayingRow;
                                                          print(isPlayingRow);
                                                          // await tts.stop();
                                                          await flutterTts
                                                              .setLanguage(
                                                                "en-US",
                                                              ); // Set language to English US
                                                          await flutterTts.setPitch(
                                                            1.0,
                                                          ); // Set pitch to normal (1.0)

                                                          // Ensure speech completion before allowing new actions
                                                          await flutterTts
                                                              .awaitSpeakCompletion(
                                                                true,
                                                              );

                                                          // iOS-specific configurations
                                                          if (Platform.isIOS) {
                                                            await flutterTts
                                                                .setSharedInstance(
                                                                  true,
                                                                );
                                                            await flutterTts.setIosAudioCategory(
                                                              IosTextToSpeechAudioCategory
                                                                  .playback,
                                                              [
                                                                IosTextToSpeechAudioCategoryOptions
                                                                    .allowBluetooth,
                                                                IosTextToSpeechAudioCategoryOptions
                                                                    .allowBluetoothA2DP,
                                                                IosTextToSpeechAudioCategoryOptions
                                                                    .mixWithOthers,
                                                                IosTextToSpeechAudioCategoryOptions
                                                                    .defaultToSpeaker,
                                                              ],
                                                              IosTextToSpeechAudioMode
                                                                  .defaultMode,
                                                            );
                                                          }
                                                          flutterTts.setVolume(
                                                            1,
                                                          );
                                                          flutterTts
                                                              .setSpeechRate(
                                                                0.3,
                                                              );

                                                          flutterTts
                                                              .speak(
                                                                stories[index]["story"][paraIndex]["paragraph"]
                                                                    .toString(),
                                                              )
                                                              .then((_) {
                                                                setRowState(() {
                                                                  isPlayingRow =
                                                                      false;
                                                                });
                                                              });
                                                          setRowState(() {
                                                            print(isPlayingRow);
                                                          });
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      },
                                                      icon: Icon(
                                                        isPlayingRow
                                                            ? Icons.stop
                                                            : Icons.play_circle,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      stories[index]["story"][paraIndex]["paragraph"]
                                                              .toString() +
                                                          "\n",
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        itemCount:
                                            stories[index]["story"].length,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 280,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.network(
                              images[index],
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: getResponsiveHeight(-27),
                              width: getResponsiveWidth(86),
                              height: getResponsiveHeight(125),
                              right: getResponsiveWidth(-8),
                              child: Text(
                                (index + 1).toString(),
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(
                                  color: const Color(0x99EDF6FF),
                                  fontSize: getResponsiveHeight(120),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              height: getResponsiveHeight(72),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF6FA4F8),

                                    Color(0x506FA4F8),
                                    Colors.transparent,
                                  ],
                                  stops: [0, 0.7, 1],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    topics[index]["stemConcept"].toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      book["storyTitle"],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, _) {
                  return SizedBox(width: 12);
                },
                itemCount: stories.length,
              ),
            ),
        SizedBox(height: getResponsiveHeight(16)),
        Row(
          children: [
            Text(
              "Books Bestsellers",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0x90000000),
                fontSize: getResponsiveHeight(17),
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Opacity(
              opacity: 0.4,
              child: Icon(
                Icons.more_horiz_rounded,
                size: getResponsiveHeight(28),
              ),
            ),
          ],
        ),
        SizedBox(height: getResponsiveHeight(12)),
        isLoading
            ? CircularProgressIndicator()
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: SizedBox(
                height: 270,
                child: ListView.separated(
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookWidget(
                      title: stories[index]["storyTitle"],
                      topic: topics[index]["stemConcept"].toString(),
                      image: images[index],
                    );
                  },
                  separatorBuilder: (context, _) {
                    return SizedBox(width: 12);
                  },
                  itemCount: 2,
                ),
              ),
            ),
      ],
    );
  }
}

class BookWidget extends StatelessWidget {
  final String title;
  final String topic;
  final String image;
  const BookWidget({
    super.key,
    required this.title,
    required this.topic,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(-4, 4),
            blurRadius: 18,
            color: Color(0xFF6FA4F8).withValues(alpha: 0.4),
          ),
        ],
      ),
      width: 190,
      height: 260,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 8),
              Container(
                width: 1.5,
                color: Colors.black.withValues(alpha: 0.05),
                height: 110,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0x70000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: const Color(
                            0xFF33A1FF,
                          ).withValues(alpha: 0.92),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green,
                                ),
                                height: 10,
                                width: 3,
                              ),
                              SizedBox(width: 4),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green,
                                ),
                                height: 10,
                                width: 3,
                              ),
                              SizedBox(width: 4),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green,
                                ),
                                height: 10,
                                width: 3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String image;
  const Book({required this.title, required this.author, required this.image});
}

class FeaturedCategoriesWidget extends StatelessWidget {
  final String title;
  final Function onPressed;
  final List<Color> gradientColors;

  const FeaturedCategoriesWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 6,
          child: Blur(
            blur: 4,
            // filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Opacity(
              opacity: 0.75,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(colors: gradientColors),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: getResponsiveWidth(16),
                  vertical: getResponsiveHeight(14),
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: getResponsiveHeight(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: gradientColors),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: getResponsiveWidth(16),
            vertical: getResponsiveHeight(14),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontSize: getResponsiveHeight(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

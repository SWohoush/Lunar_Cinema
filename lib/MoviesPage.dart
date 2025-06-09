import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'BookingPage.dart';

Color mainColor = Color(0xFF200914);

class MoviesPage extends StatelessWidget {
  final List<Map<String, String>> movies = [
    {
      'title': 'Inception',
      'image':
          'https://m.media-amazon.com/images/I/81p+xe8cbnL._AC_SL1500_.jpg',
      'imdb': 'https://www.imdb.com/title/tt1375666/',
    },
    {
      'title': 'Dragon Ball Super: Super Hero',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2A1yUh6-QivRux-KtpUeaQqNgjqFL6glR-pDuVzrqK1iuao8290qiMDMJHPTihll-B3GnZw',
      'imdb': 'https://www.imdb.com/title/tt14614892/',
    },
    {
      'title': 'Interstellar',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'imdb': 'https://www.imdb.com/title/tt0816692/',
    },
    {
      'title': 'Spider-Man: No Way Home',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMmFiZGZjMmEtMTA0Ni00MzA2LTljMTYtZGI2MGJmZWYzZTQ2XkEyXkFqcGc@._V1_.jpg',
      'imdb': 'https://www.imdb.com/title/tt10872600/',
    },
    {
      'title': 'The Dark Knight',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_FMjpg_UX1000_.jpg',
      'imdb': 'https://www.imdb.com/title/tt0468569/?ref_=chttp_t_3',
    },
    {
      'title': 'Avengers: Endgame',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_.jpg',
      'imdb': 'https://www.imdb.com/title/tt4154796/',
    },
    {
      'title': 'Spirited Away',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNTEyNmEwOWUtYzkyOC00ZTQ4LTllZmUtMjk0Y2YwOGUzYjRiXkEyXkFqcGc@._V1_.jpg',
      'imdb': 'https://www.imdb.com/title/tt0245429/?ref_=chttp_t_31',
    },
    {
      'title': 'Pulp Fiction',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYTViYTE3ZGQtNDBlMC00ZTAyLTkyODMtZGRiZDg0MjA2YThkXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'imdb': 'https://www.imdb.com/title/tt0110912/?ref_=chttp_t_8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFC9BABA)),
        backgroundColor: Color(0xFF520C2E),
        centerTitle: true,
        title: Image(
          image: AssetImage('lib/images/logo.jpg'),
          height: 130,
          fit: BoxFit.contain,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 1.0, 2.0),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available Movies",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFC9BABA),
                  fontWeight: FontWeight.w100,
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children:
                    movies.map((movie) {
                      return Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color(0xFF520C2E),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 4),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(5),
                              ),
                              child: Image.network(
                                movie['image']!,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 8, 5, 12),
                              child: InkWell(
                                onTap:
                                    () => launchUrl(Uri.parse(movie['imdb']!)),
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  movie['title']!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),

                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => BookingPage(
                                            title: movie['title']!,
                                            imageUrl: movie['image']!,
                                          ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFC9BABA),
                                  minimumSize: Size(double.infinity, 36),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: const Text(
                                  'BOOK NOW',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF520C2E),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

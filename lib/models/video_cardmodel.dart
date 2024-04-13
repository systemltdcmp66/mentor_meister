// Define a class to represent a video card
class VideoCard {
  final String title;
  final String subtitle;
  final String rating;
  final String price;
  final String imageUrl;
  final int numberOfStudents;

  VideoCard({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.numberOfStudents,
  });
}
List<VideoCard> videoCards = [
  VideoCard(
    title: 'Learn 3D Modeling',
    subtitle: 'Conception',
    rating: '4.0',
    price: '\$30.00',
    imageUrl: 'assets/teacher/c1.png',
    numberOfStudents: 6,
  ),
  VideoCard(
    title: 'Learn React.js for Beginners',
    subtitle: 'Programming',
    rating: '4.0',
    price: '\$30.00',
    imageUrl: 'assets/teacher/c2.png',
    numberOfStudents: 7,
  ),
  VideoCard(
    title: 'Learn React.js for Beginners',
    subtitle: 'Programming',
    rating: '4.0',
    price: '\$30.00',
    imageUrl: 'assets/teacher/c2.png',
    numberOfStudents: 7,
  ),
  VideoCard(
    title: 'Learn React.js for Beginners',
    subtitle: 'Programming',
    rating: '4.0',
    price: '\$30.00',
    imageUrl: 'assets/teacher/c2.png',
    numberOfStudents: 7,
  ),
];
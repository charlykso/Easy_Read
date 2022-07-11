/// Holds information about a book
class Book {
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.coverImage,
    required this.publicationYear,
  });

  final int id;
  final String title;
  final String author;
  final String coverImage;
  final double price;
  final int publicationYear;
}

List<Book> books = [
  Book(
    id: 1,
    title: "Fatherhood",
    author: "Marcus Berkmann",
    coverImage: "assets/images/books/Fatherhood.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 2,
    title: "The Fatal Tree",
    author: "Jake Arnott",
    coverImage: "assets/images/books/The Fatal Tree.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 3,
    title: "Doctor Who",
    author: "Renald Sergio",
    coverImage: "assets/images/books/Doctor Who.jpg",
    price: 3200,
    publicationYear: 2022,
  ),
  Book(
    id: 4,
    title: "The Fatal Tree",
    author: "Jake Arnott",
    coverImage: "assets/images/books/The Fatal Tree.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 5,
    title: "Doctor Who",
    author: "Renald Sergio",
    coverImage: "assets/images/books/Doctor Who.jpg",
    price: 3200,
    publicationYear: 2022,
  ),
  Book(
    id: 6,
    title: "Fatherhood",
    author: "Marcus Berkmann",
    coverImage: "assets/images/books/Fatherhood.jpg",
    price: 3200,
    publicationYear: 2022,
  ),
  Book(
    id: 7,
    title: "Doctor Who",
    author: "Renald Sergio",
    coverImage: "assets/images/books/Doctor Who.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 8,
    title: "The Fatal Tree",
    author: "Jake Arnott",
    coverImage: "assets/images/books/The Fatal Tree.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 9,
    title: "Fatherhood",
    author: "Marcus Berkmann",
    coverImage: "assets/images/books/Fatherhood.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 10,
    title: "The Fatal Tree",
    author: "Jake Arnott",
    coverImage: "assets/images/books/The Fatal Tree.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 11,
    title: "Fatherhood",
    author: "Marcus Berkmann",
    coverImage: "assets/images/books/Fatherhood.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
  Book(
    id: 12,
    title: "Doctor Who",
    author: "Renald Sergio",
    coverImage: "assets/images/books/Doctor Who.jpg",
    price: 3200,
    publicationYear: 2021,
  ),
];

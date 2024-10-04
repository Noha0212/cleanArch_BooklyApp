class BookEntity {
  final String bookId;
  final String title;
  final String? image;
  final String? authName;
  final num? price;
  final num? rating;

  BookEntity(
      {required this.title,
      required this.image,
      required this.authName,
      required this.price,
      required this.rating,
      required this.bookId});
}

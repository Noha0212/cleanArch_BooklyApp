part of 'featured_books_cubit.dart';

abstract class FeaturedBooksState {}

class FeaturedBooksInitial extends FeaturedBooksState {}

class FeaturedBooksLoading extends FeaturedBooksState {}

class FeaturedBooksPaginationLoading extends FeaturedBooksState {}

class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookEntity> books;

  FeaturedBooksSuccess(this.books);
}

class FeaturedBooksFailure extends FeaturedBooksState {
  final String errMessag;

  FeaturedBooksFailure(
    this.errMessag,
  );
}

class FeaturedBooksPaginationFailure extends FeaturedBooksState {
  final String errMessag;

  FeaturedBooksPaginationFailure(
    this.errMessag,
  );
}

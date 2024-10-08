// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bookly/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';

import 'custom_book_image.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({
    Key? key,
  }) : super(key: key);

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late ScrollController _scrollController;
  late int nextPage = 1;
  late var isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Add listener to the scroll controller
    _scrollController.addListener(scrollListener);
  }

  void scrollListener() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.7) {
      // Trigger fetch when scroll position reaches 70% of the total scroll length
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<FeaturedBooksCubit>(context)
            .fetchFeaturedBooks(pageNumber: nextPage++);
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit, FeaturedBooksState>(
      listener: (context, state) {
        if (state is FeaturedBooksSuccess) {
          books.addAll(state.books);
        }
        if (state is FeaturedBooksPaginationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                state.errMessag,
                style: const TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FeaturedBooksSuccess ||
            state is FeaturedBooksPaginationLoading ||
            state is FeaturedBooksPaginationFailure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomBookImage(
                      image: books[index].image ?? '',
                    ),
                  );
                }),
          );
        } else if (state is FeaturedBooksFailure) {
          return Text(state.errMessag);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

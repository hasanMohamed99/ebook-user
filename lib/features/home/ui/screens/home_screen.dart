import 'package:ebook_task_user/core/theming/styles.dart';
import 'package:ebook_task_user/features/home/logic/home_cubit.dart';
import 'package:ebook_task_user/features/home/ui/widgets/logout_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/book_card.dart';
import '../../../../core/widgets/book_response.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../logic/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Text(homeCubit.userStatus.toUpperCase(), style: TextStyles.font14Black500Weight.copyWith(letterSpacing: 2),);
          },
        ),
        actions: const [
          LogoutBlocListener()
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: LoadingWidget(),
              )
            ],
          ),
          success: (books) => homeCubit.userStatus == 'pending'
              ? const Center(
                  child: Text('Please Wait until admin accept your account, we are going to send you email when your account accepted'),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: StreamBuilder(
                    stream: homeCubit.getBooks(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Column(
                          children: [
                            VerticalSpace(10),
                            LoadingWidget(),
                          ],
                        );
                      } else if (books.isEmpty) {
                        return const Center(child: Text('No Books'));
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                              'Something went wrong please, try again later.'),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio: 0.9,
                          maxCrossAxisExtent: 300,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) => BookCard(
                          book: BookResponse(
                            id: books[index]['id'],
                            bookName: books[index]['name'],
                            authorName: books[index]['author'],
                            pdfLink: books[index]['pdf'],
                            imageLink: books[index]['image'],
                            category: books[index]['category'],
                            createdAt: books[index]['created_at'],
                          ),
                        ),
                        itemCount: books.length,
                      );
                    },
                  ),
                ),
          error: (message) => Center(
            child: Text(message),
          ),
        ),
      ),
    );
  }
}

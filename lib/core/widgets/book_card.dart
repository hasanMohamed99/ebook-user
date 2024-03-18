import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/home/logic/home_state.dart';
import '../helpers/spacing.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';
import 'book_response.dart';

class BookCard extends StatelessWidget {
  final BookResponse book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Card(
      elevation: 0,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColors.transparent),
      ),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.network(
                book.imageLink,
                fit: BoxFit.fill,
                cacheHeight: 211,
                cacheWidth: 70,
              ),
            ),
            const HorizontalSpace(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.bookName,
                    style: TextStyles.font20Yellow700WeightElevated,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const VerticalSpace(10),
                  Text(
                    'By ${book.authorName}',
                    style: TextStyles.font18Black700Weight,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const VerticalSpace(10),
                  Text(
                    book.category,
                    style: TextStyles.font16Black700Weight,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      child: TextButton(
                        onPressed: () => homeCubit.launchLink(book.pdfLink),
                        style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(AppColors.blue),
                        ),
                        child: Text('View',
                            style: TextStyles.font14White400Weight),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocListener<HomeCubit, HomeState>(
              listenWhen: (previous, current) =>
              current is Loading || current is Success || current is Error,
              listener: (context, state) {
                state.whenOrNull(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  success: (response) {},
                  error: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: AppColors.red,
                      ),
                    );
                  },
                );
              },
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:imovie_app/app/_commons/extensions/extensions.dart';
import 'package:imovie_app/app/movie_details/interactor/entities/review.dart';

import '../imovie_ui/iui_text.dart';
import 'hero_dialog/popup_card_tile.dart';

class ReviewsPopupWidget extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsPopupWidget({required this.reviews, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupCardTile(
      id: 'reviews',
      cardTitle: "Reviews",
      cardSubtitle: '',
      visibleContent: IUIText.heading(
        "See reviews (${reviews.length})", //  Visible content on the screen "See reviews"
        fontsize: 14,
        color: Colors.amber,
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 200.0,
          maxHeight: 400.0,
          minWidth: MediaQuery.sizeOf(context).width - 40,
        ),
        child: reviews.isEmpty
            ? Center(
                child: IUIText.title(
                  "No reviews yet",
                  color: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...reviews.reversed.map((review) {
                      return Column(
                        children: [
                          ListTile(
                            leading: SizedBox(
                              height: 30,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  review.avatarUrl,
                                ),
                                onBackgroundImageError: (e, a) {},
                              ),
                            ),
                            title: IUIText.heading(
                              review.name,
                              fontsize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            subtitle: IUIText.heading(
                              review.date.daysAgo(),
                              fontsize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                            trailing: IUIText.heading(
                              "${review.rating.ratingLabel} (${review.rating}) ",
                              fontsize: 13,
                              color: Colors.amber,
                            ),
                          ),
                          IUIText.heading(
                            review.content,
                            fontsize: 14,
                            fontWeight: FontWeight.w400,
                          ).paddingOnly(left: 20, right: 20, bottom: 10),
                          // Divider
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              endIndent: 15,
                              indent: 15,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
      ),
    ).paddingOnly(right: 20);
  }
}

extension DaysAgoExtension on String {
  String daysAgo() {
    try {
      DateTime date = DateTime.parse(this);
      final Duration difference = DateTime.now().difference(date);
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } catch (e) {
      return 'Invalid date';
    }
  }
}

extension RatingLabelExtension on double {
  String get ratingLabel {
    if (this >= 9.0) {
      return 'Excellent';
    } else if (this >= 7.0) {
      return 'Good';
    } else if (this >= 6.0) {
      return 'Average';
    } else if (this >= 4.0) {
      return 'Poor';
    } else {
      return 'Very Poor';
    }
  }
}

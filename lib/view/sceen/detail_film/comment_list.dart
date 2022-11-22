import 'package:erik_haydar/data/model/response/body/comment_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentList extends StatefulWidget {
  final List<Comment> commentList;
  final int totalCount;
  const CommentList(
      {super.key, required this.commentList, required this.totalCount});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        widget.totalCount > 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${getTranslated('comment', context)} (${widget.totalCount})',
                  style: commentTiteStyle,
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 12,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.commentList.length,
          itemBuilder: (context, index) {
            return ItemComment(comment: widget.commentList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 12,
            );
          },
        ),
      ],
    );
  }
}

class ItemComment extends StatelessWidget {
  final Comment comment;

  const ItemComment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: ColorResources.COLOR_FAFAFA,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                  height: 36,
                  width: 36,
                  child: (comment.userImg?.isEmpty ?? false)
                      ? SvgPicture.asset(Images.userPhoto)
                      : BaseUI().imageNetwork(comment.userImg ?? ''),
                ),
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                title: Text(comment.userFullName ?? ''),
                subtitle: Text(
                  comment.createdAt ?? '',
                  style: profileTitle,
                ),
              ),
              Text(
                comment.comment ?? '',
                style:
                    profileTitle.copyWith(color: ColorResources.COLOR_5F5B5B),
              )
            ],
          ),
        ),
      ),
    );
  }
}

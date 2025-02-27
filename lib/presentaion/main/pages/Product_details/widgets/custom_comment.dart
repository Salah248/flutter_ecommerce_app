import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/entity/products_details_entity.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/bloc/cubit/auth_cubit.dart';

class CustomComment extends StatelessWidget {
  const CustomComment({
    super.key,
    required this.commentsEntity,
  });

  final CommentsEntity commentsEntity;

  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthCubit>();
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.userDataModel?.name ?? 'User name',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("${commentsEntity.comment}"),
          commentsEntity.replay != null
              ? Column(
                  children: [
                    const Text(
                      'Replay',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${commentsEntity.replay}'),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

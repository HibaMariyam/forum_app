import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/common/widgets/thread_card.dart';
import 'package:forum_app/features/delete/cubit/delete_cubit.dart';
import 'package:forum_app/features/edit/edit_page.dart';
import 'package:forum_app/features/home/cubit/home_cubit.dart';

class Homeview extends StatefulWidget {
  const Homeview({Key? key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  void initState() {
    context.read<HomeCubit>().getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeFailure) {
          return Text('Error');
        }
        if (state is HomeSuccess) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeCubit>().getHomeData();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocConsumer<DeleteCubit, DeleteState>(
                            listener: (context, state) {
                              if (state is DeleteFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is DeleteSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Successfully deleted')),
                                );
                                // context.read<HomeCubit>().getHomeData();
                              }
                            },
                            builder: (context, deleteState) => state is DeleteLoading
                                ? CircularProgressIndicator()
                                :  Column(
                    children: [
                      for (final thread in state.threads)
                      ThreadCard(
                                    user_image: thread.user.image,
                                    username: thread.user.username,
                                    date: thread.createdAt,
                                    content: thread.content,
                                    authorId: thread.user.id,
                                    delete: IconButton(
                                      onPressed: () async {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you sure you want to delete this thread?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    context
                                                        .read<DeleteCubit>()
                                                        .deleteThread(
                                                            thread.id);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    edit: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditPage(
                                              threadContent: thread.content,
                                              id: thread.id,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    threadImage: thread.image,
                                  )
                       
                    ],
                  ),
                ),
                ),
              ),
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}

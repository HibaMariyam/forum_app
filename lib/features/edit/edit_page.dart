import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/features/edit/cubit/edit_cubit.dart';
import 'package:forum_app/features/home/cubit/home_cubit.dart';

class EditPage extends StatefulWidget {
  final String threadContent;
  final int id;
  EditPage({super.key, required this.threadContent, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _editContentController = TextEditingController();
  void initState() {
    _editContentController.text = widget.threadContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Page')),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _editContentController,
              decoration: InputDecoration(label: Text('Content')),
            ),
            BlocConsumer<EditCubit, EditState>(
              listener: (context, state) {
                if (state is EditFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message))
                  );
                }
                if (state is EditSuccess) {
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('success'))
                  );
                  context.read<HomeCubit>().getHomeData();
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) =>state is EditLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                    onPressed: ()async {
                      final content = _editContentController.text;
                      context.read<EditCubit>().editThread(content, widget.id);
                 
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 60),
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)

                            
                            
              
            )),
              )
        
  
            ),
          ],
        ),
      )),
    );
  }
}

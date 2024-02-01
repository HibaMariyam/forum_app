import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/common/cubit/main_cubit.dart';
import 'package:forum_app/common/views/main_screen.dart';

import 'package:forum_app/features/create/cubit/create_thread_cubit.dart';
import 'package:forum_app/features/home/cubit/home_cubit.dart';
import 'package:forum_app/features/home/views/home_view.dart';
import 'package:image_picker/image_picker.dart';


class CreateView extends StatefulWidget {

  CreateView({super.key});

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  final _contentController = TextEditingController();
  final _imagePicker = ImagePicker();
  XFile? _image;
  
  
  void _pickImage({
    ImageSource source = ImageSource.gallery
  }) async {
      _image = await _imagePicker.pickImage(

        
      source: source,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if(_image!=null)
            Image.file(File(_image!.path),height: 500,width: 500,),
            TextField(
              controller: _contentController,

              decoration: InputDecoration(hintText: "Add your content here.."),
            ),
            SizedBox(height: 16),
            TextButton(onPressed: (){
              showBottomSheet(context: context, builder: (ctx){
                  return Container(
                    height: 500,
                    child: Column(children: [
                      ListTile(
                        title: Text("Camera"),
                        onTap: (){
                          _pickImage(source: ImageSource.camera);
                        },
                      ),
                      ListTile(
                        title: Text("Galler"),
                        onTap: (){
                          _pickImage(source: ImageSource.gallery);
                        },
                      )
                    ]),
                  );
              });
            }, child: Text("Pick Image")),

            BlocConsumer<CreateThreadCubit, CreateThreadState>(
              listener: (context, state) {
               if(state is CreateThreadFailure){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cant create thread!'))
                );
               }
               if(state is CreateThreadSuccess){
                context.read<HomeCubit>().getHomeData();
                
                _contentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Thread Created!'))
                );
                context.read<MainCubit>().setIndex(0);
               }
              },
              
              builder: (context, state) =>state is CreateThreadLoading
                ? CircularProgressIndicator()
                
                :ElevatedButton(
                    onPressed: () {
                      final content =_contentController.text;
                      
                      context.read<CreateThreadCubit>().createThread(content:content,image: _image);
                    }, child: Text('Create Thread')
                    )
              
            )
          ],
        ),
      ));
    
  }
}

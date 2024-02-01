import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/features/auth/cubit/auth_cubit.dart';

class ThreadCard extends StatefulWidget {
  const ThreadCard({
    
  required this.user_image,
  required this.username,required this.date,required this.content,required this.edit,this.threadImage,required this.delete, required this.authorId});
  final String user_image;
    final String username;
    final String date;
    final String content;
    final IconButton edit;
    final IconButton delete;
    final String? threadImage;
    final int authorId;

  @override
  State<ThreadCard> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  bool isLiked = true;
  void like(){
    setState(() {
      if(isLiked){
        isLiked = false;
      }else{
        isLiked = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as AuthSuccess).user;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(239, 224, 224, 224),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: CircleAvatar(
            
                radius: 20,
               backgroundImage: NetworkImage(widget.user_image,
                
               ),
             ),
              title: Text(widget.username),
              subtitle: Text(widget.date),
             trailing: user.id == widget.authorId ? IconButton(onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        widget.edit,
                        Text('Edit'),
                       
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Row(
                      children: [
                        widget.delete,
                        Text('Delete'),
                        
                      ],
                    ),
                  )
                ],
              )
              ));
             }, icon: Icon(Icons.more_horiz_sharp)):null,
          
            ),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(widget.content),
              ), 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   IconButton(onPressed: like,
                    icon: isLiked ?
                    Icon(
                     Icons.favorite_border,
                     color: Colors.grey,
                    )
                     :Icon(Icons.favorite,color: Colors.red,)
                   ),
                ],
              ),
             
            
            if(widget.threadImage!=null)
            Image.network(widget.threadImage!,
            fit: BoxFit.cover,
            ), 
            //!_img not null
          
           
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultFormField({
  ValueChanged<String>? onChange,
  ValueChanged<String>? onSubmit,
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String label ,
  required IconData prefix,
  IconData? suffix ,
  VoidCallback? suffixPressed ,
  VoidCallback? onTap,
  bool isClickable = true ,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      obscureText: isPassword ,
      validator: validate,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        ) : null ,
        border: OutlineInputBorder(),
      ),
    );


Widget buildTAskItem(Map model,context) => Dismissible(
   key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
              '${model['time']}'
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateData(status: 'done', id: model['id'],);
            },
            icon: Icon(
                Icons.check_box,
              color: Colors.green,
            ) ,
        ),
        IconButton(
          onPressed: ()
          {
            AppCubit.get(context).updateData(status: 'archive', id: model['id'],);
          },

          icon: Icon(

            Icons.archive,

            color:  Colors.black45,

          ) ,

        ),
      ],
    ),
  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);



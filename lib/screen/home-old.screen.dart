// import 'package:flutter/material.dart';
// import 'package:flutter_note/model/task.model.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// //everything dlm ni rebuild disebabkan setState(){}
// class _HomeScreenState extends State<HomeScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Awesome List App'),
//       ),
//       body: CustomText(
//           text: 'Task ',
//           child: Builder(
//             builder: (context){
//               return ListView(
//                 children: List.generate(
//                   3,
//                       (i) {
//                     return TaskContainer(
//                         task: Task(
//                             title : CustomText.of(context).text+'${i+1}',
//                             description: 'Task ${ i+1} Description'
//                         ),
//                         index: i);
//                   },
//                 ),
//               );
//             },)
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           print(taskList.length);
//           taskList.add(
//               Task(title: 'Task ${taskList.length + 1}', description: 'Task ${taskList.length + 1} Description',)
//           );
//           print(taskList.length);
//
//           //notify suruh build statefull balik
//           setState(() {
//
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
//
// //TASK CONTAINER SECTION
// class TaskContainer extends StatefulWidget {
//   final Task task;
//   final int index;
//
//   TaskContainer({required this.task, required this.index});
//
//   @override
//   State<TaskContainer> createState() => _TaskContainerState();
// }
//
// class _TaskContainerState extends State<TaskContainer> {
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.task.title,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     widget.task.description,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//             Material(
//               color: Colors.transparent,
//               child: IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: (){
//                   CustomText.of(context).text = 'Item';
//                   print(CustomText.of(context).text);
//                   /*print(taskList.length);
//                   taskList.removeAt(index);
// */
//                   setState(() {});
//                 },
//               ),
//             ), Material(
//               color: Colors.transparent,
//               child: IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: (){
//                   widget.task.title = 'New Title';
//                   /*print(taskList.length);
//                   taskList.removeAt(index);
// */
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomText extends InheritedWidget {
//   final Widget child;
//   String text;
//
//   CustomText({
//     required this.child, required this.text,
//   }) : super( child : child);
//
//   static CustomText of(BuildContext context){
//     final CustomText? result = context.dependOnInheritedWidgetOfExactType<CustomText>();
//
//     assert(result != null, 'No Custom Text found in context');
//     return result!;
//   }
//   changeText(String value){
//     text = value;
//     updateShouldNotify(this);
//   }
//   @override
//   bool updateShouldNotify(CustomText oldWidget) {
//     print(oldWidget.text);
//     print(text);
//     if (oldWidget.text != text)
//       return true;
//     else
//       return false;
//   }
// }

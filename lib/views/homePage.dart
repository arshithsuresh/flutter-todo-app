import 'package:flutter/material.dart';
import 'package:todoapp/model/todoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
  This is the page where our Todo App list the tasks.
  Note that the widget is stateful widget which means that this page will contains
  components that will get triggered by user that would require the UI to re-render
  This is where we should use the stateful widgets.
*/

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//Creating a state for the HomePage

class _HomePageState extends State<HomePage> {
  List<ToDoModel> todoList = [];
  final todoTitleFieldController = TextEditingController();
  final todoSubTitleFieldController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _collection = FirebaseFirestore.instance.collection("TodoList");
  // This function mentions the initial state of the page
  // that is the starting state of the app, if the app has some tasks pre-defined
  @override
  void initState() {
    // TODO: implement initial state of the app
    super.initState();
  }

  // Function to delete all the task in the list
  void deleteAllToDos() {
    _collection.limit(50).get().then((value) => value.docs.every((element)
    {
      _collection.doc(element.id).delete();
      return true;
    }));
  }

  void addNewToDoList() {
    // Retrieve the text we entered in the textbox using the controller assigned to each texbox

    String todoTitle = todoTitleFieldController.text;
    String todoSubTitle = todoSubTitleFieldController.text;

    ToDoModel newTodo = new ToDoModel(title: todoTitle, subtitle: todoSubTitle);
    
    _collection.add(newTodo.toJson());
  }

  void changeToDoStatus(ToDoModel item) {
        
    _collection.doc(item.documentId).update({
      "done": !item.getStatus()
    });
  }

  // To delete a specific item from the list
  void deleteATodo(ToDoModel item) {
    // List.remove function will remove an item from the list
    _collection.doc(item.documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // App bar is a widget to create the Top Bar we see on some Mobile Apps
        title: Center(
          child: Text(
            "ToDo App", // Title for the App Bar
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Container(
            child: IconButton(
              //  Icon Button to delete all the ToDo Entried at once
              icon: Icon(Icons.delete_forever),
              color: Colors.white,
              // The onPressed Paratemer contains a function or step to execute
              // When the button is pressed.
              onPressed: () {
                deleteAllToDos();
              },
              splashRadius: 25,
            ),
          )
        ],
        backgroundColor: Colors.black,
        leading: Container(
          // Leading component of the AppBar is if button that appear to leftmost
          // of the app bar. Here it is the back button
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              // Navigator.pop will close the current page and return to the previous page
              Navigator.of(context).pop();
            },
            splashRadius:
                25, // This is the radius of that small animation that occurs when we click and icon
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Container(
            height: size.height - 68,
            alignment: Alignment.center,
            padding: EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // Title of the page
                  "ToDo List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  // Sized box is used to create space between widgets, vertical or horizontal
                  // Height creates a vertical space, width create a horizontal space
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: 28), // Move the tile text to right by 28 points
                    alignment: Alignment.centerLeft,
                    child: Text("Title")),
                TextField(
                    controller:
                        todoTitleFieldController, // This is from where we will get the text in our code
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      // Styling the text fields
                      suffixIcon: Icon(Icons.edit),
                      contentPadding: EdgeInsets.only(
                          top: 16, bottom: 16, left: 28, right: 28),
                      border: OutlineInputBorder(
                          // To create a border for our text box
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(width: 2)),
                    )),
                SizedBox(
                  height: 8,
                ),
                Container(
                    padding: EdgeInsets.only(left: 28),
                    alignment:
                        Alignment.centerLeft, // Aligning the text to left
                    child: Text("Sub Title")),
                TextField(
                    controller: todoSubTitleFieldController,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      contentPadding: EdgeInsets.only(
                          top: 16, bottom: 16, left: 28, right: 28),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(width: 2)),
                    )),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  //Add Button
                  onPressed: () {
                    addNewToDoList();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    elevation: 0,
                    padding: EdgeInsets.only(
                        top: 12, bottom: 12, right: 40, left: 40),
                  ),
                ),
                SizedBox(
                    child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: 12),
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                )),
                Expanded(
                  child: StreamBuilder(
                    stream: _firestore.collection("TodoList").snapshots(),
                    builder: (context, snapshot) {
                      QuerySnapshot data = snapshot.data;
                      
                      if (!snapshot.hasData)
                        return Center(
                            child:
                                Text("No tasks Found!\nBegin by adding Tasks"));
                      else {                       

                        return ListView.builder(
                            itemCount: data.docs.length,
                            itemBuilder: (context, index) {
                              ToDoModel item = ToDoModel.fromJson(data.docs[index].data(),data.docs[index].id);
                              return todoContainer(context,item);
                            });
                      }
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }

  // Creating a separate widget to display our Tasks
  Widget todoContainer(context, ToDoModel item) {
    bool status = item.getStatus(); // the status of the task
    Color borderColor = status
        ? Colors.green
        : Colors.black; // select the border color according to the status
    IconData icon =
        status ? Icons.done : Icons.radio_button_unchecked; // select the icon
    // ? is an operator to simply the if else
    // (Condition)?<if condition is true>:<if condition is false>;

    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      padding: EdgeInsets.only(left: 4, right: 12, top: 4, bottom: 4),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              changeToDoStatus(item);
              // Call the function to change the state of the todo list
            },
            splashRadius: 22,
            splashColor: Colors.green,
            icon: Icon(
              icon,
              size: 32,
              color: borderColor,
            ),
          ),
          Column(
            children: [
              Text(
                item.getTitle(),
                style: TextStyle(
                    fontSize: 18,
                    decoration: status
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              !status ? Text(item.getSubTitle()) : Container()
            ],
          ),
          IconButton(
            //Delete Button
            splashRadius: 22,
            splashColor: Colors.red,
            icon: Icon(
              Icons.delete_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              // Call function to delete the item
              deleteATodo(item);
            },
          )
        ],
      ),
    );
  }
}

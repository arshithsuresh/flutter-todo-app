import 'package:flutter/foundation.dart';

// A Modal class is a template of an item that we use
// Here a ToDo entry is treated as an item
// The ToDo item will have some properties that may vary for different objects.

class ToDoModel
{
    String documentId;
    String _title;          // Title of the ToDo
    String _subTitle;       // Description of what it means
    bool _done = false;     // Status of the todo that is if it's finished or not finished 

    ToDoModel({@required String title, @required String subtitle})
    {
        // This is the constructor of the Class with named parameters to initialize the values
        // @required keyword state that the title and subtitle parameters are required to create the object
        // of this class

        this._title = title;
        this._subTitle = subtitle;
    }

    void setStatus(bool status)     // To set the status of the ToDo item
    {
        this._done = status;
    }  

    Map<String,dynamic>toJson(){
      return {
        "title": _title,
        "subtitle": _subTitle,
        "done":_done
      };
    }

    ToDoModel.fromJson(Map<String,dynamic> jsonData, String docId){
      documentId = docId;
      _title = jsonData['title'];
      _subTitle = jsonData['subtitle'];
      _done = jsonData['done'];
    }

    String getSubTitle()            // This function is used to retreive the private variable Title of the class
    {
      return this._subTitle;
    }
    String getTitle(){              // Same function as above
      return this._title;
    }
    bool getStatus(){
      return this._done;
    }
}
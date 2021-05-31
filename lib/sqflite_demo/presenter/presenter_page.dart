import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_27may2021/sqflite_demo/database/database.dart';
import 'package:flutter_27may2021/sqflite_demo/model/vritti_mobile_app_developer.dart';

class Presenter extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return PresenterState();
  }

}

class PresenterState extends State{
  var db;
  var txtControllerFName=new TextEditingController();
  var txtControllerLName=new TextEditingController();
  var txtControllerEmailId=new TextEditingController();

 var txtControllerFNameD=new TextEditingController();
  var txtControllerLNameD=new TextEditingController();
  var txtControllerEmailIdD=new TextEditingController();

  @override
  void initState() {
    super.initState();
    initDataBase();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite Demo"),),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(3),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(3),
                        child: TextField(
                          autofocus: false,
                          controller:txtControllerFName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter First Name',
                          ),
                        ),),

                      Padding(padding: EdgeInsets.all(3),
                        child: TextField(
                          autofocus: false,
                          controller:txtControllerLName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Last Name',
                          ),
                        ),),
                      Padding(padding: EdgeInsets.all(3),
                        child: TextField(
                          autofocus: false,
                          controller:txtControllerEmailId,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Email Address',
                          ),
                        ),),
                    ],
                  ),),


                RaisedButton(
                  onPressed: ()async{
                    insertData();
                    clearFields();
                  },
                  color: Colors.indigo.shade500,
                  child: Text("Insert",style: TextStyle(color: Colors.white),),),


                Expanded(
                    child: FutureBuilder(
                        future: fetchData(),
                        builder: (BuildContext context,AsyncSnapshot snapShot){
                          if(snapShot.data!=null){
                            return ListView.builder(
                                itemCount: snapShot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return
                                    Container(
                                    margin: EdgeInsets.all(3),
                                    child: Card(
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child:Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(padding: EdgeInsets.all(0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Row(
                                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(padding: EdgeInsets.all(10),
                                                      child:  Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("First Name :- ",style: TextStyle(color: Colors.blueGrey,fontSize: 15,fontWeight: FontWeight.normal),),
                                                          SizedBox(height: 5,),
                                                          Text(snapShot.data[index].firstName,style: TextStyle(color: Colors.blueGrey,fontSize: 20,fontWeight: FontWeight.bold),)
                                                        ],
                                                      ),),
                                                    Padding(padding: EdgeInsets.all(10),
                                                      child:  Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Last Name :- ",style: TextStyle(color: Colors.blueGrey,fontSize: 15,fontWeight: FontWeight.normal),),
                                                          SizedBox(height: 5,),
                                                          Text(snapShot.data[index].lastName,style: TextStyle(color: Colors.blueGrey,fontSize: 20,fontWeight: FontWeight.bold),)
                                                        ],
                                                      ),),

                                                  ],
                                                ),


                                                Padding(padding: EdgeInsets.all(10),
                                                  child:  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Email :- ",style: TextStyle(color: Colors.blueGrey,fontSize: 15,fontWeight: FontWeight.normal),),
                                                      SizedBox(height: 5,),
                                                      Text(snapShot.data[index].email,style: TextStyle(color: Colors.blueGrey,fontSize: 20,fontWeight: FontWeight.bold),)
                                                    ],
                                                  ),),

                                              ],
                                            ),),

                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                FlatButton(
                                                    onPressed: (){
                                                      updateData(snapShot.data[index]);
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Icon(Icons.update_rounded,color: Colors.indigo.shade500,),
                                                        Text("Update",style: TextStyle(color: Colors.indigo.shade500,fontSize: 15,fontWeight: FontWeight.bold),)
                                                      ],
                                                    )),
                                                FlatButton(
                                                    onPressed: (){
                                                      deleteData(snapShot.data[index]);
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Icon(Icons.delete_forever_outlined,color: Colors.indigo.shade500,),
                                                        Text("Delete",style: TextStyle(color: Colors.indigo.shade500,fontSize: 15,fontWeight: FontWeight.bold),)
                                                      ],
                                                    )),
                                              ],
                                            )
                                          ],
                                        )
                                      ),
                                    ),
                                  );
                                });
                          }else{
                            return const CircularProgressIndicator();
                          }
                        }))
              ],
            ),
          ),
      )
    );
  }




  //To Initialize Database Object
  void initDataBase() async{
    DatabaseLocal databaseLocal = new DatabaseLocal();
    db= await databaseLocal.createDatabase();
  }

  //To Close Database Object
  void closeDataBase() async{
    await db.close();
  }


  //Fetch Data From Database
  fetchData() async{

    //Using The Query Method
    //var result = await db.query("VrittiMobileAppDevelopers", columns: ["id", "first_name", "last_name", "email"],orderBy: "id DESC",);

    //Using Raw Query
    var result = await db.rawQuery('SELECT * FROM VrittiMobileAppDevelopers ORDER BY id DESC');


    List <VrittiMobileAppDeveloper>  developerModelList = new List();
    for(var modelR in result.toList()){

      VrittiMobileAppDeveloper appDeveloper = new VrittiMobileAppDeveloper(
          id: modelR['id'],
          firstName: modelR['first_name'],
          lastName: modelR['last_name'],
          email: modelR['email']);

      developerModelList.add(appDeveloper);
    }

    return developerModelList;
  }


  //Insert Data Into Database
  void insertData() async{

    VrittiMobileAppDeveloper appDeveloper= new  VrittiMobileAppDeveloper();
    appDeveloper.firstName=txtControllerFName.text;
    appDeveloper.lastName=txtControllerLName.text;
    appDeveloper.email=txtControllerEmailId.text;

    var result = await db.insert("VrittiMobileAppDevelopers", appDeveloper.toJson());

    print("INSERTED RESULT");
    print(result);

    setState(() {

    });
  }


  //Update Data Into Database
  void updateData(appDeveloper) async{

    txtControllerFNameD.text=appDeveloper.firstName;
    txtControllerLNameD.text=appDeveloper.lastName;
    txtControllerEmailIdD.text=appDeveloper.email;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:   Padding(padding: EdgeInsets.all(5),
          child: Text(
            "Updating Data For Id :- "+appDeveloper.id.toString(),
            style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 14),
          ),),
        content:SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [

                  Padding(padding: EdgeInsets.all(5),
                    child: TextField(
                      controller:txtControllerFNameD,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter First Name',
                      ),
                    ),),

                  Padding(padding: EdgeInsets.all(5),
                    child: TextField(
                      controller:txtControllerLNameD,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Last Name',
                      ),
                    ),),
                  Padding(padding: EdgeInsets.all(5),
                    child: TextField(
                      controller:txtControllerEmailIdD,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Email Address',
                      ),
                    ),),
                ],
              ),),
          ),
        ),

        actions: <Widget>[
          FlatButton(
            onPressed: () async{
              appDeveloper.firstName=txtControllerFNameD.text;
              appDeveloper.lastName=txtControllerLNameD.text;
              appDeveloper.email=txtControllerEmailIdD.text;

              //Update Using Query Method
              //var update= await db.update("VrittiMobileAppDevelopers", appDeveloper.toJson(), where: "id = ?", whereArgs: [appDeveloper.id]);

              //Update Using Rawupdate Method
              var update=  await db.rawUpdate(
                  'UPDATE VrittiMobileAppDevelopers SET first_name = ${'"'+appDeveloper.firstName+'"'}, last_name = ${'"'+appDeveloper.lastName+'"'}, email = ${'"'+appDeveloper.email+'"'} WHERE id = ${appDeveloper.id}'
              );



              print("UPDATE RESULT");
              print(update);
              setState(() {});

              clearFields();
              Navigator.pop(context);

              },

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.update_rounded,color: Colors.indigo.shade500,),
                Text("Update",style: TextStyle(color: Colors.indigo.shade500,fontSize: 16,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ],
      ),
    );

  }





  //Update Data From Database
  void deleteData(appDeveloper) async{

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:   Padding(padding: EdgeInsets.all(5),
          child: Text(
            "Deleting Data For Id :- "+appDeveloper.id.toString(),
            style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 14),
          ),),
        content: Text("Are You Sure You Want To Delete?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () async{
              //Using Delete Method
              //var deleteData=await db.delete("VrittiMobileAppDevelopers", where: 'id = ?', whereArgs: [appDeveloper.id]);

              //Using RawDelete Method
              var deleteData=await db.rawDelete('DELETE FROM VrittiMobileAppDevelopers WHERE id = ${appDeveloper.id}');


              print("DELETE RESULT");
              print(deleteData);
              setState(() {});

              Navigator.of(ctx).pop();

            },
            child: Text("Yes",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("No",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );

  }

  void clearFields() {
    txtControllerFName.text='';
    txtControllerLName.text='';
    txtControllerEmailId.text='';
  }


}
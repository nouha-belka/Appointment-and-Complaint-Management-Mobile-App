import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/reclamation/rec_tile.dart';
import 'package:trying_database_php/real_app/reclamation/reclamation.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import 'dart:convert';
import 'dart:collection';
import 'package:http/http.dart' as http;
import '../library.dart' as global;
class ReclList extends StatefulWidget {
  const ReclList({Key? key}) : super(key: key);

  @override
  _ReclListState createState() => _ReclListState();
}

class _ReclListState extends State<ReclList> {
  List<Reclamation> recs = [];
  var codes = ['tout','sans compteur','122222','22'];
  var code = 'tout';

  void getList(String code) async{
    var url = "http://${global.localhost}/php_project/web-flutter/list_rec.php";
    var data = {
      "code_client_rech" : global.client_id,
      "code" : code
    };
    var res = await http.post(Uri.parse(url),body: data);
    //var res = await http.get(Uri.parse(url));
    var reasonsList =  jsonDecode(res.body);
      setState(() {
        recs= [];
      });
      for(var i = 0; i < reasonsList.length; i++){
        var map = HashMap.from((reasonsList[i]));
        setState(() {
          recs.add(Reclamation(id: map['id'],date: map['date'],numComp: map['code_copm'],etat: map['etat']),);
        });
        print(map);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList(code);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        title: Text(
          "Réclamation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      drawer: Menu(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 40,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(137, 137, 137, 0.6),
                      offset: Offset(0, 0.5), //(x,y)
                      blurRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(7),),
                ),
                padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: code,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: mainColor,
                      size: 40,
                    ),
                    items: codes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style:TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        code = newValue!;
                        getList(code);
                      });
                    },
                    isExpanded : true,
                    itemHeight: 60,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: ContainerDeco,
              height: MediaQuery.of(context).size.height*0.75,
              child: ListView(
                children: recs.map((rec){
                  return RecTile(rec: rec,);
                } ).toList(),)
            )
          ],
        ),
      ),
    );
  }
}

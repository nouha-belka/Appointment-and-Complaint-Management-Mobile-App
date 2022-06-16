class Client{
  String nom,prenom,date,email,tel;
  Client({required this.nom,required this.prenom,required this.date,required this.email, required this.tel});
}
var client_id ;
var compteur_id ;
var listComp = [];
String localhost = "192.168.56.1";
Client client = Client(nom: "",prenom: "",date: "",email: "",tel: "");
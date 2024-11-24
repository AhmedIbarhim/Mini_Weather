class FavouritesModel{

  late String name;

  FavouritesModel(this.name);

  FavouritesModel.fromTable(Map<String, dynamic> data){

    name = data["name"];
  }

}
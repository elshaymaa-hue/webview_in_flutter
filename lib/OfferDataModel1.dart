
class OfferDataModel1
{
int? id ;
String? photo;
String? directory;


// constructor
  OfferDataModel1(
      {
        this.id ,
        this.photo,
        this.directory,
      }
      );

  //method that assign values to respective datatype vairables
  OfferDataModel1.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    photo =json['photo'];
    directory =json['directory'];
  }
}
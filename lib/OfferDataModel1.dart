
class OfferDataModel1
{
int? id ;
String? photo;
String? directory;
String? test;
String? url;



// constructor
  OfferDataModel1(
      {
        this.id ,
        this.photo,
        this.directory,
        this.test,
        this.url,
      }
      );

  //method that assign values to respective datatype vairables
  OfferDataModel1.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    photo =json['photo'];
    directory =json['directory'];
    test =json['test'];
    url =json['url'];
  }
}
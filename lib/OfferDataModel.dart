
class OfferDataModel
{
int? id ;
String? name_ar;
String? price;
String? details_ar;
String? name_en;
String? details_en;
String? photo;
String? directory;
String? input;
String? output;
String? type;
String? status;
String? reply_on;
String? require_monitor;
String? monitor_date;
String? additions;
String? created_at;
String? updated_at;

// constructor
  OfferDataModel(
      {
        this.id ,
        this.name_ar,
        this.price,
        this.details_ar,
        this.name_en,
        this.details_en,
        this.photo,
        this.directory,
        this.input,
        this.output,
        this.type,
        this.status,
        this.reply_on,
        this.require_monitor,
        this.monitor_date,
        this.additions,
        this.created_at,
        this.updated_at,
      }
      );

  //method that assign values to respective datatype vairables
  OfferDataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name_ar =json['name_ar'];
    price = json['price'];
    details_ar =json['details_ar'];
    name_en =json['name_en'];
    details_en =json['details_en'];
    photo =json['photo'];
    directory =json['directory'];
    input =json['input'];
    output =json['output'];
    type =json['type'];
    status =json['status'];
    reply_on =json['reply_on'];
    require_monitor =json['require_monitor'];
    monitor_date =json['monitor_date'];
    additions =json['additions'];
    created_at =json['created_at'];
    updated_at =json['updated_at'];


  }
}
import 'package:news_app/model/categorymodel.dart';

List<Categorymodel> getcatagories(){
  List<Categorymodel> category=[];
  Categorymodel categorymodel=new Categorymodel();


  categorymodel.categoryname="Business";
  categorymodel.image="Assets/images/business.jpg";
  category.add(categorymodel);
  categorymodel=new Categorymodel();

  categorymodel.categoryname="Entertainment";
  categorymodel.image="Assets/images/entertainment.jpg";
  category.add(categorymodel);
  categorymodel=new Categorymodel();

  categorymodel.categoryname="General";
  categorymodel.image="Assets/images/general.jpg";
  category.add(categorymodel);
  categorymodel=new Categorymodel();

  categorymodel.categoryname="Health";
  categorymodel.image="Assets/images/health.jpg";
  category.add(categorymodel);
  categorymodel=new Categorymodel();

  categorymodel.categoryname="Science";
  categorymodel.image="Assets/images/science.jpg";
  category.add(categorymodel);
  categorymodel=new Categorymodel();

  categorymodel.categoryname="Sports";
  categorymodel.image="Assets/images/sport.jpg";
  category.add(categorymodel);
  categorymodel=new Categorymodel();

  return category;

}
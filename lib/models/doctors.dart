import 'package:flutter/cupertino.dart';
import 'dart:convert';

List<Doctors> doctorsFromJson(String str) => List<Doctors>.from(json.decode(str).map((x) => Doctors.fromJson(x)));

String doctorsToJson(List<Doctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Doctors{
   int id;
   String name;
   String department;
   String hospitalLocation;
   int experience;
   double rating;
   int likes;
   String imageUrl;

   Doctors({this.name, this.department, this.hospitalLocation, this.experience, this.rating,
      this.likes, this.imageUrl,this.id});

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
    id: json["id"],
    name: json["name"],
    department: json["department"],
    hospitalLocation: json["location"],
    experience:json["experience"],
    likes: json["likes"],
    rating: json["rating"],
    imageUrl: json["picture"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "department": department,
    "location": hospitalLocation,
    "experience": experience,
    "likes": likes,
    "rating": rating,
    "picture": imageUrl,
  };



   /*static List<Doctors> getDoctors() =>[
     Doctors(name: "Sherly Billman", id: 1,likes: 200,rating: 4.5,experience: 1,department: "Dentist", hospitalLocation: "Whitefiled",imageUrl: "assets/doctor_img.jpg"),
     Doctors(name: "Steve Smith", id: 2,likes: 300,rating: 3.5,experience: 3,department: "Physician", hospitalLocation: "Whitefiled",imageUrl: "assets/doctor_img1.jpg"),
     Doctors(name: "David Robertson", id: 3,likes: 250,rating: 4.2,experience: 5,department: "Dermatology", hospitalLocation: "Whitefiled",imageUrl: "assets/doctor_img2.jpg"),
     Doctors(name: "Williamson", id: 4,likes: 230,rating: 4.0,experience: 2,department: "Dentist", hospitalLocation: "Whitefiled",imageUrl: "assets/doctor_img3.png"),
     Doctors(name: "Annie Jacob", id: 5,likes: 340,rating: 3.9,experience: 8,department: "Physician", hospitalLocation: "Whitefiled",imageUrl: "assets/doctor_img4.jpg"),
   ];*/
}
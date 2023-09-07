import 'dart:ui';


class NewsModel {
  String? status;
  int? totalResults;
  List<Article>? results;
  String? nextPage;

  NewsModel({this.status, this.totalResults, this.results, this.nextPage});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = <Article>[];
      json['results'].forEach((v) {
        results!.add(Article.fromJson(v));
      });
    }
    //nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
  //  data['nextPage'] = this.nextPage;
    return data;
  }
}

class Article {
  String? title;
  String? link;
  List<String>? keywords;
  List<String>? creator;
  void videoUrl;
  String? description;
  String? content;
  String? pubDate;
  String? imageUrl;
  String? sourceId;
  int? sourcePriority;
  List<String>? country;
  List<String>? category;
  String? language;

  Article(
      {this.title,
      this.link,
      this.keywords,
      this.creator,
      this.videoUrl,
      this.description,
      this.content,
      this.pubDate,
      this.imageUrl,
      this.sourceId,
      this.sourcePriority,
      this.country,
      this.category,
      this.language});

 Article.fromJson(Map<String, dynamic> json) {
  title = json['title'];
  link = json['link'];
  keywords = json['keywords'] != null ? List<String>.from(json['keywords']) : null;
  creator = json['creator'] != null ? List<String>.from(json['creator']) : null;
  //videoUrl = json['video_url']; // Or provide a default value
  description = json['description'];
  content = json['content'];
  pubDate = json['pubDate'];
  imageUrl = json['image_url'];
  sourceId = json['source_id'];
  sourcePriority = json['source_priority'];
  country = json['country'] != null ? List<String>.from(json['country']) : null;
  category = json['category'] != null ? List<String>.from(json['category']) : null;
  language = json['language'];
}


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['keywords'] = keywords;
    data['creator'] = creator;
  //  data['video_url'] = videoUrl;
    data['description'] = description;
    data['content'] = content;
    data['pubDate'] = pubDate;
    data['image_url'] = imageUrl;
    data['source_id'] = sourceId;
    data['source_priority'] = sourcePriority;
    data['country'] = country;
    data['category'] = category;
    data['language'] = language;
    return data;
  }
}
class Discovery {
  const Discovery({
   required this.id,
    required this.title,
    required this.color,
    required this.flagImagePath
  });
   final String id;
  final String title;
  final Color color;
  final String flagImagePath;
   
  }
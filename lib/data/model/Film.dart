class Film {
  String? title;
  int? episodeId;
  String? openingCrawl;
  String? director;
  String? producer;
  String? releaseDate;
  List<String>? characters;
  String? created;
  String? edited;
  String? url;

  Film({
    this.title,
    this.episodeId,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters,
    this.created,
    this.edited,
    this.url,});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      title: json['title'],
      episodeId: json['episode_id'],
      openingCrawl: json['opening_crawl'],
      director: json['director'],
      producer: json['producer'],
      releaseDate: json['release_date'],
      characters: json['characters'] != null ? List<String>.from(json['characters']) : null,
      created: json['created'],
      edited: json['edited'],
      url: json['url'],
    );
  }



}
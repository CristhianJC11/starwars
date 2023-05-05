class Author {
  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? homeWorld;
  List<String>? films;
  String? created;
  String? edited;
  String? url;

  Author({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeWorld,
    this.films,
    this.created,
    this.edited,
    this.url
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      height: json['height'].toString(),
      mass: json['mass'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      homeWorld: json['homeworld'],
      films: List<String>.from(json['films']?.map((x) => x.toString()) ?? []),
      created: json['created'],
      edited: json['edited'],
      url: json['url'],
    );
  }


}
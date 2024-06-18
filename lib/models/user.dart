class Users {
  String? uId;
  String name;
  String description;
  int years;
  String? profileImageUrl; // Novo campo para a URL da imagem de perfil

  Users({
    this.uId,
    required this.name,
    required this.description,
    required this.years,
    this.profileImageUrl, // Inicialize o campo
  });

  factory Users.fromMap(Map map) {
    return Users(
      uId: map['uId'],
      name: map['name'],
      description: map['description'],
      years: map['years'],
      profileImageUrl: map['profileImageUrl'], // Obtenha o campo do mapa
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'description': description,
      'years': years,
      'profileImageUrl': profileImageUrl, // Adicione o campo ao mapa
    };
  }
}

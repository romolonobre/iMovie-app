import 'package:app_services/app_services.dart';
import 'package:imovie_app/app/movie_details/interactor/entities/cast.dart';

class CastAdapter extends EntityAdaptor<Cast> {
  @override
  Cast fromJson(json) {
    return Cast(
      name: Helper.getString(json['name']),
      character: Helper.getString(json['character']),
      image: Utils.imageBasePath + Helper.getString(json['profile_path']),
    );
  }

  @override
  List<Cast> fromJsonToList(json) {
    if (json == null) return [];
    final List<Cast> casts = [];

    json["cast"].forEach((e) {
      final Cast cast = CastAdapter().fromJson(e);
      casts.add(cast);
    });

    return casts;
  }

  @override
  Map<String, dynamic> toMap(Cast value) => {};
}

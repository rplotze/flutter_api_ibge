import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/estado.dart';
import '../model/municipio.dart';

class IbgeService {
  //
  // RETORNAR uma lista de Estados
  //
  Future<List<Estado>> listarEstados() async {
    var resposta = await http.get(
      Uri.parse(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome',
      ),
    );

    if (resposta.statusCode == 200) {
      //Resposta recebida com sucesso
      Iterable lista = json.decode(resposta.body);
      return lista.map((modelo) => Estado.fromJson(modelo)).toList();
    }
    return [];
  }

  //
  // RETORNAR uma lista de Municípios por Estado
  //
  Future<List<Municipio>> listarMunicipios(String id) async {
    var resposta = await http.get(
      Uri.parse(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$id/municipios',
      ),
    );

    if (resposta.statusCode == 200) {
      //Resposta recebida com sucesso
      Iterable lista = json.decode(resposta.body);
      return lista.map((modelo) => Municipio.fromJson(modelo)).toList();
    }
    return [];
  }
}

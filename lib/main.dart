// ignore_for_file: prefer_const_constructors

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'model/estado.dart';
import 'model/municipio.dart';
import 'service/ibge_service.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Estados'),
        ),
        body: FutureBuilder(
          future: IbgeService().listarEstados(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var lista = snapshot.data as List<Estado>;
              return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        '${lista[index].nome} (${lista[index].sigla})',
                      ),
                      subtitle: Text('Região ${lista[index].regiao}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MunicipioView(
                              lista[index].id.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            //return Center(child: LinearProgressIndicator());
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class MunicipioView extends StatefulWidget {
  final String estadoId;

  const MunicipioView(this.estadoId, {super.key});

  @override
  State<MunicipioView> createState() => _MunicipioViewState();
}

class _MunicipioViewState extends State<MunicipioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Municípios'),
      ),
      body: FutureBuilder(
        future: IbgeService().listarMunicipios(widget.estadoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var lista = snapshot.data as List<Municipio>;
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(lista[index].nome),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

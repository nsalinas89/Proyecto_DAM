import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventosProvider {
  final apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getEventos() async {
    var respuesta = await http.get(Uri.parse(apiURL + '/eventos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getClientes() async {
    var respuesta = await http.get(Uri.parse(apiURL + '/clientes'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> agregar(String rut,
      String nombre, String correo,String telefono) async {
    var respuesta = await http.post(Uri.parse(apiURL + '/clientes'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'rut_cliente': rut,
        'nombre_cliente': nombre,
        'correo_cliente': correo,
        'telefono_cliente': telefono,
      }),
    );

    return json.decode(respuesta.body);
  }

  Future<bool> borrar(String cod_evento) async {
    var respuesta = await http.delete(Uri.parse(apiURL + '/eventos/' + cod_evento));
    return respuesta.statusCode == 200;

    // if (respuesta.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
  Future<LinkedHashMap<String, dynamic>> editar(String cod_evento_actual,
      String cod_evento_nuevo, String nombre_evento,String lugar_evento ,DateFormat fecha_evento ,TimeOfDayFormat hora_evento,int precio) async {
    var respuesta = await http.put(
      Uri.parse(apiURL + '/eventos/' + cod_evento_actual),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'cod_evento': cod_evento_nuevo,
        'nombre_evento': nombre_evento,
        'lugar_evento': lugar_evento,
        'fecha_evento': fecha_evento,
        'hora_evento': hora_evento,
        'precio': precio,
      }),
    );
    return json.decode(respuesta.body);
  }
}



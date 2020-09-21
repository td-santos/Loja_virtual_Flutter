
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:virtual_store/models/cepaberto_addess.dart';

const token = '3f34c7a6fb9a570620de7c69b5f2d9a4';

class CepAbertoService{

  Future<CepAbertAddress> getAdressFromCep(String cep)async{
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint= 'https://www.cepaberto.com/api/v3/cep?cep=$cleanCep';

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try{

      final response = await dio.get<Map<String,dynamic>>(endpoint);

      if(response.data.isEmpty){
        return Future.error('Cep Invalido');
      }

      final CepAbertAddress address = CepAbertAddress.fromMap(response.data);
      
      return address;

    }on DioError catch (e){
      return Future.error('Erro ao buscar Cep!');
    }

  }
}
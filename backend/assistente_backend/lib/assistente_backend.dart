import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:mysql1/mysql1.dart';

// Middleware para adicionar cabeçalhos de CORS às respostas
Middleware corsHeadersMiddleware({Map<String, String>? headers}) {
  final corsHeaders = headers ??
      {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type',
      };

  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }

      final response = await innerHandler(request);
      return response.change(headers: corsHeaders);
    };
  };
}

// Handler para buscar notebooks
Future<Response> getNotebooks(Request request) async {
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '@Inspiron1',
    db: 'db_assistente',
  );

  try {
    // Conectando ao banco de dados MySQL
    final conn = await MySqlConnection.connect(settings);
    // Executando a consulta SQL
    var results =
        await conn.query('SELECT modelo, cor, nome_dono FROM notebooks');

    // Convertendo os resultados para uma lista de mapas
    var notebooksList = results
        .map((row) => {'modelo': row[0], 'cor': row[1], 'nome_dono': row[2]})
        .toList();

    // Fechando a conexão
    await conn.close();

    // Retornando os resultados como JSON
    return Response.ok(
      jsonEncode(notebooksList),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    // Em caso de erro, retornar uma resposta adequada
    return Response.internalServerError(
        body: 'Erro ao acessar o banco de dados');
  }
}

void main(List<String> args) async {
  // Configurando o router
  final router = Router()..get('/notebooks', getNotebooks);

  // Adicionando o middleware de CORS
  final handler = const Pipeline()
      .addMiddleware(corsHeadersMiddleware())
      .addHandler(router);

  // Configurando o servidor
  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Servidor rodando em http://${server.address.host}:${server.port}');
}

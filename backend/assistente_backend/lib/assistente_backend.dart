import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:mysql1/mysql1.dart';

// Handler para buscar notebooks
Future<Response> getNotebooks(Request request) async {
  final settings = ConnectionSettings(
    host: 'localhost', // Substitua com o endereço do seu servidor MySQL
    port: 3306,
    user: 'seu_usuario',
    password: 'sua_senha',
    db: 'nome_do_seu_banco',
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
      notebooksList.toString(),
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

  // Configurando o servidor
  final server = await shelf_io.serve(router, 'localhost', 8080);
  print('Servidor rodando em http://${server.address.host}:${server.port}');
}

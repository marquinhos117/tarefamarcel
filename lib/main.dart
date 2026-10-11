import 'package:flutter/material.dart';
import 'package:lista_loja/telas/tela_cadastro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPrincipal(),
    );
  }
}

// tela principal com a lista
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  // lista dos anuncios salva na memoria
  List<Anuncio> listaAnuncios = [];

  // vai para a tela de cadastro
  void _irParaCadastro() async {
    // abre a tela 2 e espera voltar com os dados
    Anuncio? resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastro()),
    );

    // se voltou com anuncio preenchido, adiciona na lista
    if (resultado != null) {
      setState(() {
        listaAnuncios.add(resultado);
      });
    }
  }

  // vai para a tela de editar
  void _irParaEditar(int index) async {
    // abre a tela 2 no anuncio que quer editar
    Anuncio? resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaCadastro(anuncioParaEditar: listaAnuncios[index]),
      ),
    );

    // se voltou com o anuncio editado, atualiza na lista
    if (resultado != null) {
      setState(() {
        listaAnuncios[index] = resultado;
      });
    }
  }

  // apaga o anuncio da lista
  void _remover(int index) {
    setState(() {
      listaAnuncios.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // esqueleto da tela principal
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mercado Preso"),
        backgroundColor: Colors.amber, // amarelo tipo mercado livre
      ),
      // botao de adicionar (quadrado)
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(),
        backgroundColor: Colors.amber,
        onPressed: _irParaCadastro,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: listaAnuncios.length,
        itemBuilder: (context, index) {
          Anuncio item = listaAnuncios[index];

          // card simples para cada anuncio (cantos quadrados)
          return Card(
            shape: const RoundedRectangleBorder(),
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(
                Icons.shopping_bag,
                size: 40,
                color: Colors.orange,
              ), // icone do produto
              title: Text(
                item.titulo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${item.descricao}\nR\$ ${item.preco}"),
              // botao  de editar e excluir no final do card
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _irParaEditar(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _remover(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

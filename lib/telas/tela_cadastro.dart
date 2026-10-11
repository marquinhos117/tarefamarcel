import 'package:flutter/material.dart';

// molde do anuncio com os dados
class Anuncio {
  String titulo;
  String descricao;
  double preco;

  Anuncio({required this.titulo, required this.descricao, required this.preco});
}

//coloquei StatefulWidget para conseguir pegar o texto digitado e saber ta digitando
class TelaCadastro extends StatefulWidget {
  // se vier preenchido e edicao, se vier vazio e um novo cadastro
  final Anuncio? anuncioParaEditar;

  const TelaCadastro({super.key, this.anuncioParaEditar});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // controlador pra pegar o texto dos campos
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // se estiver editando, coloca os textos antigos nos campos
    if (widget.anuncioParaEditar != null) {
      _tituloController.text = widget.anuncioParaEditar!.titulo;
      _descricaoController.text = widget.anuncioParaEditar!.descricao;
      _precoController.text = widget.anuncioParaEditar!.preco.toString();
    }
  }

  // funcao de salvar
  void _salvar() {
    // pega os valores digitados
    String nome = _tituloController.text;
    String desc = _descricaoController.text;
    double valor = double.tryParse(_precoController.text) ?? 0.0;

    // se tiver nome, cria o anuncio
    if (nome.isNotEmpty) {
      Anuncio novo = Anuncio(titulo: nome, descricao: desc, preco: valor);

      // volta para a tela 1 e devolve o anuncio
      Navigator.pop(context, novo);
    }
  }

  @override
  Widget build(BuildContext context) {
    // esqueleto da tela
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.anuncioParaEditar != null
              ? "Editar Anúncio"
              : "Cadastrar Anúncio",
        ),
        backgroundColor: Colors.amber,
      ),
      // botao de salvar (quadrado)
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(),
        backgroundColor: Colors.amber,
        onPressed: _salvar,
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // aqui coloco o nome dos produtos >
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: "Produto",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),
            // aqui coloco a descricao >
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),
            // aqui coloco preço >
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(
                labelText: "Preço",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ], // sempre que vou iniciar um bloquinho novo, defino o sizedbox, posso criar uma e replicar as outras alterando somente os controllers e as labels.
        ),
      ),
    );
  }
}

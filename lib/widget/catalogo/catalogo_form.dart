import 'package:flutter/material.dart';
import 'package:pudins_da_nega/dominio/catalogo/tamanho.dart';
import 'package:pudins_da_nega/dominio/catalogo/ingrediente.dart';
import 'package:pudins_da_nega/widget/catalogo/catalogo_form_back.dart';

class CatalogoForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  Widget fieldNome(CatalogoFormBack back) {
    return TextFormField(
      validator: back.validateName,
      onSaved: (newValue) => back.catalogo.nome = newValue!,
      initialValue: back.catalogo.nome,
      decoration: InputDecoration(labelText: 'Nome:'),
    );
  }

  Widget fieldDescricao(CatalogoFormBack back) {
    return TextFormField(
      validator: back.validateDescricao,
      onSaved: (newValue) => back.catalogo.descricao = newValue!,
      initialValue: back.catalogo.descricao,
      decoration: InputDecoration(labelText: 'Descrição:'),
    );
  }

  Widget fieldQuantidade(CatalogoFormBack back) {
    return TextFormField(
      validator: back.validateQuantidade,
      onSaved: (newValue) => back.catalogo.quantidade = int.parse(newValue!),
      initialValue: back.catalogo.quantidade.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Quantidade:'),
    );
  }

  Widget fieldUrlAvatar(CatalogoFormBack back) {
    return TextFormField(
      validator: back.validateUrlAvatar,
      onSaved: (newValue) => back.catalogo.urlAvatar = newValue!,
      initialValue: back.catalogo.urlAvatar,
      decoration: InputDecoration(labelText: 'URL do Avatar:'),
    );
  }

  Widget fieldTamanhos(CatalogoFormBack back) {
    return Column(
      children: [
        ...back.catalogo.tamanhos.map((tamanho) {
          return Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tamanho:'),
                initialValue: tamanho.tamanho,
                onSaved: (value) => tamanho.tamanho = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Peso (kg):'),
                keyboardType: TextInputType.number,
                initialValue: tamanho.peso?.toString(),
                onSaved: (value) => tamanho.peso = double.tryParse(value ?? ''),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço (R\$):'),
                keyboardType: TextInputType.number,
                initialValue: tamanho.preco?.toString(),
                onSaved: (value) =>
                    tamanho.preco = double.tryParse(value ?? ''),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget fieldIngredientes(CatalogoFormBack back) {
    return Column(
      children: [
        ...back.catalogo.ingredientes.map((ingrediente) {
          return Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Ingrediente:'),
                initialValue: ingrediente.ingrediente,
                onSaved: (value) => ingrediente.ingrediente = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Causa Alergia:'),
                initialValue: ingrediente.causaAlergia,
                onSaved: (value) => ingrediente.causaAlergia = value,
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget fieldStatus(CatalogoFormBack back) {
    return DropdownButtonFormField<String>(
      value: back.catalogo.status,
      onChanged: (newValue) {
        if (newValue != null) {
          back.validateStatus(newValue);
        }
      },
      validator: back.validateStatus,
      items: [
        DropdownMenuItem(child: Text('Ativo'), value: 'A'),
        DropdownMenuItem(child: Text('Inativo'), value: 'I'),
      ],
      decoration: InputDecoration(labelText: 'Status:'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _back = CatalogoFormBack(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Catálogo'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_form.currentState!.validate()) {
                _form.currentState!.save();
                if (_back.isValid) {
                  _back.save();
                  Navigator.of(context).pop();
                }
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              fieldNome(_back),
              fieldDescricao(_back),
              fieldQuantidade(_back),
              fieldUrlAvatar(_back),
              fieldTamanhos(_back),
              fieldIngredientes(_back),
              fieldStatus(_back),
            ],
          ),
        ),
      ),
    );
  }
}

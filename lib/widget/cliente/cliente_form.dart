import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pudins_da_nega/widget/cliente/cliente_form_back.dart';

class ClienteForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  Widget fieldNome(ClienteFormBack back) {
    return TextFormField(
      validator: back.validateName,
      onSaved: (newValue) => back.cliente.nome = newValue!,
      initialValue: back.cliente.nome,
      decoration: InputDecoration(labelText: 'Nome:'),
    );
  }

  Widget fieldCPF(ClienteFormBack back) {
    var mask = MaskTextInputFormatter(mask: '###.###.###-##');
    return TextFormField(
      validator: back.validateCPF,
      onSaved: (newValue) => back.cliente.cpf = newValue!,
      initialValue: back.cliente.cpf,
      inputFormatters: [mask],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'CPF:'),
    );
  }

  Widget fieldCEP(ClienteFormBack back) {
    var mask = MaskTextInputFormatter(mask: '#####-###');
    return TextFormField(
      validator: back.validateCEP,
      onSaved: (newValue) => back.cliente.cep = newValue!,
      initialValue: back.cliente.cep,
      inputFormatters: [mask],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'CEP:'),
    );
  }

  Widget fieldPhone(ClienteFormBack back) {
    var mask = MaskTextInputFormatter(mask: '(##) # ####-####');
    return TextFormField(
      validator: back.validatePhone,
      onSaved: (newValue) => back.cliente.telefone = newValue!,
      initialValue: back.cliente.telefone,
      inputFormatters: [mask],
      keyboardType: TextInputType.phone,
      decoration:
          InputDecoration(labelText: 'Telefone:', hintText: '(99) 9 9999-9999'),
    );
  }

  Widget fieldStatus(ClienteFormBack back) {
    return DropdownButtonFormField<String>(
      value: back.cliente.status,
      onChanged: (newValue) {
        if (newValue != null) {
          back.validateStatus(newValue);
        }
      },
      validator: (value) {
        return back.validateStatus(
            value); // Chama a função de validação para verificar o status
      },
      items: [
        DropdownMenuItem(child: Text('Ativo'), value: 'A'),
        DropdownMenuItem(child: Text('Inativo'), value: 'I'),
      ],
      decoration: InputDecoration(labelText: 'Status:'),
    );
  }

 Widget fieldEndereco(ClienteFormBack back) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    
    children: [
      Text('Endereço:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

      // Campo Rua
      TextFormField(
        initialValue: back.cliente.endereco.rua,
        onSaved: (newValue) => back.cliente.endereco.rua = newValue!,
        decoration: InputDecoration(labelText: 'Rua:'),
      ),

      // Campo Número
      TextFormField(
        initialValue: (back.cliente.endereco.numero?.toString() ?? ' '),
        onSaved: (newValue) =>
            back.cliente.endereco.numero = int.parse(newValue!),
        decoration: InputDecoration(labelText: 'Número:'),
        keyboardType: TextInputType.number,
      ),

      // Campo Bairro
      TextFormField(
        initialValue: back.cliente.endereco.bairro ?? ' ',
        onSaved: (newValue) => back.cliente.endereco!.bairro = newValue!,
        decoration: InputDecoration(labelText: 'Bairro:'),
      ),

      // Campo Cidade
      TextFormField(
        initialValue: back.cliente.endereco.cidade ?? ' ',
        onSaved: (newValue) => back.cliente.endereco!.cidade = newValue!,
        decoration: InputDecoration(labelText: 'Cidade:'),
      ),

      // Campo Estado
      TextFormField(
        initialValue: back.cliente.endereco.estado ?? ' ',
        onSaved: (newValue) => back.cliente.endereco?.estado = newValue!,
        decoration: InputDecoration(labelText: 'Estado:'),
      ),

      // Campo Complemento
      TextFormField(
        initialValue: back.cliente.endereco.complemento ?? ' ',
        onSaved: (newValue) =>
            back.cliente.endereco.complemento = newValue!,
        decoration: InputDecoration(labelText: 'Complemento:'),
      ),
    ],
  );
}

  Widget fieldUrlAvatar(ClienteFormBack back) {
    return TextFormField(
      validator: back.validateUrlAvatar,
      onSaved: (newValue) => back.cliente.urlAvatar = newValue!,
      initialValue: back.cliente.urlAvatar,
      decoration: InputDecoration(labelText: 'URL do Avatar:'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _back = ClienteFormBack(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _back.validateEndereco(_back.cliente.endereco);
              if (_form.currentState!.validate()) {
                _form.currentState!.save();
                if (_back.isValid) {
                  _back.save();
                  Navigator.of(context).pop(true);
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
          child: Column(
            children: [
              fieldNome(_back),
              fieldCPF(_back),
              fieldCEP(_back),
              fieldPhone(_back),
              fieldStatus(_back),
              fieldUrlAvatar(_back),
              fieldEndereco(_back),
            ],
          ),
        ),
      ),
    );
  }
}

class CPF {
  late List<int> numerosCPF;

  CPF(String? cpf) {
    eVazio(cpf);
    cpf = cpf!.replaceAll(RegExp(r'\D'), '');
    numerosCPF = cpf.split('').map(int.parse).toList();
  }

  eVazio(String? cpf) {
     if (cpf == null) throw Exception('CPF não pode ser nulo!');
    if (cpf.isEmpty) throw Exception('CPF não pode ser vazio!');
  }

  bool ehOnzeNumeros() {
    numerosCPF.forEach(print);
    if (numerosCPF.length != 11) throw Exception('CPF precisa ter 11 números');
    return true;
  }

  bool ehNumeroDiferente() {
    var diferente = false;
    for (int i = 0; i < 9; i++) {
      if (numerosCPF[i] != numerosCPF[i + 1]) {
        diferente = true;
        break;
      }
    }
    if (diferente == false) {
      throw Exception('CPF não pode ter números iguais');
    }
    return diferente;
  }

  bool ehDigitoCorreto() {
    verificarPrimeiroDigito();
    verificarSegundoDigito();
    return true;
  }

  int calcularDigito(int indice) {
    var soma = 0;
    for (var peso = 9; indice >= 0; peso--, indice--) {
      soma += numerosCPF[indice] * peso;
    }
    var digito = soma % 11;
    if (digito == 10) digito = 0;
    return digito;
  }

  bool verificarPrimeiroDigito() {
    if (calcularDigito(8) != numerosCPF[9])
      throw Exception('Primeiro digito incorreto');
    return true;
  }

  bool verificarSegundoDigito() {
    if (calcularDigito(9) != numerosCPF[10])
      throw Exception('Segundo digito incorreto');
    return true;
  }

  validacao() {
    ehOnzeNumeros();
    ehNumeroDiferente();
    ehDigitoCorreto();
  }
}

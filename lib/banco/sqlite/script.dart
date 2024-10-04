const criarTabelas = [
  '''
    CREATE TABLE endereco (
      id INTEGER NOT NULL PRIMARY KEY,
      rua VARCHAR(200) NOT NULL,
      numero INTEGER NOT NULL,
      complemento VARCHAR(100),
      bairro VARCHAR(100) NOT NULL,
      cidade VARCHAR(100) NOT NULL,
      estado CHAR(2) NOT NULL
    );

    CREATE TABLE cliente (
      id INTEGER NOT NULL PRIMARY KEY,
      nome VARCHAR(200) NOT NULL,
      cpf CHAR(14) NOT NULL UNIQUE,
      cep CHAR(9) NOT NULL,
      telefone VARCHAR(15) NOT NULL,
      status CHAR(1) NOT NULL,
      url_avatar VARCHAR(300) NULL,
      endereco_id INTEGER NOT NULL,
      FOREIGN KEY (endereco_id) REFERENCES endereco(id)
    );
  '''
];

const inserirRegistros = [
  'INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES ("Rua A", 123, "Apto 1", "Bairro Central", "Cidade X", "PR")',
  'INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES ("Rua B", 456, "", "Bairro Sul", "Cidade Y", "SP")',
  'INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES("Rua C", 789, "Bloco B", "Bairro Norte", "Cidade Z", "RJ")',
  'INSERT INTO cliente (nome, cpf, cep, telefone, status, url_avatar, endereco_id) VALUES ("JOAQUIM", "391.650.590-42", "80000-000", "(41) 99999-9999", "A", "www.site.com" , 1)',
  'INSERT INTO cliente (nome, cpf, cep, telefone, status, url_avatar, endereco_id) VALUES ("MARIANA", "724.876.030-70", "80001-000", "(11) 98888-8888",  "I", "www.site.com" , 2)',
  'INSERT INTO cliente (nome, cpf, cep, telefone, status, url_avatar, endereco_id) VALUES ("ROBERTO", "959.358.840-03", "80002-000", "(21) 97777-7777",  "A", "www.site.com" , 3)'
];

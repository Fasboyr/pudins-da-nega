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
  ''',
  '''
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
  ''',
  '''
    CREATE TABLE catalogo (
      id INTEGER NOT NULL PRIMARY KEY,
      nome VARCHAR(100) NOT NULL,
      url_avatar VARCHAR(300) NOT NULL,
      descricao TEXT NOT NULL,
      quantidade INTEGER NOT NULL CHECK (quantidade >= 0),
      status CHAR(1) NOT NULL
    );
  ''',
  '''
    CREATE TABLE ingrediente (
      id INTEGER NOT NULL PRIMARY KEY,
      catalogo_id INTEGER NOT NULL,
      ingrediente VARCHAR(100) NOT NULL,
      causa_alergia VARCHAR(200) NULL,
      FOREIGN KEY (catalogo_id) REFERENCES catalogo(id)
    );
  ''',
  '''
    CREATE TABLE tamanho (
      id INTEGER NOT NULL PRIMARY KEY,
      catalogo_id INTEGER NOT NULL,
      tamanho VARCHAR(50) NOT NULL,
      peso DOUBLE NOT NULL CHECK (peso > 0),
      preco DOUBLE NOT NULL CHECK (preco > 0),
      FOREIGN KEY (catalogo_id) REFERENCES catalogo(id)
    );
  '''
];

const inserirRegistros = [
  // Endereços
  '''
  INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES ('Rua A', 123, 'Apto', 'Bairro Central', 'Cidade X', 'PR');
  ''',
  '''
  INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES ('Rua B', 456, 'Casa', 'Bairro Sul', 'Cidade Y', 'SP');
  ''',
  '''
  INSERT INTO endereco (rua, numero, complemento, bairro, cidade, estado) VALUES ('Rua C', 789, 'Bloco B', 'Bairro Norte', 'Cidade Z', 'RJ');
  ''',

  // Clientes
  '''
  INSERT INTO cliente (nome, cpf, cep, telefone, status, url_avatar, endereco_id) VALUES ('JOAQUIM', '391.650.590-42', '80000-000', '(41) 9 9999-9999', 'A', 'www.site.com', 1);
  ''',
  '''
  INSERT INTO cliente (nome, cpf, cep, telefone, status, url_avatar, endereco_id) VALUES ('MARIANA', '724.876.030-70', '80001-000', '(11) 9 8888-8888', 'I', 'www.site.com', 2);
  ''',
  '''
  INSERT INTO cliente (nome, cpf, cep, telefone, status, url_avatar, endereco_id) VALUES ('ROBERTO', '959.358.840-03', '80002-000', '(21) 9 7777-7777', 'A', 'www.site.com', 3);
  ''',

  // Catálogos
  '''
  INSERT INTO catalogo (nome, url_avatar, descricao, quantidade, status) 
  VALUES ('Pudim Tradicional', 'www.site.com/pudim-tradicional', 'Um delicioso pudim tradicional.', 100, 'A');
  ''',
  '''
  INSERT INTO catalogo (nome, url_avatar, descricao, quantidade, status) 
  VALUES ('Pudim Diet', 'www.site.com/pudim-diet', 'Pudim com menos açúcar, para dietas especiais.', 50, 'A');
  ''',
  '''
  INSERT INTO catalogo (nome, url_avatar, descricao, quantidade, status) 
  VALUES ('Pudim de Chocolate', 'www.site.com/pudim-chocolate', 'Um irresistível pudim de chocolate.', 70, 'I');
  ''',

  // Ingredientes
  '''
  INSERT INTO ingrediente (catalogo_id, ingrediente, causa_alergia) 
  VALUES (1, 'Leite Condensado', 'Intolerância à lactose');
  ''',
  '''
  INSERT INTO ingrediente (catalogo_id, ingrediente, causa_alergia) 
  VALUES (1, 'Ovos', 'Alérgico a ovo');
  ''',
  '''
  INSERT INTO ingrediente (catalogo_id, ingrediente, causa_alergia) 
  VALUES (2, 'Leite Desnatado', 'Intolerância à lactose');
  ''',

  // Tamanhos
  '''
  INSERT INTO tamanho (catalogo_id, tamanho, peso, preco) 
  VALUES (1, 'Pequeno', 0.5, 15.0);
  ''',
  '''
  INSERT INTO tamanho (catalogo_id, tamanho, peso, preco) 
  VALUES (1, 'Médio', 1.0, 25.0);
  ''',
  '''
  INSERT INTO tamanho (catalogo_id, tamanho, peso, preco) 
  VALUES (2, 'Grande', 1.5, 30.0);
  '''
];


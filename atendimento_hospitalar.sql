DROP TABLE IF EXISTS Procedimento, Atendimento, Medico, Especialidade, Paciente, Sala CASCADE;

CREATE TABLE Especialidade (
  id_especialidade SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  descricao TEXT
);

CREATE TABLE Paciente (
  id_paciente SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) UNIQUE NOT NULL,
  data_nascimento DATE,
  sexo CHAR(1),
  telefone VARCHAR(15),
  email VARCHAR(100),
  endereco TEXT
);

CREATE TABLE Sala (
  id_sala SERIAL PRIMARY KEY,
  numero VARCHAR(10),
  andar INT,
  tipo_de_sala VARCHAR(30)
);

CREATE TABLE Medico (
  id_medico SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  crm VARCHAR(20) UNIQUE NOT NULL,
  telefone VARCHAR(15),
  email VARCHAR(100),
  id_especialidade INT,
  FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id_especialidade)
);


CREATE TABLE Atendimento (
  id_atendimento SERIAL PRIMARY KEY,
  id_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  id_sala INT,
  data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  tipo_atendimento VARCHAR(30),
  diagnostico_paciente TEXT,
  observacoes TEXT,
  FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
  FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
  FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE Procedimento (
  id_procedimento SERIAL PRIMARY KEY,
  id_atendimento INT NOT NULL,
  descricao VARCHAR(100),
  custos DECIMAL(10,2),
  tempo_estimado INTERVAL,
  FOREIGN KEY (id_atendimento) REFERENCES Atendimento(id_atendimento)
);


INSERT INTO Especialidade (nome, descricao) VALUES 
('Pediatria', 'Especialista em cuidados de pacientes infantis.'),
('Ortopedia', 'Especialista no cuidado de articulações e ossos.');


INSERT INTO Paciente (nome, cpf, data_nascimento, sexo, telefone, email, endereco) VALUES 
('Ana Paula', '12345678901', '1995-05-15', 'F', '11999999999', 'ana.santos@email.com', 'Rua das Magias, 13'),
('Carlos Silva', '98765432100', '2000-10-20', 'M', '11988888888', 'carlos.silva@email.com', 'Av. Brasil, 8900');


INSERT INTO Sala (numero, andar, tipo_de_sala) VALUES 
('105A', 1, 'Consultório Médico'),
('133B', 2, 'Urgência e Emergência');


INSERT INTO Medico (nome, crm, telefone, email, id_especialidade) VALUES 
('Dr. João Carlos', 'CRM12345', '1233333333', 'joao.carlos@hospital.com', 1),
('Dra. Fernanda Torres', 'CRM54321', '1144444444', 'fernanda.torres@hospital.com', 2);


INSERT INTO Atendimento (id_paciente, id_medico, id_sala, data_hora, tipo_atendimento, diagnostico_paciente, observacoes) VALUES 
(1, 1, 1, '2025-07-01 09:00:00', 'Consulta', 'Gripe', 'Paciente com coriza'),
(2, 2, 2, '2025-07-01 10:30:00', 'Urgência e Emergência', 'Fratura no braço', 'Chegou de ambulância');


INSERT INTO Procedimento (id_atendimento, descricao, custos, tempo_estimado) VALUES 
(1, 'Eletrocardiograma', 150.00, INTERVAL '30 minutes'),
(2, 'Raio-X', 200.00, INTERVAL '20 minutes'),
(2, 'Imobilização', 300.00, INTERVAL '45 minutes');



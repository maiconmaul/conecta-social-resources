-- Criação do banco de dados
CREATE DATABASE conecta_social;
GO

-- Seleção do banco para uso
USE conecta_social;
GO

-- Tabela de categorias de doações
CREATE TABLE Category
(
  id VARCHAR(25) PRIMARY KEY,
  name VARCHAR(60),
  measure_unity VARCHAR(20),
  created_at DATE,
  active BIT
);

-- Tabela de doações
CREATE TABLE donations
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  category_id VARCHAR(25),
  name VARCHAR(60),
  description VARCHAR(1000) NULL,
  initial_quantity INT,
  current_quantity INT,
  donator_name VARCHAR(90) NULL,
  created_at DATE,
  user_updated_at DATE NULL,
  system_updated_at DATE NULL,
  available BIT,
  gender VARCHAR(10) NULL,
  size VARCHAR(20) NULL,
  active BIT,
  FOREIGN KEY (category_id) REFERENCES Category(id)
);

-- Tabela de famílias
CREATE TABLE Family
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  name VARCHAR(60),
  street VARCHAR(60),
  number VARCHAR(20),
  neighbourhood VARCHAR(60),
  city VARCHAR(30),
  uf VARCHAR(2),
  state VARCHAR(20),
  cep VARCHAR(9),
  updated_at DATE,
  active BIT
);

-- Tabela de beneficiários
CREATE TABLE beneficiaries
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  name VARCHAR(30),
  surname VARCHAR(60),
  birth_date DATE,
  cpf VARCHAR(15),
  rg VARCHAR(20) NULL,
  birth_document DATE,
  email VARCHAR(60) NULL,
  phone VARCHAR(15),
  has_disability BIT,
  disability VARCHAR(90) NULL,
  family_id VARCHAR(25),
  gender VARCHAR(30),
  created_at DATE,
  updated_at DATE,
  active BIT,
  FOREIGN KEY (family_id) REFERENCES Family(id)
);

-- Tabela de funcionários
CREATE TABLE employee
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  name VARCHAR(30),
  surname VARCHAR(60),
  birth_date DATE,
  role VARCHAR(20),
  cpf VARCHAR(15),
  email VARCHAR(60),
  phone VARCHAR(15),
  password VARCHAR(128),
  cep VARCHAR(9),
  street VARCHAR(60),
  neighbourhood VARCHAR(60),
  number VARCHAR(30),
  city VARCHAR(30),
  uf VARCHAR(2),
  state VARCHAR(20),
  complement VARCHAR(30) NULL,
  created_at DATE,
  updated_at DATE,
  active BIT
);

-- Tabela de eventos
CREATE TABLE event
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  name VARCHAR(60),
  description VARCHAR(1000) NULL,
  date DATE,
  greeting_description VARCHAR(1000) NULL,
  attendance INT NULL,
  embeded_instagram VARCHAR(1000) NULL,
  street VARCHAR(60),
  neighbourhood VARCHAR(30),
  number VARCHAR(20),
  city VARCHAR(30),
  state VARCHAR(20),
  cep VARCHAR(9),
  status VARCHAR(20),
  updated_at DATE,
  created_at DATE,
  active BIT
);

-- Tabela de doações para famílias
CREATE TABLE donations_to_family
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_donation VARCHAR(25),
  id_family VARCHAR(25),
  quantity INT,
  created_at DATE,
  updated_at DATE,
  update_message VARCHAR(250),
  FOREIGN KEY (id_donation) REFERENCES donations(id),
  FOREIGN KEY (id_family) REFERENCES Family(id)
);

-- Tabela de doações para eventos
CREATE TABLE donations_to_event
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_donation VARCHAR(25),
  id_event VARCHAR(25),
  quantity INT,
  created_at DATE,
  updated_at DATE,
  update_message VARCHAR(250),
  FOREIGN KEY (id_donation) REFERENCES donations(id),
  FOREIGN KEY (id_event) REFERENCES event(id)
);

-- Tabela de doações recolhidas de eventos
CREATE TABLE donations_from_event
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_event VARCHAR(25),
  id_donation VARCHAR(25),
  quantity INT,
  created_at DATE,
  updated_at DATE,
  update_message VARCHAR(250) NULL,
  active BIT,
  FOREIGN KEY (id_event) REFERENCES event(id),
  FOREIGN KEY (id_donation) REFERENCES donations(id)
);

-- Logs de funcionário com famílias
CREATE TABLE log_employee_family
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_employee VARCHAR(25),
  id_family VARCHAR(25),
  log_message VARCHAR(100),
  created_at DATE,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_family) REFERENCES Family(id)
);

-- Logs de funcionário com beneficiários
CREATE TABLE log_employee_beneficiaries
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_employee VARCHAR(25),
  id_beneficiaries VARCHAR(25),
  log_message VARCHAR(100),
  created_at DATE,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_beneficiaries) REFERENCES beneficiaries(id)
);

-- Logs de funcionário com eventos
CREATE TABLE log_employee_event
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_employee VARCHAR(25),
  id_event VARCHAR(25),
  log_message VARCHAR(100),
  created_at DATE,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_event) REFERENCES event(id)
);

-- Logs de funcionário com doações
CREATE TABLE log_employee_donation
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_employee VARCHAR(25),
  id_donation VARCHAR(25),
  log_message VARCHAR(100),
  created_at DATE,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_donation) REFERENCES donations(id)
);

-- Logs de funcionário com doações para famílias
CREATE TABLE log_employee_donations_to_family
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_employee VARCHAR(25),
  id_donations_to_family VARCHAR(25),
  log_message VARCHAR(100),
  created_at DATE,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_donations_to_family) REFERENCES donations_to_family(id)
);

-- Logs de funcionário com doações para eventos
CREATE TABLE log_employee_donations_to_event
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_employee VARCHAR(25),
  id_donations_to_event VARCHAR(25),
  log_message VARCHAR(100),
  created_at DATE,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_donations_to_event) REFERENCES donations_to_event(id)
);

-- Logs de funcionário com doações recolhidas de evento
CREATE TABLE log_employee_donation_from_event
(
  id UNIQUEIDENTIFIER PRIMARY KEY,
  id_employee VARCHAR(25),
  id_donation_from_event VARCHAR(25),
  log_message VARCHAR(100),
  created_at DATE,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_donation_from_event) REFERENCES donations_from_event(id)
);
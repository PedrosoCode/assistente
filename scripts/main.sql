create database db_assistente;

use db_assistente;

CREATE TABLE notebooks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  modelo VARCHAR(255),
  cor VARCHAR(255),
  nome_dono VARCHAR(255)
);

INSERT INTO notebooks (modelo, cor, nome_dono) VALUES
('Dell XPS 13', 'Prata', 'João Silva'),
('Apple MacBook Air', 'Dourado', 'Maria Oliveira'),
('HP Spectre x360', 'Preto', 'Carlos Souza'),
('Lenovo ThinkPad X1', 'Cinza', 'Ana Costa'),
('Asus ZenBook 14', 'Azul', 'Lucas Martins'),
('Acer Swift 5', 'Verde', 'Patrícia Lima'),
('Microsoft Surface Laptop 4', 'Platina', 'Roberto Dias'),
('Razer Blade 15', 'Preto', 'Fernanda Rocha'),
('LG Gram 17', 'Branco', 'Gustavo Henrique'),
('Samsung Galaxy Book S', 'Vermelho', 'Camila Gonçalves');

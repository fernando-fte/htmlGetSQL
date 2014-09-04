-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Set 04, 2014 as 02:05 PM
-- Versão do Servidor: 5.1.37
-- Versão do PHP: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Banco de Dados: `meubanco`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `tabela`
--

CREATE TABLE IF NOT EXISTS `tabela` (
  `index` int(5) NOT NULL COMMENT 'Index é variável para contabilizar cada instancia individualmente',
  `segmento` varchar(100) DEFAULT NULL COMMENT 'Serve para delimitar um segmento, área ou categoria que pode ser mutável. Exc.: uma área do site ou um bloco de informações complexas e categorizadas',
  `grupo` varchar(100) DEFAULT NULL COMMENT 'Serve para agrupar e delimitar varias seções dentro de um segmento, ou de uma forma geral. Exc.: varias imagens separadas por cor sendo a cor um grupo',
  `type` varchar(100) DEFAULT NULL COMMENT 'Uso variado',
  `values` text COMMENT 'Reune as informações da busca'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tabela`
--

INSERT INTO `tabela` (`index`, `segmento`, `grupo`, `type`, `values`) VALUES
(1, 'page', 'home', 'jumbotron', '{\r\n    "title": "Título do Jumbotron",\r\n    "about": "Sobre o Jumbotron; Lorem ipsum dolor sit amet ...",\r\n    "btn": {\r\n        "url": "www.google.com.br",\r\n        "title": "Titulo do botão",\r\n        "text": "Vá para o link"\r\n    }\r\n}'),
(1, 'page', 'home', 'title', '{"titulo":"Bem vindo ao site"}'),
(1, 'galeria', 'informacoes', 'galeria principal', '{\r\n	"figura":{"titulo":"1", "img":"http://placehold.it/300x200"},\r\n	"titulo":"Treceira galeria",\r\n	"sobre":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus odio ipsum, blandit quis ullamcorper eu, dignissim nec felis. Nulla ultricies tortor nec quam placerat vulputate. Mauris scelerisque mauris ante, ac vestibulum lorem suscipit sed. Etiam elit arcu, iaculis non enim sed, gravida faucibus nibh.",\r\n	"btn1":{"url":"#", "title":"Ir"},\r\n	"btn2":{"url":"#", "title":"Votar"}\r\n}'),
(2, 'galeria', 'informacoes', 'galeria principal', '{"figura":{"titulo":"2", "img":"http://placehold.it/300x200"},"titulo":"Thumbnail label","sobre":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus odio ipsum, blandit quis ullamcorper eu, dignissim nec felis. Nulla ultricies tortor nec quam placerat vulputate. Mauris scelerisque mauris ante, ac vestibulum lorem suscipit sed. Etiam elit arcu, iaculis non enim sed, gravida faucibus nibh.","btn1":{"url":"#", "title":"Ir"},"btn2":{"url":"#", "title":"Votar"}}'),
(3, 'galeria', 'informacoes', 'galeria principal', '{\r\n	"figura":{"titulo":"3", "img":"http://placehold.it/300x200"},\r\n	"titulo":"Treceira galeria",\r\n	"sobre":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus odio ipsum, blandit quis ullamcorper eu, dignissim nec felis. Nulla ultricies tortor nec quam placerat vulputate. Mauris scelerisque mauris ante, ac vestibulum lorem suscipit sed. Etiam elit arcu, iaculis non enim sed, gravida faucibus nibh.",\r\n	"btn1":{"url":"#", "title":"Ir"},\r\n	"btn2":{"url":"#", "title":"Votar"}\r\n}'),
(1, 'Segmento', 'Grupo', 'Type', '{"status":"Inativo","template-toogle":{"status":"Ativo"},"nome":"a","sobre":"a"}'),
(2, 'Segmento', 'Grupo', 'Type', '{"status":"Inativo","template-toogle":{"status":"Ativar"},"titulo":{"nome":"Curso de Apn\\u00e9ia Obstrutiva do sono"},"sobre":"a"}'),
(1, 'cadastro', 'curriculum', 'docentes', '{"status":"Inativo","template-toogle":{"status":"Ativo"},"nome":""}');

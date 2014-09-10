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
    `values` text  DEFAULT NULL COMMENT 'Reune as informações da busca',
    `sku` varchar(10) NOT NULL COMMENT 'Valor único de controle de estoque',
    PRIMARY KEY (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tabela`
--

INSERT INTO `tabela` (`index`, `segmento`, `grupo`, `type`, `values`, `sku`) VALUES
    (1, 'page', 'home', 'jumbotron', '{"title": "Título do Jumbotron", "about": "Sobre o Jumbotron; Lorem ipsum dolor sit amet ...", "btn": {"url": "www.google.com.br", "title": "Titulo do botão", "text": "Vá para o link"    }}', '1679091c5a'),
    (1, 'page', 'home', 'title', '{"titulo":"Bem vindo ao site"}', '8f14e45fce'),
    (1, 'galeria', 'informacoes', 'galeria principal', '{ "figura":{"titulo":"1", "img":"http://placehold.it/300x200"}, "titulo":"Treceira galeria", "sobre":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus odio ipsum, blandit quis ullamcorper eu, dignissim nec felis. Nulla ultricies tortor nec quam placerat vulputate. Mauris scelerisque mauris ante, ac vestibulum lorem suscipit sed. Etiam elit arcu, iaculis non enim sed, gravida faucibus nibh.", "btn1":{"url":"#", "title":"Ir"}, "btn2":{"url":"#", "title":"Votar"}}', 'a87ff679a2'),
    (2, 'galeria', 'informacoes', 'galeria principal', '{"figura":{"titulo":"2", "img":"http://placehold.it/300x200"}, "titulo":"Thumbnail label", "sobre":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus odio ipsum, blandit quis ullamcorper eu, dignissim nec felis. Nulla ultricies tortor nec quam placerat vulputate. Mauris scelerisque mauris ante, ac vestibulum lorem suscipit sed. Etiam elit arcu, iaculis non enim sed, gravida faucibus nibh.", "btn1":{"url":"#", "title":"Ir"}, "btn2":{"url":"#", "title":"Votar"}}', 'c4ca4238a0'),
    (3, 'galeria', 'informacoes', 'galeria principal', '{ "figura":{"titulo":"3", "img":"http://placehold.it/300x200"}, "titulo":"Treceira galeria", "sobre":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus odio ipsum, blandit quis ullamcorper eu, dignissim nec felis. Nulla ultricies tortor nec quam placerat vulputate. Mauris scelerisque mauris ante, ac vestibulum lorem suscipit sed. Etiam elit arcu, iaculis non enim sed, gravida faucibus nibh.", "btn1":{"url":"#", "title":"Ir"}, "btn2":{"url":"#", "title":"Votar"}}', 'c81e728d9d'),
    (1, 'Segmento', 'Grupo', 'Type', '{"status":"Inativo", "template-toogle":{"status":"Ativo"}, "nome":"a", "sobre":"a"}', 'c9f0f895fb'),
    (2, 'Segmento', 'Grupo', 'Type', '{"status":"Inativo", "template-toogle":{"status":"Ativar"}, "titulo":{"nome":"Curso de Apn\\u00e9ia Obstrutiva do sono"}, "sobre":"a"}', 'e4da3b7fbb'),
    (1, 'cadastro', 'curriculum', 'docentes', '{"status":"Inativo", "template-toogle":{"status":"Ativo"}, "nome":""}', 'eccbc87e4b');

--
-- Estrutura da tabela `htmlgetsql.history`
--

CREATE TABLE IF NOT EXISTS `htmlgetsql.history` (
  `history` varchar(10) NOT NULL COMMENT 'Numero de identificação do  history',
  `sku` varchar(10) NOT NULL COMMENT 'Identificador sku da tabela',
  `table` varchar(100) NOT NULL COMMENT 'Nome da tabela',
  `log` varchar(10) NOT NULL COMMENT 'Identificador do log',
  `values` text NOT NULL COMMENT 'Valores de tratamento',
  PRIMARY KEY (`history`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


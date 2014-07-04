<?php
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Aplicação de comunicação com o servidor dos tipos query   #
# sendo estes quando for "SELECT", "INSERT", UPDATE         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# função de interação com query para o 'sql'
#
function query($sql){
    # # # # #
    # # Descreve valores recebidos de "query($sql){}"
    # $sql = recebe uma string com os valores compilados
    # # # # #

    # adiciona em "$con" a classe responsável pela conexão
    $con = new _conecta;

    # abre conexao
    $con->AbreConexao();

    # seta o valor query
    $Sel = mysql_query($sql) or die(mysql_error());

    # fecha a conexao
    $con->FechaConexao();

    # retorna query
    return $Sel;
}
#
# Fim de  "função de interação com query para o 'sql'"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# função de tratamento para valores do tipo 'select'
#
function select($tabela, $campos, $regra){
    # # # # #
    # # Descreve valores recebidos de "select($tabela, $campos, $regra){}"
    # $tabela = 'nome-da-tabela'; // tabela a ser consultada
    # $campos = array('' => '*'); // campos a serem capturados
    # $regra  = array('WHERE ID=' => $id, LIMIT  => '1'); // regras da consulta
    # #
    # solicitação: "select($tabela, $campos, $regra)";
    # # # # #

    # # # # #
    # Tratamento dos valores da função

    # seleciona o valor do nome dos campos da array $campos
    $arrCampo = array_keys($campos);
    
    # seleciona o valor dentro dos campos da array $campos
    $arrValores = array_values($campos);

    # contar a quantidade de campos array possui quanto aos ['campos']
    $numCampo = count($arrCampo);

    # contar a quantidade de campos array possui quanto aos ['dados']
    $numValores = count($arrValores);

    # # #

    # seleciona o valor do nome dos campos da array $regra
    $arrRegraCampo = array_keys($regra);
    
    # seleciona o valor dentro dos campos da array $regra
    $arrRegraValores = array_values($regra);

    # contar a quantidade de campos array possui quanto aos [campos] de $campos
    $numRegraCampo = count($arrRegraCampo);

    # contar a quantidade de campos array possui quanto aos [dados] de $campos
    $numRegraValores = count($arrRegraValores);



    # # # # #
    # Inicia aplicação da função

    # #
    # verifica se os campos repassados são válidos, para o processamento
    if ($numCampo == $numValores && $numRegraCampo == $numRegraValores && $numCampo > '0') {

        # #
        # padrão da seleção: SELECT * FROM edicao WHERE ID='$id'
        # #

        # delimita a ação quando for 'SELECT'
        $sql = 'SELECT '; 

        # trata os campos a serem capturados
        foreach ($arrValores as $valores) {

            # acrecenta em '$sql' os valores a serem resgatados
            $sql .= $valores.', '; 
        }

        # remove possivel espaço em branco do final da contagem anterior
        $sql = substr_replace($sql, ' ', -2, 1);

        # acrecenta em '$sql' a tabela do banco de dados
        $sql .= 'FROM '.$tabela.' ';
   
        # loop para definir as regras de seleção
        for ($i='0'; $i < $numRegraCampo; $i++) {

            # acrecenta em '$sql' o valor das regras do sql
            $sql .= $arrRegraCampo[$i].' '.$arrRegraValores[$i].' ';//regras;
        }

        # seleciona dados do banco, pela função responsável e acrecenta em '$sel'
        $sel = query($sql);

        # loop para repassar os resultados com uma array
        $i = '0'; # inicia em '$i' como um contador

        # laço para processar e atriubir dentro de value os resultados do banco
        while ($val = mysql_fetch_array($sel)) {

            # acrecenta em '$res[0-9*]' os resultados
            $res[$i] = $val;

            # acrecenta (1) no contador
            $i = $i+'1';
        }

        # #
        # valida se houve realmente um acrecimo de array, relacionando se houve um resultado
        if ($res['0']['0'] != '') {

            # conto quantas respostas houve
            $temp['res']['count'] = count($res);

            # confiro se houve mais de uma resposta
            switch($temp['res']['count']){

                # quando tem apenas uma resposta o objeto é colocado no index da array ($res[0][a] -> $res[a])
                case '1':                            
                    return $res = $res['0']; # retorna paneas uma resposta dentro da array
                break;

                # quando tem mais de uma resposta ele exibe normal ($res[0][a]; $res[1][a]; $res[2][a])
                default:
                    return $res; # retorna todas as respostas
                break;
            }
        } 

        # caso não exista nem um resultado
        else {

            # retorna o valor Empty
            return 'Empty'; 
        }

        # Fim de "valida se houve realmente um acrecimo de array, relacionando se houve um resultado"
        # #

    } # "if ($numCampo == $numValores && $numRegraCampo == $numRegraValores && $numCampo > '0')"

    # caso não algun dos argumentos não sejam válidos
    else {
        return '
        Incompatibilidade com um dos campos que exigem arrays, veja a requisição deste objeto.
        <br>
        <a href="?api=functions->sql->select->param">Consulte a api</a>
        ';
    }

    # Fim de "verifica se os campos repassados são válidos, para o processamento"
    # #
}
#
# Fim de "função de tratamento para valores do tipo 'select'"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


?>
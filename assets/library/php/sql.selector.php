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


?>
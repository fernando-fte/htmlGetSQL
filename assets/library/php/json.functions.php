<?php  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# FUNÇÕES DE APOIO PARA O TRATAMENTO DE JSON                #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # #
# função para transformar [object Object] json em array
function f_object_to_array($object) {

    # verifica se $object não é um [object Object] e nem uma array
    if(!is_object($object) && !is_array($object)) { 

        # devolve valor a função sem modificações
        return $object; 
    }

    # valida se a $object é um [object Object]
    if(is_object($object)) {

        # adiciono em $object ele mesmo processado com a função get_object_vars()
        $object = get_object_vars( $object);
    }
   
   # retorna uma array pameada de $object com 'objectToArray'
   return array_map( 'objectToArray', $object );
}
# função para transformar [object Object] json em array
# # # # #


# # # # #
# função para montar os parametros para um select
function f_json_where($post) {

    # verifica se o valor recebido em $post possui a array "select"
    if (array_key_exists("select", $post)) {

        # # # 
        # separa arrays recebidas de $post

        # adiciona em $temp>key uma lista com os valores das chaves de $post>select
        $temp['key'] = array_keys($post['select']);

        # adiciona em $temp>val uma lista com os valores de cada array em $post>select
        $temp['val'] = array_values($post['select']);

        # adiciona em $temp>key>count quantas arrays foram adicionadas em $temp>key
        $temp['key']['count'] = count($temp['key']);

        # adiciona em $temp>val>count quantas arrays foram adicionadas em $temp>val
        $temp['val']['count'] = count($temp['val']);

        # separa arrays recebidas de $post
        # # # 


        # # # 
        # trata valores compilados, validando e montando regra na seção WHERE conforme o indicador

        # selecina em loop cada array de $temp>val
        for ($temp['count']=0; $temp['count'] < $temp['val']['count']; $temp['count']++) {

            # #
            # quando $post>regra>where tiver o tipo de seleção WHERE especifico
            if ($post['regra']['where'] == "LIKE" or $post['regra']['where'] == "=") {

                # configura a primeira entrada do loop, que pode ser a unica, selecionando apenas uma coluna
                if($temp['count'] <= 0) {

                    # monta em $temp>where a chamda da regra de validação de select()
                    $temp['where'] = '`'.$temp['key'][$temp['count']].'` '.$post['regra']['where'].' \''.$temp['val'][$temp['count']].'\' ';
                }

                # configura a partir da segunda entrada do loop, para selecionar mais de uma coluna
                else{

                    # adiciona em $temp>where ele mesmo mais a concatenação "AND" e a segunda leva da regra de seleção
                    $temp['where'] = $temp['where'] .'AND `'.$temp['key'][$temp['count']].'` '.$post['regra']['where'].' \''.$temp['val'][$temp['count']].'\' ';
                }
            }

            # #
            # quando $post>regra>where tiver o tipo de seleção WHERE relativo
            else if ($post['regra']['where'] == "LIKE%") {

                # configura a primeira entrada do loop, que pode ser a unica, selecionando apenas uma coluna
                if($temp['count'] <= 0) {

                    # monta em $temp>where a chamda da regra de validação de select()
                    $temp['where'] = '`'.$temp['key'][$temp['count']].'` LIKE \'%'.$temp['val'][$temp['count']].'%\' ';
                }

                # configura a partir da segunda entrada do loop, para selecionar mais de uma coluna
                else{

                    # adiciona em $temp>where ele mesmo mais a concatenação "AND" e a segunda leva da regra de seleção
                    $temp['where'] = $temp['where'] .'AND `'.$temp['key'][$temp['count']].'` LIKE \'%'.$temp['val'][$temp['count']].'%\' ';
                }
            }
        }

        # trata valores compilados, validando e montando regra na seção WHERE conforme o indicador
        # # # 


        # # # 
        # finaliza montagem da das regras dentro das arrays de retorno e adiciona em $regra, lembrando que a função leva em conta a array enviada

        # acrecenta em $regra>'WHERE ' os valores manipulados e tratados acrecentados em $temp>where
        $regra['WHERE '] =  $temp['where'];

        # acrecenta em $regra>'WORDER BY ' os dados de ordenação de resultados, recebidos em $post>regra>order
        $regra['ORDER BY '] =  '`'.$post['regra']['order']['to'].'` '.$post['regra']['order']['by'].'';

        # acrecenta em $regra>'LIMIT ' a quantidade de dados a serem retornados, recebido em $post>regra>limit
        $regra['LIMIT '] =  $post['regra']['limit'];

        # apaga $temp na posição atua
        unset($temp);

        # retorna regra para a função
        return $regra;
        
        # finaliza montagem da das regras dentro das arrays de retorno e adiciona em $regra, lembrando que a função leva em conta a array enviada
        # # # 
    }
}
# função para montar os parametros para um select
# # # # #


# # # # #
# função para retornar apenas o campo "values" recebido do banco de dados
function f_json_values($select){

    # # # 
    # caso exista a array "values" na raiz de $select, sendo apenas um retorno do servidor
    if (array_key_exists("values", $select)) {

        # acrecenta na string $return os valores de $select>values
        $return = $select['values'];
    }

    # # # 
    # caso não exista a array "values" na raiz de $select, podendo ser mais de um valor retornado
    else{

        # conta quantas ocorrencias
        $temp['count'] = count($select);

        # excecuta loop para tratar cada resposta do servidor
        for ($temp['position'] = 0; $temp['position'] < $temp['count']; $temp['position']++) {

            # quando for o primeiro o primeiro resultado
            if($temp['position'] <= 0) {

                # adiciona em $temp>return os "values" da posição em $select>%%>values
               $temp['return'] = $select[$temp['position']]['values'];
            }

            # quando do segundo resultado em diante
            else{

                # acrecenta em $temp>return ele mesmo mais os "values" da posição em $select>%%>values
                $temp['return'] = $temp['return'] .", ". $select[$temp['position']]['values'];
            }

            # acrecenta em $return os valores tratados em $temp>return
            $return = $temp['return'];
        }
    }

    # retorna os valores para a função
    return $return;
}
# função para retornar apenas o campo "values" recebido do banco de dados
# # # # #


# # # # #
# função para validar o status do values>[object Object]
function f_valida_status ($return) {

    # acrecenta em $return ele mesmo como array
    $return = (json_decode($return, true));

    # valida se na raiz existe "status"
    if(array_key_exists('status', $return['0'])){

        # acrecenta m $return>0>status ele mesmo com a font em smallcase
        $return['0']['status'] = strtolower($return['0']['status']);

        # inicia sequencia de selecao de status
        switch ($return['0']['status']) {

            # caso seja ativo retorna 'true'
            case 'active':
                return true;
                break;
            case 'actived':
                return true;
                break;
            case 'ativo':
                return true;
                break;
            case 'desativo':
                return true;
                break;

            # caso seja desativado retorna 'false'
            case 'dasebled':
                return false;
                break;
            case 'desable':
                return false;
                break;
            case 'inative':
                return false;
                break;
            case 'inativo':
                return false;
                break;
            case 'desativo':
                return false;
                break;

            # caso seja exluido retorna 'excluded'
            case 'exclude':
                return 'excluded';
                break;
            case 'removed':
                return 'excluded';
                break;
            case 'excluido':
                return 'excluded';
                break;
        }
    }

    # quando não houver o atributo status nao retorna 'true'
    else{
        return true;
    }
}
# função para validar o status do values>[object Object]
# # # # #


# # # # #
# função para validar se as entradas do $_POST são corretas
function f_json_post($post) {

    # #
    # quando não existir a array "regra", adiciona as configurações necessárias
    if (!array_key_exists("regra", $post)) {

        # adiciona na array $post>regra>where o valor que a busca é fixa (LIKE | LIKE%)
        $post['regra']['where'] = "LIKE";
        
        # adiciona na array $post>regra>limit que a resposta do servidor será apenas '1'
        $post['regra']['limit'] = "1";

        # adiciona na array $post>order>to que a busca sera ordenada em "index"
        $post['regra']['order']['to'] = "index";

        # adiciona na array $post>order>by que a busca será ordenada do menor para o maior
        $post['regra']['order']['by'] = "ASC";
    }
    # Fim da 'quando não existir a array "regra", adiciona as configurações necessárias'
    # #

    # #
    # trata elementos caso exista a array "regra", valida cada item dentro da mesma 
    else {
        # #
        # valida "where" que estabelece a seleção
        if(!array_key_exists("where", $post['regra'])) {

            # adiciona na array $post>regra>where o valor que a busca é fixa (LIKE | LIKE%)
            $post['regra']['where'] = "LIKE";
        }
        # Fim de 'valida "where" que estabelece a seleção'
        # #

        # #
        # valida se há "order" que estabelece a ordem das respostas (que a coluna "X" exibida de 0 -> ∞ ou ∞ -> 0)
        if(!array_key_exists("order", $post['regra'])) {

            # adiciona na array $post>order>to que a busca sera ordenada em "index"
            $post['regra']['order']['to'] = "index";

            # adiciona na array $post>order>by que a busca será ordenada do menor para o maior
            $post['regra']['order']['by'] = "ASC";
        }
        # Fim de 'valida se há "order" que estabelece a ordem das respostas (que a coluna "X" exibida de 0 -> ∞ ou ∞ -> 0)'
        # #

        # #
        # valida se os valores de "order" estão corretos
        else { 

            # #
            # valida se há "order>to"
            if(!array_key_exists("to", $post['regra']['order'])) {

                # adiciona na array $post>order>to que a busca sera ordenada em "index"
                $post['regra']['order']['to'] = "index";
            }
            # Fim de 'valida se há "order>to"'
            # #

            # #
            # valida se há "order>by"
            if(!array_key_exists("by", $post['regra']['order'])) {

                # adiciona na array $post>order>by que a busca será ordenada do menor para o maior
                $post['regra']['order']['by'] = "ASC";
            }
            # Fim de 'valida se há "order>by"'
            # #
        }
        # Fim de "valida se os valores de "order" estão corretos"
        # #

        # #
        # valida se há "limit", e este define quantos resultados o banco deve retornar
        if(!array_key_exists("limit", $post['regra'])) {

            # adiciona na array $post>regra>limit que a resposta do servidor será apenas '1'
            $post['regra']['limit'] = "1";
        }
        # valida se há "limit", e este define quantos resultados o banco deve retornar
        # #
    }
    # Fim de 'trata elementos caso exista a array "regra", valida cada item dentro da mesma '
    # #

    # #
    # valida a array "status" existe
    if(!array_key_exists("status", $post)){

        # determina que "status" é falso
        $post['status'] = false;
    }
    # Fim de 'valida a array "status"'
    # #

    # retorna $post para a função
    return $post;
}
# função para validar se as entradas do $_POST são corretas
# # # # #

?>

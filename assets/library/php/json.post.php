<?php
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APLICAÇÃO DE TRATAMENTO E TRAMITAÇÃO DE DADOS JSON        #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Inclui funções e regras pre-determinadas
#

# inclui classe de conexão ao banco de dados
include 'sql.connect.php';

# inclui funções de tratamento e manipulação para conexão do banco de dados
include 'sql.selector.php';

# inclui funções de apoio
include 'json.functions.php';

#
# Fim de "Inclui funções e regras pre-determinadas"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Inicia aplicação e configurações

# define em $post os valores de $_POST processado na função f_json_post($_POST);
$post = f_json_post($_POST);

# padão de usuario
$post['log']['user'] = 'skuusser01';
$post['log']['registro']['reg'] = 'reg01val01';
$post['log']['registro']['key'] = 'senhaeuser';
$post['log']['date']['start'] = '2014-20-10 01:01:01';
$post['log']['date']['left'] = '2014-20-10 01:01:01';
$post['log']['info'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36';


# verifica se existe o a array "type" em post
if (array_key_exists('type', $post)) {

    # laço para aplicar ações conforme a seleção
    switch ($post['type']) {

        # # # # #
        # quando o $post>type for update, que envia alterações para o servidor
        case 'update':

            # # # # #
            # # 1º CASO: Envia os arquivos para history

            # verifica se o valor recebido em $post possui a array "update"
            if (!array_key_exists('update', $post)) {

                # adiciona em $temp>return a criação do history
                $temp['return'] = f_new_history($post);

                # retorna ao JS
                echo '['.json_encode($temp['return'], true).']';

            }
            

            # verifica se o valor recebido em $post possui a array "update"
            if (array_key_exists('update', $post)) {

                # valida se history já existe nesse caso
                if (array_key_exists('history', $post['update'])) {

                    # verifica se existe history, e se é finalizado
                    if ($post['update']['history']['change'] === 'false') {


                        $temp['regra']['where'] = 'LIKE';
                        $temp['regra']['limit'] = '1';
                        $temp['regra']['order']['to'] = 'history';
                        $temp['regra']['order']['by'] = 'ASC';

                        $temp['select']['history'] = $post['update']['history']['this'];

                        # adiciona em $temp>regra os valores de $post na função 'f_json_where'
                        $temp['history']['regra'] = f_json_where($temp);

                        # adiciona em $temp>tabela o valor referente a tabela com tratamento especifico
                        $temp['history']['tabela'] = '`htmlgetsql.history`'; 

                        # adiciona em $temp>campos os campos a serem selecionado, no caso "*" todos por padrão
                        $temp['history']['campos'] = array('' => '`values`');

                        # seleciona os valores do banco de dados recebidos da função select() com os dados tratados anteriormente
                        $temp['history']['select'] = select($temp['history']['tabela'], $temp['history']['campos'], $temp['history']['regra']);

                        // print_r($temp['history']['select']['values']);

                        # #
                        # manipula ultima alteração

                        # mapeia as respostas do servidor como object json para array
                        $temp['history']['select']['values'] = json_decode($temp['history']['select']['values'], true);;

                        # adiciona no ultimo item a data de remoção
                        $temp['history']['select']['values']['history']['atual']['date']['remove'] = date('Y-m-d').' '.date('h:i:s');

                        # move o ultimo item para backup
                        $temp['history']['select']['values']['history']['backup'][$temp['history']['select']['values']['history']['atual']['date']['remove']] = $temp['history']['select']['values']['history']['atual'];

                        # apaga o item atual para receber os novos valores
                        unset($temp['history']['select']['values']['history']['atual']);

                        # #

                        # adiciona em atual o valor editado
                        $temp['history']['select']['values']['history']['atual']['values'] = $post['update']['value'];
                        $temp['history']['select']['values']['history']['atual']['date']['create'] = date('Y-m-d').' '.date('h:i:s');


                        # mapeia os dados de resposta do servidor e transforma em object json
                        $temp['history']['update']['values'] = json_encode($temp['history']['select']['values'], true);

                        # envia update ao banco
                        update('`htmlgetsql.history`', $temp['history']['update'], $temp['history']['regra']);

                        // print_r($temp['history']['select']['values']);
                        // print_r($temp['history']['regra']);


                        # define valor de resposta
                        $temp['return']['type'] = 'update-history';
                        $temp['return']['success'] = true;

                        # retorna ao js
                        echo '['.json_encode($temp['return'], true).']';

                        # apaga temp
                        unset($temp);
                    }

                    # verifica se existe history, e se é finalizado
                    if ($post['update']['history']['change'] === 'true') {

                        echo 'salva';
                    }

                }

                if (!array_key_exists('history', $post['update'])) {

                    # adiciona em $temp>return a criação do history
                    $temp['return'] = f_new_history($post);

                    # retorna ao JS
                    echo '['.json_encode($temp['return'], true).']';
                }
            }
            // # verifica se o valor recebido em $post possui a array "update"
            // if (array_key_exists('update', $post)) {

            //    // $post['update'] = 'b1c2d3e4f5';
            //    // $post['update']['']

            //     # valida se $post>update não possui history
            //     if (array_key_exists('history', $post['update'])) {



            //     }

            //     if (array_key_exists('chenge', $post['update'])) {


            //     }
            // }


            // print_r($post);

            # # #
            # # 1ª ETAPA: seleciona o banco de dados e substitui os campos alterados guardados em $_POST

            # #
            # define e seleciona valores do banco de dados

            // # adiciona em $temp>regra os valores de $post na função 'f_json_where'
            // $temp['regra'] = f_json_where($post); 

            // # adiciona em $temp>tabela o valor referente a tabela com tratamento especifico
            // $temp['tabela'] = '`'.$post['table'].'`'; 

            // # adiciona em $temp>campos os campos a serem selecionado, no caso "*" todos por padrão
            // $temp['campos'] = array('' => '*');

            // # seleciona os valores do banco de dados recebidos da função select() com os dados tratados anteriormente
            // $temp['select'] = select($temp['tabela'], $temp['campos'], $temp['regra']);

            // # Fim de "define e seleciona valores do banco de dados"
            // # #

            // # mapeia as respostas do servidor como object json para array
            // $temp['return'] = (json_decode($temp['select']['values'], true));

            // # mescla o resultado do banco de dados e o valor recebido por post, atualizando os dados e garantindo que nem uma array será desfeita
            // $temp['values'] = array_merge($temp['return'], $post['values']);

            // # mapeia os dados de resposta do servidor e transforma em object json
            // $temp['dados']['values'] = json_encode($temp['values']);


            // # # #
            // # # 2ª ETAPA: Envia arquivos atualizados para o servidor

            // # #
            // # define e reordena os valores do banco de dados

            // # zera $temp>campo
            // unset($temp['campos']);

            // # acrecenta em $temp>campos>index os valores da coluna "index"
            // $temp['campos']['index'] = $post['select']['index'];

            // # acrecenta em $temp>campos>segmento os valores da coluna "segmento"
            // $temp['campos']['segmento'] = $post['select']['segmento'];

            // # acrecenta em $temp>campos>grupo os valores da coluna "grupo"
            // $temp['campos']['grupo'] = $post['select']['grupo'];

            // # acrecenta em $temp>campos>type os valores da coluna "type"
            // $temp['campos']['type'] = $post['select']['type'];

            // # acrecenta em $temp>campos>values os dados compilados e configura os caracteres especiais
            // $temp['campos']['values'] = addslashes($temp['select']['values']);

            // # retorna os valores organizados em $temp>campos ao $post>select
            // $post['select'] = $temp['campos'];

            // # define e reordena os valores do banco de dados
            // # #

            // # define que regra de seleção where é "="
            // $post['regra']['where'] = "=";

            // # adiciona em $temp>regra os valores processados na função "f_json_where($post"
            // $temp['regra'] = f_json_where($post);

            // # envia para a função update() os valores tratados, e atualiza o banco
            // // update($temp['tabela'], $temp['dados'], $temp['regra']);

            // # acrecenta na string $return a resposta que foi feito o update
            // $return = '[{"update":"true", "result":'.$temp['dados']['values'].'}]';

            // # retorna $return ao json
            // echo $return;

            break;
        # Fim de "quando o $post>type for update, que envia alterações para o servidor"        
        # # # # #

        # # # # #
        # quando o $post>type for insert, que insere um novo campo na tabela
        case 'insert':

            # # #
            # # 1ª ETAPA: verifica a existencia de um index e estabelece uma nova etrada de acordo com o resultado, garantindo que o index será maior que o ultimo valor já existente 

            # #
            # define e seleciona valores do banco de dados

            # adiciona em $post>regra>order>by o valor "DESC", para selecionar apartir do ultimo registro
            $post['regra']['order']['by'] = "DESC";
            
            # adiciona em $temp>regra os valores de $post na função 'f_json_where'
            $temp['regra'] = f_json_where($post); 
            
            # adiciona em $temp>tabela o valor referente a tabela com tratamento especifico
            $temp['tabela'] = '`'.$post['table'].'`'; 

            # adiciona em $temp>campos os campos a serem selecionado, no caso "*" todos por padrão
            $temp['campos'] = array('' => '*');

            # seleciona os valores do banco de dados recebidos da função select() com os dados tratados anteriormente
            $temp['select'] = select($temp['tabela'], $temp['campos'], $temp['regra']);

            # Fim de "define e seleciona valores do banco de dados"
            # #

            # #
            # reconhece e trata o valor do index

            # caso $temp>select seja vazio
            if ($temp['select'] == 'Empty') { 

                # adiciona $post>select>index com 1
                $post['select']['index'] = 1; 
            }

            # caso $temp>select tenha recebudo algum valor, verifica se existe array index
            else if (array_key_exists('index', $temp['select'])) {

                # adiciona em $post>select>index +1, para garantir que o ele será maior que o que contem no banco de dados
                $post['select']['index'] = $temp['select']['index']+'1';
            }

            # reconhece e trata o valor do index
            # #


            # # #
            # # 2ª ETAPA: Estabelece valores padões para o values do banco de dados e organiza as entradas

            # # 
            # adiciona em $post>select>values as configurações padrões
            $post['select']['values'] = '{"status":"Inativo", "template-toogle":{"status":"Ativo"}}';

            # adiciona em $post>select>values as configurações padrões
            # #

            # #
            # define e reordena os valores do banco de dados

            # zera $temp>campo
            unset($temp['campos']);

            # acrecenta em $temp>campos>index os valores da coluna "index"
            $temp['campos']['index'] = $post['select']['index'];

            # acrecenta em $temp>campos>segmento os valores da coluna "segmento"
            $temp['campos']['segmento'] = $post['select']['segmento'];

            # acrecenta em $temp>campos>grupo os valores da coluna "grupo"
            $temp['campos']['grupo'] = $post['select']['grupo'];

            # acrecenta em $temp>campos>type os valores da coluna "type"
            $temp['campos']['type'] = $post['select']['type'];

            # acrecenta em $temp>campos>values os dados compilados e configura os caracteres especiais
            $temp['campos']['values'] = addslashes($temp['select']['values']);

            # define e reordena os valores do banco de dados
            # #


            # # #
            # # 3ª ETAPA: Envia os dados para o servidor, e envia resposta para o json

            # incherta os valores tratados no banco de dados pela função insert()
            insert($temp['tabela'], $temp['campos']);

            # acrecenta em $return a resposta tratada para o json
            $return = '[{"index":"'.$temp['campos']['index'].'", "status":"desabled", "type":"update"}]';

            # retorna ao json
            echo $return;

            # zero temp;
            unset($temp);
            break;
        # Fim de "quando o $post>type for insert, que insere um novo campo na tabela"
        # # # # #

        # # # # #
        # quando o $post>type for select, seleciona os valores do banco de dados conforme a solicitação
        case 'select':

            # # #
            # # 1ª ETAPA: Seleciona o banco de dados, e acrecenta resposta a $return com um object

            # #
            # define e seleciona valores do banco de dados
            
            # adiciona em $temp>regra os valores de $post na função 'f_json_where'
            $temp['regra'] = f_json_where($post); 
            
            # adiciona em $temp>tabela o valor referente a tabela com tratamento especifico
            $temp['tabela'] = '`'.$post['table'].'`'; 

            # adiciona em $temp>campos os campos a serem selecionado, no caso "*" todos por padrão
            $temp['campos'] = array('' => '*');

            # seleciona os valores do banco de dados recebidos da função select() com os dados tratados anteriormente
            $temp['select'] = select($temp['tabela'], $temp['campos'], $temp['regra']);

            # adiciona em $return um object Object tratado com a função f_json_values() com resposta do servidor em $temp>select
            $return = '['.f_json_values($temp['select']).']';

            # Fim de "define e seleciona valores do banco de dados"
            # #


            # # #
            # # 2ª ETAPA: Valida se algum dos resultados estão ativos
 
            # verifica se o status é válido
            if(f_valida_status($return) == true){

                # retorna ao json os valores selecionados
                echo $return;
            }

            # verifica se há uma solicitação de arquivos nao ativos
            if($post['status']){

                # verifico o tipo de solicitação, e retorno ao jquery
                switch ($post['status']) {

                    # quando $post>status for "update", exibe todos os dados menos os excluidos
                    case 'update': # quando for upate

                        # filtra todos menos os que forão excluidos  indiretamente
                        if(f_valida_status($return) != 'excluded'){ echo $return; }
                        break;

                    # quando $post>status for "recover", exibe apenas os dados marcados como excluidos
                    case 'recover': 

                        # filtra dados marcados como excluidos
                        if(f_valida_status($return) == 'excluded'){ echo $return; }
                        break;
                }
            } 

            break;
        # Fim de "quando o $post>type for select, seleciona os valores do banco de dados conforme a solicitação"
        # # # # #
    }
}

# Fim de inicia aplicação e configurações
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
?>

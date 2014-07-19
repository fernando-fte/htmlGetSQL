<?php  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# FUNÇÕES DE APOIO PARA O TRATAMENTO DE JSON        		#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

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

        }
        # valida se há "limit", e este define quantos resultados o banco deve retornar
        # #
    }
    # Fim de 'trata elementos caso exista a array "regra", valida cada item dentro da mesma '
    # #


}
# função para validar se as entradas do $_POST são corretas
# # # # #

?>

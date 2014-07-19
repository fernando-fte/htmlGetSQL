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


    }
    # Fim da 'quando não existir a array "regra", adiciona as configurações necessárias'
    # #


}
# função para validar se as entradas do $_POST são corretas
# # # # #

?>

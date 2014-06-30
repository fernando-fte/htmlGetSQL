# FUNÇÃO ENVIAR PARA PHP #
$.submt_post = (value) ->
    # # #
    # value = valores para conexao e busca no banco
    # # #

    # Função ajax
    $.ajax(
        type: "post"
        url: "local.php" #local no php
        cache: false
        data: value
        async: false
    )

    # resultado de retorno
    .done (data) -> 
        # console.log data # exibe valor de data
        value = data

    # retorna value a solicitação com 'eval()'
    return eval(value)

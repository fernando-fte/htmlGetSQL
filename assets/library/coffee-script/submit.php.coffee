# FUNÇÃO ENVIAR PARA PHP #
$.htmlGetSQL.buttress.send = (value) ->
    # # #
    # value = valores para conexao e busca no banco
    # # #

    # Função ajax
    $.ajax(
        type: "post"
        url: "assets/library/php/json.post.php" #local no php
        cache: false
        data: value
        async: false
    )

    # resultado de retorno
    .done (data) -> 
        # console.log data # exibe valor de data
        value = data
        # console.log value
    # retorna value a solicitação com 'eval()'
    return eval(value)

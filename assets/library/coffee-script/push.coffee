# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APLICAÇÃO DE TRATAMENTO DAS EDICÕES DO BANCO DE DADOS VIA JSON  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # FUNÇÂO PRINCIPAL # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# recebe valores do html, trata os valores e aplica os tratamentos
$.push_values = (html) ->
    # # # # #
    # # Descreve valores recebidos em '$.pull_values = (html) ->'
    # html   = o HTML deve ser passado com um object dom '$(document)'
    # # # # #

    # # # # # # # # # # # # # #
    # Define objetos globais

    # temp 
    temp = {}

    # define position em temp e adiciona zero
    temp.position = 0

    # define object 'count' dentro de temp
    temp.count = {}

    # define 'push_' como um [object Object], para receber parametros
    push_ = {}

    # define 'push_>input' como um [object Object], para input
    push_.input = {}



    # # # # #
    # Inicia a aplição da função $.push_values

    # adiciona em 'push_>contents'todas as incidencias de ['data-htmlgetsql-push']
    push_.contents = html.find("[data-htmlgetsql-push]")

    # Inicia o tratamento quando .bind for do tipo 'input', quando um texto é modificado
    push_.contents.bind 'input', ->

        # valido de push>setings>action é do tipo 'click'
        if $(this).data("htmlgetsql-push-sentings").action is 'input'

            # adiciona em push_>input>this o documento atual do .bind()
            push_.input.this = $(this)

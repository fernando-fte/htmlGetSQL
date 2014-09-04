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
    push_.contents = html.find('[data-htmlgetsql-push]')

    # Inicia o tratamento quando .bind for do tipo 'input', quando um texto é modificado
    push_.contents.bind 'input', ->

        # valido de push>setings>action é do tipo 'click'
        if $(this).data('htmlgetsql-push-sentings').action is 'input'

            # # # #
            # define objetos globais

            # adiciona em push_>input>this o documento atual do .bind()
            push_.input.this = $(this)

            # adiciona em push_>input>this>setings as configurações desse push
            push_.input.this.setings = push_.input.this.data('htmlgetsql-push-sentings')

            # define push_>input>this>push_ com [object Object], deve carregar as informações do envio
            push_.input.this.push_ = {}


            # # # #
            # Trata as conexões deste evento
            if push_.input.this.setings.connect is 'pull'

                # #
                # Seleciona os valores de ['data-htmlgetsql-table']

                # caso ['data-htmlgetsql-table'] esteja na raiz, adiciona em push_>input>this>push_>table os valores de table
                push_.input.this.push_.table = push_.input.this.data('htmlgetsql-table') if push_.input.this.data('htmlgetsql-table')

                # caso ['data-htmlgetsql-table'] esteja nos elementos pai de this, adiciona em push_>input>this>push_>table os valores de table
                push_.input.this.push_.table = $(push_.input.this).closest('[data-htmlgetsql-table]').data('htmlgetsql-table') if !push_.input.this.data('htmlgetsql-table')


                # #
                # Seleciona os valores de ['data-htmlgetsql-select']

                # caso ['data-htmlgetsql-select'] esteja na raiz, adiciona em push_>input>this>push_>select os valores de select
                push_.input.this.push_.select = push_.input.this.data('htmlgetsql-select') if push_.input.this.data('htmlgetsql-select')

                # caso ['data-htmlgetsql-select'] esteja nos elementos pai de this, adiciona em push_>input>this>push_>select os valores de select
                push_.input.this.push_.select = $(push_.input.this).closest('[data-htmlgetsql-select]').data('htmlgetsql-select') if !push_.input.this.data('htmlgetsql-select')


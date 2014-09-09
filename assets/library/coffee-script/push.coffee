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


    # valido de push>setings>action é do tipo 'input', onde bind deve ser ativo ao modificar algum texto
    if push_.contents.data('htmlgetsql-push-sentings').action is 'input'

        # inicia o tratamento quando .bind for do tipo 'input', quando um texto é modificado
        push_.contents.bind 'input', ->

            # # # #
            # define objetos globais

            # adiciona em push_>input>this o documento atual do .bind()
            push_.input.this = $(this)

            # adiciona em push_>input>this>setings as configurações desse push
            push_.input.this.setings = push_.input.this.data('htmlgetsql-push-sentings')

            # define push_>input>this>push_ com [object Object], deve carregar as informações do envio
            push_.input.this.push_ = {}

            # cria objeto temporario 
            push_.input.this.temp = {}

            # cria objeto temporario para trabalhar os valores
            push_.input.this.temp.context = {}


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


                # #
                # Seleciona os valores de ['data-htmlgetsql-context-inline']

                # caso ['data-htmlgetsql-context-inline] esteja na raiz, adiciona em push_>input>this>push_>context os valores de 'values' em context
                push_.input.this.temp.context.this = push_.input.this.data('htmlgetsql-context-inline') if push_.input.this.data('htmlgetsql-context-inline')

                # caso [['data-htmlgetsql-context-inline] esteja nos elementos pai de this, adiciona em push_>input>this>push_>context os valores de 'values' em context
                push_.input.this.temp.context.this= $(push_.input.this).closest('[data-htmlgetsql-context-inline]').data('htmlgetsql-context-inline') if !push_.input.this.data('htmlgetsql-context-inline')


            # # #
            # Inicia tratamento dos valores de context

            # adiciona em  @temp>context>temp a array com as substituições adequadas
            push_.input.this.temp.context.temp = JSON.stringify(push_.input.this.temp.context.this).replace(/\,/g, '\n').replace(/\"/g, '').replace(/\{/g, '').replace(/\}/g, '').replace(/\n /g, '\n').replace(/\:/g, '>').split('\n')

            # adiciona em @temp>context>source o resultado da função explode('>') em @temp>context>temp 
            push_.input.this.temp.context.source = push_.input.this.temp.context.temp[0].split('>')

            # adiciona em @temp>count a quantidade de campos de @temp>context>source, e subitrai 1 para a contagem a partir de 0
            push_.input.this.temp.count = (push_.input.this.temp.context.source.length-1)

            # #
            # loop para capturar cada evento de @temp>context>source, com aplicação inversa
            while push_.input.this.temp.count >= 0

                # quando @temp>count estiver ultima posição, tratara o value
                if push_.input.this.temp.count is (push_.input.this.temp.context.source.length-1)

                    # adicina em @temp>context>teturn o valor da posição atual, este é o valor do metodo do context no objeto
                    push_.input.this.temp.context.return = push_.input.this.temp.context.source[push_.input.this.temp.count] 

                    # adiciona em @temp>context>value a função '$.parser_values_request' para selecionar os dados do campo em @temp>context>return
                    push_.input.this.temp.context.value = "valor"

                # quando @temp>count estiver na penultima posição, inicia montagem de @temp>context>obj
                if push_.input.this.temp.count is (push_.input.this.temp.context.source.length-2)

                    # adiciona em @temp>context>obj um [object Object] com key = posição atual e val = @temp>context>value
                    push_.input.this.temp.context.obj = '{"' + push_.input.this.temp.context.source[push_.input.this.temp.count] + '":"' + push_.input.this.temp.context.value + '"}'


                # quando @temp>count tiver passado da penultima posição, continua a montagem de @temp>context>obj
                if push_.input.this.temp.count < (push_.input.this.temp.context.source.length-2)


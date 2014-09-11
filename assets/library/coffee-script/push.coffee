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

            # adiciona em push_>input>setings as configurações desse push
            push_.input.setings = push_.input.this.data('htmlgetsql-push-sentings')

            # define push_>input>this>push_ com [object Object], deve carregar as informações do envio
            push_.input.push_ = {}

            # cria objeto temporario 
            push_.input.temp = {}

            # cria objeto temporario para trabalhar os valores
            push_.input.temp.context = {}


            # # # #
            # Trata as conexões deste evento
            if push_.input.setings.connect is 'pull'

                # #
                # Seleciona os valores de ['data-htmlgetsql-table']

                # caso ['data-htmlgetsql-table'] esteja na raiz, adiciona em push_>input>this>push_>table os valores de table
                push_.input.push_.table = push_.input.this.data('htmlgetsql-table') if push_.input.this.data('htmlgetsql-table')

                # caso ['data-htmlgetsql-table'] esteja nos elementos pai de this, adiciona em push_>input>this>push_>table os valores de table
                push_.input.push_.table = $(push_.input.this).closest('[data-htmlgetsql-table]').data('htmlgetsql-table') if !push_.input.this.data('htmlgetsql-table')


                # #
                # Seleciona os valores de ['data-htmlgetsql-select']

                # caso ['data-htmlgetsql-select'] esteja na raiz, adiciona em push_>input>this>push_>select os valores de select
                push_.input.push_.select = push_.input.this.data('htmlgetsql-select') if push_.input.this.data('htmlgetsql-select')

                # caso ['data-htmlgetsql-select'] esteja nos elementos pai de this, adiciona em push_>input>this>push_>select os valores de select
                push_.input.push_.select = $(push_.input.this).closest('[data-htmlgetsql-select]').data('htmlgetsql-select') if !push_.input.this.data('htmlgetsql-select')


                # #
                # Seleciona os valores de ['data-htmlgetsql-context-inline']

                # caso ['data-htmlgetsql-context-inline] esteja na raiz, adiciona em push_>input>this>push_>context os valores de 'values' em context
                push_.input.temp.context.this = push_.input.this.data('htmlgetsql-context-inline') if push_.input.this.data('htmlgetsql-context-inline')

                # caso [['data-htmlgetsql-context-inline] esteja nos elementos pai de this, adiciona em push_>input>this>push_>context os valores de 'values' em context
                push_.input.temp.context.this= $(push_.input.this).closest('[data-htmlgetsql-context-inline]').data('htmlgetsql-context-inline') if !push_.input.this.data('htmlgetsql-context-inline')


                # #
                # Seleciona os valores de ['data-htmlgetsql-push-method']

                # caso ['data-htmlgetsql-context-inline] esteja na raiz, adiciona em push_>input>this>push_>context os valores de 'values' em context
                push_.input.push_.type = push_.input.this.data('htmlgetsql-push-method') if push_.input.this.data('htmlgetsql-push-method')

                # caso [['data-htmlgetsql-push-method] esteja nos elementos pai de this, adiciona em push_>input>this>push_>context os valores de 'values' em context
                push_.input.push_.type = $(push_.input.this).closest('[data-htmlgetsql-push-method]').data('htmlgetsql-push-method') if !push_.input.this.data('htmlgetsql-push-method')


            # # #
            # Inicia tratamento dos valores de context

            # adiciona em  push_>input>temp>context>temp a array com as substituições adequadas
            push_.input.temp.context.temp = JSON.stringify(push_.input.temp.context.this).replace(/\,/g, '\n').replace(/\"/g, '').replace(/\{/g, '').replace(/\}/g, '').replace(/\n /g, '\n').replace(/\:/g, '>').split('\n')

            # adiciona em push_>input>temp>context>source o resultado da função explode('>') em push_>input>temp>context>temp 
            push_.input.temp.context.source = push_.input.temp.context.temp[0].split('>')

            # adiciona em push_>input>temp>count a quantidade de campos de push_>input>temp>context>source, e subitrai 1 para a contagem a partir de 0
            push_.input.temp.count = (push_.input.temp.context.source.length-1)

            # #
            # loop para capturar cada evento de push_>input>temp>context>source, com aplicação inversa
            while push_.input.temp.count >= 0

                # quando push_>input>temp>count estiver ultima posição, tratara o value
                if push_.input.temp.count is (push_.input.temp.context.source.length-1)

                    # adicina em push_>input>temp>context>teturn o valor da posição atual, este é o valor do metodo do context no objeto
                    push_.input.temp.context.return = push_.input.temp.context.source[push_.input.temp.count] 

                    # adiciona em push_>input>temp>context>value a função '$.parser_values_request' para selecionar os dados do campo em push_>input>temp>context>return
                    push_.input.temp.context.value = $.parser_values_request push_.input.this, '', push_.input.temp.context.return

                # quando push_>input>temp>count estiver na penultima posição, inicia montagem de push_>input>temp>context>obj
                if push_.input.temp.count is (push_.input.temp.context.source.length-2)

                    push_.input.push_.values = {}

                    # adiciona em push_>input>temp>context>obj um [object Object] com key = posição atual e val = push_>input>temp>context>value
                    push_.input.push_.values[push_.input.temp.context.source[push_.input.temp.count]] = push_.input.temp.context.value + ''



                # quando push_>input>temp>count tiver passado da penultima posição, continua a montagem de push_>input>temp>context>obj
                if push_.input.temp.count < (push_.input.temp.context.source.length-2)

                    push_.input.temp.values = {}

                    # adiciona em push_>input>temp>context>obj um [object Object] com key = posição atual e val = push_>input>temp>context>obj (ele mesmo)
                    push_.input.temp.values[push_.input.temp.context.source[push_.input.temp.count]] = push_.input.push_.values
                    push_.input.push_.values = push_.input.temp.values

                # adiciona -1 em push_>input>temp>count
                push_.input.temp.count--


            # #
            # Reserva valores dos resultados

            # cria [objeto Object] para push_>input>setings>reserve caso ele já não exista
            push_.input.setings.reserve = {} if !push_.input.setings.reserve

            # adiciona em push_>input>setings>reserve>source o source de context
            push_.input.setings.reserve.source = push_.input.temp.context.source

            # adiciona em push_>input>setings>reverve>return o valor de retorno de ['data-htmlgetsql-context-inline']
            push_.input.setings.reserve.return = push_.input.temp.context.return

            delete push_.input.temp

            # # #
            # trata envio para o servidor

            # acrecenta em push_>input>push_>return o resultado da submição
            push_.input.push_.return = $($.submt_post push_.input.push_)[0]

            # caso tenha tido sucesso
            if push_.input.push_.return.success

                # adiciona na estrutura do html o valor de alteração
                push_.input.this.attr("data-htmlgetsql-update", JSON.stringify(push_.input.push_.return))

                console.log $("[data-htmlgetsql-update]").data('htmlgetsql-update')

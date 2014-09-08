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


            # # # #
            # Trata o valor de context e aplica nas conexões

            # valor de retorno
            push_.input.this.temp.context.return = $.extract_object_value {object:push_.input.this.temp.context.this}, {"key":''}

            # valor do campo
            push_.input.this.temp.context.value = $.parser_values_request push_.input.this, '', push_.input.this.temp.context.return[0]

            # caminho de value
            push_.input.this.temp.context.source = $($.extract_object_value push_.input.this.temp.context.this, {"estrutura"})[0].split('>')

            # adiciona 0 em count
            push_.input.this.temp.context.count  = (push_.input.this.temp.context.source.length-1)

            # #
            # aplica laço para mesclar o push_>input>this>temp>context>value na estrutura de push_>input>this>temp>context>this
            while push_.input.this.temp.context.count >= 0

                # adiciona em push_>input>this>temp>context>obj a montagem quando for a primeira entrada
                push_.input.this.temp.context.obj = '{"' + push_.input.this.temp.context.source[push_.input.this.temp.context.count] + '":"' + push_.input.this.temp.context.value + '"}' if push_.input.this.temp.context.count is (push_.input.this.temp.context.source.length-1)

                # adiciona em push_>input>this>temp>context>obj a montagem quando não for mais a primeira entrada
                push_.input.this.temp.context.obj = '{"' + push_.input.this.temp.context.source[push_.input.this.temp.context.count] + '":' + push_.input.this.temp.context.obj + '}' if push_.input.this.temp.context.count < (push_.input.this.temp.context.source.length-1)

                # adiciona +1
                push_.input.this.temp.context.count--
            
            # # 
            # acrenta nas configurações de conexão os valores de push_>input>this>temp>context
            push_.input.this.push_.context = $.parseJSON(push_.input.this.temp.context.obj)


            console.log push_.input.this.push_



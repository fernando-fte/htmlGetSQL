# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APLICAÇÃO DE TRATAMENTO DAS EDICÕES DO BANCO DE DADOS VIA JSON  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # FUNÇÂO PRINCIPAL # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# recebe valores do html, trata os valores e aplica os tratamentos
$.htmlGetSQL.push = (html) ->
    # # # # #
    # # Descreve valores recebidos em '$.push_values = (html) ->'
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

    # define 'tokens>push_>input' como um [object Object], para input
    $.htmlGetSQL.tokens.push_.input = {} if !$.htmlGetSQL.tokens.push_.input

    # define 'tokens>push_>input>temp' como um [object Object], para input
    $.htmlGetSQL.tokens.push_.input.temp = {} if !$.htmlGetSQL.tokens.push_.input.temp

    # define 'tokens>push_>input>contents' como um [object Object], para input
    $.htmlGetSQL.tokens.push_.input.contents = {} if !$.htmlGetSQL.tokens.push_.input.contents

    # define 'tokens>push_>hsitory' como um [object Object], para input
    $.htmlGetSQL.tokens.push_.history = {} if !$.htmlGetSQL.tokens.push_.history


    # adiciona em tokens>push_>contents [data-htmlgetsql-push]
    $.htmlGetSQL.tokens.push_.contents = html.find('[data-htmlgetsql-push]')

    # # # 
    # Trata cada ação [data-htmlgetsql-push]

    # adiciona zero no contador
    temp.count = 0

    # laço para cada item de tokens>push_>contents
    while temp.count < $.htmlGetSQL.tokens.push_.contents.length

        console.log 

        # # # # 
        # # Seleciona cada classe de ação

        # valido de push>setings>action é do tipo 'input', onde bind deve ser ativo ao modificar algum texto
        if $($.htmlGetSQL.tokens.push_.contents[temp.count]).data('htmlgetsql-push-sentings').action is 'input'

            # inicia o tratamento quando .bind for do tipo 'input', quando um texto é modificado
            $($.htmlGetSQL.tokens.push_.contents[temp.count]).bind 'input', ->

                # # # 
                # # Verifica se o campo ja foi processado

                # Adiciona em temp o valor falso
                $.htmlGetSQL.tokens.push_.input.temp = true

                # Adiciona em temp o valor verdadeiro, caso exista algo
                $.htmlGetSQL.tokens.push_.input.temp = false if $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId] if $(this).data().dataHtmlgetsqlPushId

                # #
                # Quando o campo ja tiver sido tratado
                if !$.htmlGetSQL.tokens.push_.input.temp

                    # adiciona temp no registro deste campo
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].temp = {}

                    # redefine this de context
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].context.this = $(this)

                    # redefine value
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].value = $.htmlGetSQL.buttress.merger_object_context $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].context

                    # redefine push_
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_ = {}
                    # redefine push_update
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.update = {}


                    # # #
                    # define valores para post 

                    # redefine type sendo "UPDATE"
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.type = 'update'

                    # redefine push_>table
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.table  = $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].connect.table
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.select = {}
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.select.sku = $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].connect.sku

                    # redefine push_>update>history
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.update.history = {}
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.update.history.this = $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].history.this
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.update.history.change = false if $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].history[$.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].history.this]
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.update.history.change = true if !$.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].history[$.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].history.this]

                    # redefine push_>update>value
                    $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_.update.value = $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].value


                    console.log $.htmlGetSQL.tokens.push_.input.contents[$(this).data().dataHtmlgetsqlPushId].push_


                # #
                # Quando for um campo
                if $.htmlGetSQL.tokens.push_.input.temp

                    $.htmlGetSQL.tokens.push_.input.temp = {}
                    # # # #
                    # define objetos globais

                    # adiciona em push_>input>this o documento atual do .bind()
                    $.htmlGetSQL.tokens.push_.input.temp.this = $(this)

                    # adiciona em push_>input>setings as configurações desse push
                    $.htmlGetSQL.tokens.push_.input.temp.setings = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-sentings')

                    # define push_>input>this>push_ com [object Object], deve carregar as informações do envio
                    $.htmlGetSQL.tokens.push_.input.temp.push_ = {}

                    # cria objeto temporario para trabalhar os valores
                    $.htmlGetSQL.tokens.push_.input.temp.context = {}

                    # define em push_>input>temp>context>this o html de this
                    $.htmlGetSQL.tokens.push_.input.temp.context.this = $.htmlGetSQL.tokens.push_.input.temp.this


                    # # # #
                    # Trata as conexões deste evento
                    if $.htmlGetSQL.tokens.push_.input.temp.setings.connect is 'pull'

                        # #
                        # Seleciona os valores de ['data-htmlgetsql-table']

                        # caso ['data-htmlgetsql-table'] esteja na raiz, adiciona em push_>input>this>push_>table os valores de table
                        $.htmlGetSQL.tokens.push_.input.temp.push_.table = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-table') if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-table')

                        # caso ['data-htmlgetsql-table'] esteja nos elementos pai de this, adiciona em push_>input>this>push_>table os valores de table
                        $.htmlGetSQL.tokens.push_.input.temp.push_.table = $($.htmlGetSQL.tokens.push_.input.temp.this).closest('[data-htmlgetsql-table]').data('htmlgetsql-table') if !$.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-table')


                        # #
                        # Seleciona os valores de ['data-htmlgetsql-select']

                        # caso ['data-htmlgetsql-select'] esteja na raiz, adiciona em push_>input>this>push_>select os valores de select
                        $.htmlGetSQL.tokens.push_.input.temp.push_.select = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-select') if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-select')

                        # caso ['data-htmlgetsql-select'] esteja nos elementos pai de this, adiciona em push_>input>this>push_>select os valores de select
                        $.htmlGetSQL.tokens.push_.input.temp.push_.select = $($.htmlGetSQL.tokens.push_.input.temp.this).closest('[data-htmlgetsql-select]').data('htmlgetsql-select') if !$.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-select')


                        # #
                        # Seleciona os valores de ['data-htmlgetsql-push-method']

                        # caso ['data-htmlgetsql-context-inline] esteja na raiz, adiciona em push_>input>this>push_>context os valores de 'values' em context
                        $.htmlGetSQL.tokens.push_.input.temp.push_.type = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-method') if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-method')

                        # caso [['data-htmlgetsql-push-method] esteja nos elementos pai de this, adiciona em push_>input>this>push_>context os valores de 'values' em context
                        $.htmlGetSQL.tokens.push_.input.temp.push_.type = $($.htmlGetSQL.tokens.push_.input.temp.this).closest('[data-htmlgetsql-push-method]').data('htmlgetsql-push-method') if !$.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-method')


                        # #
                        # Seleciona os valores de ['data-htmlgetsql-context-inline']

                        # caso ['data-htmlgetsql-context-inline] esteja na raiz, adiciona em push_>input>this>push_>context os valores de 'values' em context
                        $.htmlGetSQL.tokens.push_.input.temp.context.obj = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-context-inline') if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-context-inline')

                        # caso [['data-htmlgetsql-context-inline] esteja nos elementos pai de this, adiciona em push_>input>this>push_>context os valores de 'values' em context
                        $.htmlGetSQL.tokens.push_.input.temp.context.obj= $($.htmlGetSQL.tokens.push_.input.temp.this).closest('[data-htmlgetsql-context-inline]').data('htmlgetsql-context-inline') if !$.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-context-inline')


                    # # #
                    # Inicia tratamento dos valores de context

                    # trata os valores de context com o valor do input
                    $.htmlGetSQL.tokens.push_.input.temp.push_.values = $.htmlGetSQL.buttress.merger_object_context $.htmlGetSQL.tokens.push_.input.temp.context


                    # # #
                    # trata envio para o servidor

                    # acrecenta em push_>input>push_>return o resultado da submição
                    $.htmlGetSQL.tokens.push_.input.temp.push_.return = $($.htmlGetSQL.buttress.send $.htmlGetSQL.tokens.push_.input.temp.push_)[0]

                    # caso tenha tido sucesso
                    if $.htmlGetSQL.tokens.push_.input.temp.push_.return.success

                        # cria novo registro em contents
                        $.htmlGetSQL.tokens.push_.input.contents[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history] = {}

                        # adiciona os history
                        $.htmlGetSQL.tokens.push_.input.contents[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].history = {}

                        # adiciona o id do registro
                        $(this).data("data-htmlgetsql-push-id", $.htmlGetSQL.tokens.push_.input.temp.push_.return.history)

                        # #
                        # monta valores globais do campo

                        # adciona connect
                        $.htmlGetSQL.tokens.push_.input.contents[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].connect = $.htmlGetSQL.tokens.push_.input.temp.push_.return.connect

                        # adciona value
                        $.htmlGetSQL.tokens.push_.input.contents[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].value = $.htmlGetSQL.tokens.push_.input.temp.push_.values

                        # adciona context obj
                        $.htmlGetSQL.tokens.push_.input.contents[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].context = $.htmlGetSQL.tokens.push_.input.temp.context

                        # adiciona os history
                        $.htmlGetSQL.tokens.push_.input.contents[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].history.this = $.htmlGetSQL.tokens.push_.input.temp.push_.return.history

                        # monta change de history
                        $.htmlGetSQL.tokens.push_.input.contents[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history] = true

                        # adiciona history na raiz
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history] = {}

                        # aponta histori para label ou campo
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].label = $.htmlGetSQL.tokens.push_.input.temp.push_.return.history

                        # define que o objeto ainda não foi salvo
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].change = false




        # console.log 'oi'
        temp.count++
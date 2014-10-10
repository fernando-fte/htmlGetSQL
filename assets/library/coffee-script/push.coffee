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
    # $.htmlGetSQL.tokens.push_.field = {} if !$.htmlGetSQL.tokens.push_.field

    # define 'tokens>push_>history' como um [object Object], para input
    $.htmlGetSQL.tokens.push_.history = {} if !$.htmlGetSQL.tokens.push_.history

    # define 'tokens>push_>field' como um [object Object], para input
    $.htmlGetSQL.tokens.push_.field = {} if !$.htmlGetSQL.tokens.push_.field


    # adiciona em tokens>push_>contents [data-htmlgetsql-push]
    $.htmlGetSQL.tokens.push_.contents = html.find('[data-htmlgetsql-push]')

    # # # 
    # Trata cada ação [data-htmlgetsql-push]

    # adiciona zero no contador
    temp.count = 0

    # laço para cada item de tokens>push_>contents
    while temp.count < $.htmlGetSQL.tokens.push_.contents.length

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
                $.htmlGetSQL.tokens.push_.input.temp = false if $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')] if $(this).data('htmlgetsql-push-id')

                # #
                # Quando o campo ja tiver sido tratado
                if !$.htmlGetSQL.tokens.push_.input.temp

                    # adiciona temp no registro deste campo
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].temp = {}

                    # redefine this de context
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].context.this = $(this)

                    # redefine value
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].value = $.htmlGetSQL.buttress.merger_object_context $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].context

                    # redefine push_
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_ = {}

                    # redefine push_update
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.update = {}


                    # # #
                    # define valores para post 

                    # redefine type sendo 'UPDATE'
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.type = 'update'

                    # redefine push_>table
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.table  = $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].connect.table

                    # redefine push_>select
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.select = {}

                    # redefine push_>select>sku
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.select.sku = $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].connect.sku


                    # verifica se history é verdadeiro
                    if $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].history[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].history.this]

                        # redefine push_>update>history
                        $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.update.history = {}

                        # adiciona em push_>update>history>this o id de history
                        $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.update.history.this = $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].history.this

                        # adiciona em push_>update>history>change com false
                        $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.update.history.change = false 

                    # retorna em history o valor falso
                    delete $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.update.history if !$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].history[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].history.this]

                    # redefine push_>update>value
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.update.value = $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].value

                    # envia atualização para o servidor
                    $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return = $($.htmlGetSQL.buttress.send $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_)[0]


                    # # #
                    # Quando for criado um novo history
                    if $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return.type is 'new-history'

                        # adiciona novo history ao field
                        $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].history[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return.history] = true

                        # define em this o novo history
                        $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].history.this = $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return.history

                        # adiciona na lista de history o novo history
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return.history] = {}

                        # define em history global o atributo change
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return.history].change = false

                        # define em history global o field a quem ele pertence                        
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return.history].field = $(this).data('htmlgetsql-push-id')

                        # define caso change seja em get
                        if $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].change.get

                            # adiciona no evento change o atributo false
                            $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].change.id].change = false

                            # adiciona o history na listagem do change
                            $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].change.id].history[$.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].change.id].history.length] = $.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].push_.return.history

                            # adiciona +1 em length para contar o valor adicionado
                            $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[$(this).data('htmlgetsql-push-id')].change.id].history.length++


                # #
                # Quando for um novo campo
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
                    # Trata as configurações de change

                    # # Caso exista change
                    if $.htmlGetSQL.tokens.push_.input.temp.setings.change

                        # #
                        # caso change seja do tipo me
                        if $.htmlGetSQL.tokens.push_.input.temp.setings.change is 'me'

                            # adiciona change em setings como [object Object]
                            $.htmlGetSQL.tokens.push_.input.temp.setings.change = {}

                            # configura o elemento a receber o evento
                            $.htmlGetSQL.tokens.push_.input.temp.setings.change.get = false

                            # configura que o tipo de change seja ao sair do input
                            $.htmlGetSQL.tokens.push_.input.temp.setings.change.type = 'input'

                        # #
                        # caso change seja do tipo pull, caso exista configurações
                        if $.htmlGetSQL.tokens.push_.input.temp.setings.change is 'pull'

                            # adiciona change em setings como [object Object]
                            $.htmlGetSQL.tokens.push_.input.temp.setings.change = {}

                            # valida se existe a configuração
                            if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-change')

                                # verifica se o metotho de tratamento esta em mim
                                if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-change').action is 'me'

                                    # configura o elemento a receber o evento
                                    $.htmlGetSQL.tokens.push_.input.temp.setings.change.get = false

                                    # configura que o tipo de change seja ao sair do input, caso não tenha recebido nem um parametro
                                    $.htmlGetSQL.tokens.push_.input.temp.setings.change.type = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-change').method

                                    # adiciona a configuração de success
                                    $.htmlGetSQL.tokens.push_.input.temp.setings.change.success = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-change').success

                                    # configura que o tipo de change seja ao sair do input
                                    $.htmlGetSQL.tokens.push_.input.temp.setings.change.type = 'input'


                                # verifica se o metodo de tratamento é externo
                                if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-change').action is 'get'

                                    # verifica se ja existe este atributo no campo get
                                    if $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-change').get

                                        # adiciona o id em change>get
                                        $.htmlGetSQL.tokens.push_.input.temp.setings.change.get = true

                                        # adiciona o id em change>id
                                        $.htmlGetSQL.tokens.push_.input.temp.setings.change.id = $.htmlGetSQL.tokens.push_.input.temp.this.data('htmlgetsql-push-change').get


                    # # Caso não exista change
                    if !$.htmlGetSQL.tokens.push_.input.temp.setings.change

                        # adiciona change em setings como [object Object]
                        $.htmlGetSQL.tokens.push_.input.temp.setings.change = {}

                        # configura o elemento a receber o evento
                        $.htmlGetSQL.tokens.push_.input.temp.setings.change.get = false

                        $.htmlGetSQL.tokens.push_.input.temp.setings.change.type = 'input'


                    # Trata as configurações de change
                    # # #


                    # # #
                    # trata envio para o servidor

                    # acrecenta em push_>input>push_>return o resultado da submição
                    $.htmlGetSQL.tokens.push_.input.temp.push_.return = $($.htmlGetSQL.buttress.send $.htmlGetSQL.tokens.push_.input.temp.push_)[0]

                    # caso tenha tido sucesso
                    if $.htmlGetSQL.tokens.push_.input.temp.push_.return.success

                        # cria novo registro em contents
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history] = {}

                        # adiciona os history
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].history = {}

                        # adiciona o id do registro
                        $(this).data('htmlgetsql-push-id', $.htmlGetSQL.tokens.push_.input.temp.push_.return.history)

                        # #
                        # monta valores globais do campo

                        # adciona connect
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].connect = $.htmlGetSQL.tokens.push_.input.temp.push_.return.connect

                        # adciona value
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].value = $.htmlGetSQL.tokens.push_.input.temp.push_.values

                        # adciona context obj
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].context = $.htmlGetSQL.tokens.push_.input.temp.context

                        # adiciona os history
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].history.this = $.htmlGetSQL.tokens.push_.input.temp.push_.return.history

                        # monta change de history
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history] = true

                        # adciona ação de change
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].change = $.htmlGetSQL.tokens.push_.input.temp.setings.change


                        # adiciona history na raiz
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history] = {}

                        # aponta histori para field ou campo
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].field = $.htmlGetSQL.tokens.push_.input.temp.push_.return.history

                        # define que o objeto ainda não foi salvo
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].change = false

                        # define o tipo de ação deste campo
                        $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.input.temp.push_.return.history].action = 'input'

                        # repassa para a função de processamento da função change
                        $.htmlGetSQL.push.change $.htmlGetSQL.tokens.push_.input.temp.push_.return.history
                # #
                # Configura a ação de salvar

        # console.log 'oi'
        temp.count++


    # # #
    # Função para change
    $.htmlGetSQL.push.change = (field) ->

        # # # # # # # # # # # # # #
        # Define objetos globais

        # define 'tokens>push_>change' como um [object Object], para change
        $.htmlGetSQL.tokens.push_.change = {} if !$.htmlGetSQL.tokens.push_.change

        # define 'tokens>push_>change>temp' como um [object Object], para change
        $.htmlGetSQL.tokens.push_.change.temp = {} if !$.htmlGetSQL.tokens.push_.change.temp

        # Define objetos globais
        # # # # # # # # # # # # # #

        # # 
        # caso a seleção do change seja em this/me
        if $.htmlGetSQL.tokens.push_.field[field].change.get is false

            # #
            # seleciona o method que deve ser definido para change

            # quando for ativado ao sair do campo
            if $.htmlGetSQL.tokens.push_.field[field].change.type is 'input'

                # seleciona o this do context do campo atual, e aplica o evento focusOut
                $($.htmlGetSQL.tokens.push_.field[field].context.this).focusout ->

                    # caso o history atual do campo esteja ativo
                    if $.htmlGetSQL.tokens.push_.field[field].history[$.htmlGetSQL.tokens.push_.field[field].history.this]

                        # limpa push_
                        $.htmlGetSQL.tokens.push_.field[field].push_ = {}

                        # adiciona update em push_
                        $.htmlGetSQL.tokens.push_.field[field].push_.update = {}

                        # adiciona history em push_
                        $.htmlGetSQL.tokens.push_.field[field].push_.update.history = {}


                        # define type em push_
                        $.htmlGetSQL.tokens.push_.field[field].push_.type = 'update'

                        # adiciona em push_>update>history>change com false
                        $.htmlGetSQL.tokens.push_.field[field].push_.update.history.this = $.htmlGetSQL.tokens.push_.field[field].history.this

                        # adiciona em push_>update>history>this o id de history
                        $.htmlGetSQL.tokens.push_.field[field].push_.update.history.change = true

                        # envia chenge ao servidor
                        console.log $($.htmlGetSQL.buttress.send $.htmlGetSQL.tokens.push_.field[field].push_)[0]

                        # #
                        # registra finalização de modificação da estrutura

                        # aplica false ao history atual
                        $.htmlGetSQL.tokens.push_.field[field].history[$.htmlGetSQL.tokens.push_.field[field].history.this] = false

                        # define na lista de historys que esse history tem change como  true
                        $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.field[field].history.this].change = true
                        # #


        # caso exista o atributo
        if $.htmlGetSQL.tokens.push_.field[field].change.get is true

            # verifica se o change ainda não existe na biblioteca change
            if !$.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id]
                
                # adiciona em temp.count zero
                $.htmlGetSQL.tokens.push_.change.temp.count = 0

                # loop para selecionar cada "htmlgetsql-push-change-id"
                while $.htmlGetSQL.tokens.push_.change.temp.count < $(document).find('[data-htmlgetsql-push-change-id]').length

                    # adiciona o valor na posição atual para manipulaçnao
                    $.htmlGetSQL.tokens.push_.change.temp.this = $(document).find('[data-htmlgetsql-push-change-id]')[$.htmlGetSQL.tokens.push_.change.temp.count]

                    # verifica se ainstancia atual não existe no index
                    if !$.htmlGetSQL.tokens.push_.change[$($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change-id')]

                        # cria change como [object Object]
                        $.htmlGetSQL.tokens.push_.change[$($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change-id')] = {}

                        # adiciona configurações basicas
                        $.htmlGetSQL.tokens.push_.change[$($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change-id')].this = $.htmlGetSQL.tokens.push_.change.temp.this

                        # adiciona history em change
                        $.htmlGetSQL.tokens.push_.change[$($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change-id')].history = {}

                        # adiciona langht em history
                        $.htmlGetSQL.tokens.push_.change[$($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change-id')].history.length = 0

                        # adiciona a validaça em change como preenchida
                        $.htmlGetSQL.tokens.push_.change[$($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change-id')].change = null

                        # adiciona instruções adicionadas
                        $.htmlGetSQL.tokens.push_.change[$($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change-id')].setings = $($.htmlGetSQL.tokens.push_.change.temp.this).data('htmlgetsql-push-change')

                    # adiciona 1 no contador
                    $.htmlGetSQL.tokens.push_.change.temp.count++


            # cria posição em history
            $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history[$.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history.length] = $.htmlGetSQL.tokens.push_.field[field].history.this

            # adiciona +1 ao length de history para contabilizar a adição de um novo historico
            $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history.length++

            # adiciona como change false, não tendo sido salvo
            $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].change = false


            # # #
            # # Inicia tratamento do evento

            # caso a configuração seja para click
            if $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].setings.method is 'click'

                # adiciona evento click
                $($.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].this).click ->

                    # verifica se ainda existe algo a ser salvo
                    if $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].change is false

                        # adiciona 0 pra contador em temp
                        $.htmlGetSQL.tokens.push_.change.temp.count = 0

                        # adiciona change em temp para manipulação temporaria
                        $.htmlGetSQL.tokens.push_.change.temp.change = {}

                        # loop para capturar cada instancia de history
                        while $.htmlGetSQL.tokens.push_.change.temp.count < $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history.length

                            # adiciona em temp>change>this o valor do history a ser checado
                            $.htmlGetSQL.tokens.push_.change.temp.change.history = $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history[$.htmlGetSQL.tokens.push_.change.temp.count]

                            # localiza field para mainipulação
                            $.htmlGetSQL.tokens.push_.change.temp.change.field = $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.change.temp.change.history].field


                            # caso o history atual do campo esteja ativo
                            if !$.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.change.temp.change.history].change

                                # limpa push_
                                $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].push_ = {}

                                # adiciona update em push_
                                $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].push_.update = {}

                                # adiciona history em push_
                                $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].push_.update.history = {}


                                # define type em push_
                                $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].push_.type = 'update'

                                # adiciona em push_>update>history>change com false
                                $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].push_.update.history.this = $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].history.this

                                # adiciona em push_>update>history>this o id de history
                                $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].push_.update.history.change = true

                                # envia chenge ao servidor
                                console.log $($.htmlGetSQL.buttress.send $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].push_)[0]

                                # #
                                # registra finalização de modificação da estrutura

                                # aplica false ao history atual
                                $.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].history[$.htmlGetSQL.tokens.push_.field[$.htmlGetSQL.tokens.push_.change.temp.change.field].history.this] = false

                                # define na lista de historys que esse history tem change como  true
                                $.htmlGetSQL.tokens.push_.history[$.htmlGetSQL.tokens.push_.change.temp.change.history].change= true

                                # #

                            # finaliza ação
                            if ($.htmlGetSQL.tokens.push_.change.temp.count+1) is $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history.length

                                while $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history.length > 0

                                    # deleta o valor atual relativo a length
                                    delete $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history[($.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history.length-1)]

                                    # remove 1 de langht
                                    $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].history.length--

                                # adiciona em change o atributo change true
                                $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id].change = true

                            # adiciona +1 no contador
                            $.htmlGetSQL.tokens.push_.change.temp.count++

                        # seleciona contador

                        # console.log $.htmlGetSQL.tokens.push_.change[$.htmlGetSQL.tokens.push_.field[field].change.id]

                        #




















# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APLICAÇÃO DE TRATAMENTO DAS SOLICITAÇÃO VIA JSON VINDA DO BANCO #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # #
# INICIA OBJECT GLOBAL DE MANIPULAÇÃO #
# define caso não exista
$.htmlGetSQL = {} if !$.htmlGetSQL

# define buttress caso não exista
$.htmlGetSQL.buttress = {} if !$.htmlGetSQL.buttress

# define tokens caso não exista
$.htmlGetSQL.tokens = {} if !$.htmlGetSQL.tokens

# define tokens>pull_ caso não exista
$.htmlGetSQL.tokens.pull_ = {} if !$.htmlGetSQL.tokens.pull_

# define tokens>push_ caso não exista
$.htmlGetSQL.tokens.push_ = {} if !$.htmlGetSQL.tokens.push_

# define tokens>user_ caso não exista
$.htmlGetSQL.tokens.user_ = {} if !$.htmlGetSQL.tokens.user_

#                                     #
# # # # # # # # # # # # # # # # # # # #


# # # # FUNÇÕES DE APOIO # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# recebe e trata os valores de solicitação e resposta
$.htmlGetSQL.buttress.parse_values = (me, data, val) -> #recebe função, introdução a baixo

    # subfunção de retorno de valores
    $.htmlGetSQL.buttress.parse_values.request = (value) ->

        switch value.type # quando o valor
            # processa valor e preenche o local indicado
            # ou retorna o valor do local indicado

            when "value" # quando o tipo for value
                value.me.val(value.val) if !value.return
                return me.val() if value.return

            when "text" # quando o tipo for texto
                value.me.html(value.val) if !value.return
                return me.html() if value.return

            when "url" # quando for uma url
                value.me.attr("href":value.val) if !value.return
                return value.me.attr("href") if value.return

            when "href" # quando for uma url
                value.me.attr("href":value.val) if !value.return
                return value.me.attr("href") if value.return

            when "title" # quando for title
                value.me.attr("title":value.val) if !value.return
                return value.me.attr("title") if value.return

            when "alt" # quando for titulo de link
                value.me.attr("alt":value.val) if !value.return
                return value.me.attr("alt") if value.return

            when "src" # quando for um link
                value.me.attr("src":value.val) if !value.return
                return value.me.attr("src") if value.return

            when "input" # quando for u texto de input
                value.me.attr("value":value.val) if !value.return
                return me.attr("value") if val.return

            when "chenge" # quando for u texto de input            
                value.me.attr("value":value.val) if !value.return
                return value.me.attr("value") if value.return

            when "class" # quando for uma classe
                value.me.addClass(value.val) if val.return
                value.me.data("template-request-class", value.val) if !value.return
                value.me.data("template-request-class")[value.return] if value.return

            when "template-toogle" # quando for um toogle
                value.me.data("template-request-toogle", value.val) if !value.return
                value.me.data("template-request-toogle")[value.return] if value.return

    # # # # # # # # # # # # # # # # # # # # # # # # #

    # # # # #
    # Inicia a aplição da função $.htmlGetSQL.buttress.parse_values

    # # # # #
    # # Descreve valores recebidos em '$.htmlGetSQL.buttress.parse_values = (me, data, val) ->'
    # me   = html na arvore down
    # data = valor unico para tipo de campo
    # val  = valor a ser acrecentado conforme "data" ou a 
    #        solicitação do reconhecimento do campo
    # # # # #

    # cria object 'process' trasportador de valores
    process =  {}

    # caso não seja uma sequencia de valores '[object Object]' com uma solicitação de tipo de valor
    if !data or (!data+'') is '[object Object]' #quando val: objeto
        # adiciono em return o valor
        process.return = data if data
        process.return = {} if !data
        process.type = val
        process.me

        # processo os valores na subfunção '$.htmlGetSQL.buttress.parse_values.request'
        $.htmlGetSQL.buttress.parse_values.request process

    # caso seja um '[object Object]'
    else # if !data or (!data+'') is '[object Object]'

        # recebe e copile os valores para a sincronia
        copile = $.htmlGetSQL.buttress.parser_object data, {"valida":val}

        # cria contador
        count = 0

        # faz repetição com a conta em 'copile.length'
        while count < copile.length
            $.each copile[count], (key, val) ->
                # definições para os valores
                process.me  = me
                process.type = key
                process.val = val

                # processo os valores na sub-função
                $.htmlGetSQL.buttress.parse_values.request process

            # acrecento no loop
            count++
#
# Fim de "recebe e trata os valores de solicitação e resposta"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# extrai os valores do object
$.htmlGetSQL.buttress.parser_object = (data, parametro) ->
    # # # #
    # deve ser passado dois valores, um data e outro parametro sendo este relativo
    # caso não exista parametro comparativo será retornado o valor de data como uma lista
    # se houver parametro valida deve ser retornar um valor em lista com o valor -> a:b

    # # # #
    # exemplos de uso:
    # # banco = {"oi":"a", "1":{"1.1":{"1.1.1":"res 1.1.1 - banco"}, "1.2":{"1.2.1":"res 1.2.1 - banco"}}, "2":{"2.1":{"2.1.1":"res 2.1.1 - banco"}, "2.2":{"2.2.2":"res 2.2.1 - banco"}}}
    # # value = {"1.1.1":"text"}
    # # key = {"oi":"a", "1":{"1.1":{"1.1.1":"res 1.1.1 - banco"}}}

    # # console.log banco
    # # console.log $.htmlGetSQL.buttress.parser_object {object:banco}, {"valida":key}
    # # console.log $.htmlGetSQL.buttress.parser_object {object:banco}, {"key":key}
    # # console.log $.htmlGetSQL.buttress.parser_object {object:banco}, {"estrutura"}
    # # console.log $.htmlGetSQL.buttress.parser_object {object:banco}, {}
    # # # #

    # sub função para a validação do tipo de exceução
    $.htmlGetSQL.buttress.parser_object.ignore = (key) ->
        switch key
            when "template-toogle"
                return false
            else
                return true
        
    #cria data.object quando não houver
    if !data.object
        temp = data
        data = {"object":data}


    #entra no loop
    $.each data.object, (key, val) ->
        # verifica se é um objeto
        if (val+'') is '[object Object]' #quando val: objeto

            # valida se pode ser processado
            _return = $.htmlGetSQL.buttress.parser_object.ignore key

            # retorno o valor de template-toogle direto ao return
            if key is 'template-toogle'
                temp = {}
                temp[key] = parametro.valida[key]

                data.return.push temp

            # caso passe na validação
            if _return

                #aplica em data.object o "val"
                parametro_ = {}
                data.object = val # if !data.parametro.parametroaracao
                # # #

                # cria novo parametro para valida
                parametro_ = {} if parametro.valida
                parametro_.valida = parametro.valida[key] if parametro.valida && parametro.valida[key]
                parametro_.valida = {} if parametro.valida && !parametro.valida[key]
                # # #

                # cria novo parametro para keys
                parametro_ = {} if parametro.key
                parametro_.key = parametro.key[key] if parametro.key && parametro.key[key]
                parametro_.key = {} if parametro.key && !parametro.key[key]
                # # #

                # retornando valor na arvore de acesso
                parametro_ = {} if parametro.estrutura
                parametro_.estrutura = {} if parametro.estrutura # define novo parametro
                parametro_.estrutura = parametro.estrutura+''+key+'>' if parametro.estrutura # controi a arvore de acesso
                parametro_.estrutura = ''+key+'>' if parametro.estrutura && parametro.estrutura is 'estrutura'
                # # #

                #Retorna todos os valores a uma NOVA FUNCAO
                $.htmlGetSQL.buttress.parser_object data, parametro_


        # quando não é mais um objeto e sim um valor
        else # (val+'') is '[object Object]'

            # cria data.return caso não exista
            data.return = [] if !data.return

            # cria objeto para retornar a estrutura
            parametro.estrutura = parametro.estrutura+''+key+'' if parametro.estrutura # constroi a arvore de acesso
            parametro.estrutura = ''+key+'' if parametro.estrutura is ('estrutura>'+key+'') or parametro.estrutura is ''  # retorna apenas o primeiro valor

            # cria objeto em temp para preencher em data.return
            temp = {} if parametro.valida && parametro.valida[key]
            temp[val] = parametro.valida[key] if parametro.valida && parametro.valida[key]

            # cria objeto em temp para preencher em data.return
            temp = {} if parametro.key && parametro.key[key]
            temp[key] = val if parametro.key && parametro.key[key]


            # # # # # # # # # # # # # # # # #
            # monta os valores para retorno

            # adiciona em return o valor da ultima chave
            data.return.push temp if parametro.key && parametro.key[key]

            # adiciona em return o valor quando comparado sendo A|B A∩B
            data.return.push temp if parametro.valida && parametro.valida[key]
            
            # adiciona a estrutura em push
            data.return.push parametro.estrutura if parametro.estrutura

            # adiciona em return a lista de valores
            data.return.push val if !parametro.valida && !parametro.estrutura && !parametro.key

    # retorna os valores
    return data.return
#
# Fim de "extrai os valores do object"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # # # FUNÇÂO PRINCIPAL # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# recebe valores do html e trata os valores e aplica tratamentos
$.htmlGetSQL.pull = (html) ->
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

    # define 'pull' como um [object Object], para receber parametros
    pull = {}


    # # # # #
    # Inicia a aplição da função $.pull_values

    # conta quantas incidencias de data-template existem e adiciono em .count
    pull.count = html.find("[data-htmlgetsql-pull]").size()

    # pega cada ocorrencia de [data-htmlgetsql-pull] em loop
    while temp['position'] < pull.count

        # # # # #
        # define os parametros para o processamento dos dados

        # define em 'pull' a posição atual 
        pull[temp['position']] = {} # define template na posição atual
        pull[temp['position']].pull = {} # define template.pull na posição atual

        # defino em 'this' no momento atual o data-template
        pull[temp['position']].this = html.find("[data-htmlgetsql-pull]").eq(temp['position'])

        # define o tipo de conexãom por padrão select
        pull[temp['position']].pull.type = 'select' # seleciona

        # seleciona os dados para conexão
        pull[temp['position']].pull.table  = pull[temp['position']].this.data("htmlgetsql-table")  # tabela
        pull[temp['position']].pull.select = pull[temp['position']].this.data("htmlgetsql-select") # parametros

        # defino o valor em data o tipo de template /child/me/gallery/
        pull[temp['position']].data = pull[temp['position']].this.data("htmlgetsql-pull")

        # valida o tipo de solicitação quando vier de um update
        if pull[temp['position']].this.data('push') # caso seja de um formulário tipo data-push

            # verifica se o push possui type
            if pull[temp['position']].this.data('push').type # caso exista type

                # loop para aplicar conforme a solicitação (update|recuver)
                pull[temp['position']].pull.status = pull[temp['position']].this.data('push').type


        # # # # #
        # trata os parametros tratados, e manipula o dom

        # #
        # quando 'pull' for do tipo 'me', e o tratamento for para o elemento atual
        if pull[temp['position']].data is "me"

            # seleciona os valores do banco de dados
            temp['return'] = $.htmlGetSQL.buttress.send pull[temp['position']].pull

            # defino em 'pull["position"].values' os valores de 'template-data'
            pull[temp['position']].this.values = pull[temp['position']].this.data('htmlgetsql-context-inline')

            # valida se foi recebido algo do php, para processar os valores
            if temp['return']

                # repassa para a função processar e aplicar os valores
                $.htmlGetSQL.buttress.parse_values pull[temp['position']].this, pull[temp['position']].this.values, temp['return']['0']
        #
        # Fim de 'quando 'pull' for do tipo 'me', e o tratamento for para o elemento atual'
        # #

        # #
        # quando 'pull' for do tipo 'child', e o tratamento for para os elementos filhos
        else if pull[temp['position']].data is "child"

            # seleciona os valores do banco de dados
            temp['return'] = $.htmlGetSQL.buttress.send pull[temp['position']].pull

            # seleciona onde vaiser acrecentado os dados
            pull[temp['position']].childs = {} # define template.values para valor de cada item

            # defino os objetos a ser preenchidos
            pull[temp['position']].childs.contents = pull[temp['position']].this.find('[data-htmlgetsql-context-inline]')

            # conto quantas incidencias
            pull[temp['position']].childs.count = pull[temp['position']].childs.contents.size()

            # define contador apartie da posição atual e adiciona zero
            temp['count'][temp['position']] = 0 # acrecento em zero

            # cria laço para selecionar cada elemento filho
            while temp['count'][temp['position']] < pull[temp['position']].childs.count
                # defino child em this no momento atual
                pull[temp['position']].childs.contents[temp['count'][temp['position']]].this = pull[temp['position']].childs.contents.eq(temp['count'][temp['position']])

                # defino values de child.this
                pull[temp['position']].childs.contents[temp['count'][temp['position']]].values = pull[temp['position']].childs.contents[temp['count'][temp['position']]].this.data("htmlgetsql-context-inline")

                # valida se foi recebido algo do php, para processar os valores
                if temp['return']

                    #repasso apra a função processar e aplicar os valores
                    $.htmlGetSQL.buttress.parse_values pull[temp['position']].childs.contents[temp['count'][temp['position']]].this, pull[temp['position']].childs.contents[temp['count'][temp['position']]].values, temp['return']['0']

                #acrecento nesta posicao
                temp['count'][temp['position']]++

            # exclui o temp return
            delete temp['return']
        #
        # Fim de 'quando 'pull' for do tipo 'child', e o tratamento for para os elementos filhos'
        # #

        # #
        # quando 'pull' for do tipo 'gallery', e o tratamento for para um loop baseado na quandidade de resultados
        else if pull[temp['position']].data is "gallery"

            # define que os resultados nao podem ter limites
            pull[temp['position']].pull.regra = {"limit":false} # limite de respostas

            # seleciona banco de dados
            temp['return'] = $.htmlGetSQL.buttress.send pull[temp['position']].pull

            # acrecebta em count zero na posicao atual
            temp['count'][temp['position']] = 0 # acrecento em zero

            #define objeto a ser duplicado como item de galeria
            pull[temp['position']].gallery = {}
            pull[temp['position']].gallery.contents = pull[temp['position']].this.find("[data-htmlgetsql-gallery]")

            # loop para duplicar os itens da galeria #
            while temp['count'][temp['position']] < (temp['return'].length-1)

                #clono htmlgetsql-gallery
                (pull[temp['position']].gallery.contents).clone().appendTo(pull[temp['position']].this)
                
                #adiciono ao final do loop
                temp['count'][temp['position']]++ 
                # fim de loop


            ## preencho os conteudos de cada galeria ##
            #redefino que count naposicao atual e um objeto
            temp['count'][temp['position']] = {}

            # define que count tem galery
            temp['count'][temp['position']]['gallery'] = 0 # acrecento em zero

            # redefino galeria todos os galery
            pull[temp['position']].gallery = {}
            pull[temp['position']].gallery = pull[temp['position']].this.find("[data-htmlgetsql-gallery]")

            # loop para gallery, selecionando cada incidente
            while temp['count'][temp['position']]['gallery'] < temp['return'].length

                # defino em this eu no momento atual
                pull[temp['position']].gallery.this = pull[temp['position']].gallery.eq(temp['count'][temp['position']]['gallery'])

                # defino em contents filhos
                pull[temp['position']].gallery.childs = {}

                # defino conteudo de filhos
                pull[temp['position']].gallery.childs.contents = pull[temp['position']].gallery.this.find("[data-htmlgetsql-context-inline]")
                pull[temp['position']].gallery.childs.count    = pull[temp['position']].gallery.childs.contents.size()
                
                # define contador em child na posição atual
                temp['count'][temp['position']]['child'] = 0


                # seleciona a partir da raiz da chamada os valores de 'context'
                if pull[temp['position']].gallery.this.data('htmlgetsql-gallery') is "all"

                    # defino os values da raiz de gallery
                    pull[temp['position']].gallery.this.values = pull[temp['position']].gallery.this.data('htmlgetsql-context-inline')

                    # repasso para a função preencher os dados
                    $.htmlGetSQL.buttress.parse_values pull[temp['position']].gallery.this, pull[temp['position']].gallery.this.values, temp['return'][temp['count'][temp['position']]['gallery']]


                # repito aplicação dos valores para
                while temp['count'][temp['position']]['child'] < pull[temp['position']].gallery.childs.count

                    # defino child em this no momento atual
                    pull[temp['position']].gallery.childs.contents[temp['count'][temp['position']]['child']].this = pull[temp['position']].gallery.childs.contents.eq(temp['count'][temp['position']]['child'])

                    # defino values de child.this
                    pull[temp['position']].gallery.childs.contents[temp['count'][temp['position']]['child']].values = pull[temp['position']].gallery.childs.contents[temp['count'][temp['position']]['child']].this.data("htmlgetsql-context-inline")

                    # repasso para a função preencher os dados
                    $.htmlGetSQL.buttress.parse_values pull[temp['position']].gallery.childs.contents[temp['count'][temp['position']]['child']].this, pull[temp['position']].gallery.childs.contents[temp['count'][temp['position']]['child']].values, temp['return'][temp['count'][temp['position']]['gallery']]

                    # acrecento no contador de filhos
                    temp['count'][temp['position']]['child']++

                # acrecento no contador de galeria
                temp['count'][temp['position']]['gallery']++
        #
        # Fim de 'quando 'pull' for do tipo 'gallery', e o tratamento for para um loop baseado na quandidade de resultados'
        # #

        temp['position']++ #adiciono ao final do loop
#
# Fim de "recebe valores do html e trata os valores e aplica tratamentos"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
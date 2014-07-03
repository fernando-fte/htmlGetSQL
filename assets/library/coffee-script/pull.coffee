# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APLICAÇÃO DE TRATAMENTO DAS SOLICITAÇÃO VIA JSON VINDA DO BANCO #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # FUNÇÕES DE APOIO # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# recebe e trata os valores de solicitação e resposta
$.parser_values_request = (me, data, val) -> #recebe função, introdução a baixo

    # subfunção de retorno de valores
    f_parser_values_request = (value) ->

        switch value.type # quando o valor
            # processa valor e preenche o local indicado
            # ou retorna o valor do local indicado

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
    # Inicia a aplição da função $.parser_values_request

    # # # # #
    # # Descreve valores recebidos em '$.parser_values_request = (me, data, val) ->'
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

        # processo os valores na subfunção 'f_parser_values_request'
        f_parser_values_request process

    # caso seja um '[object Object]'
    else # if !data or (!data+'') is '[object Object]'

        # recebe e copile os valores para a sincronia
        copile = $.extract_object_value data, {"valida":val}

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
                f_parser_values_request process

            # acrecento no loop
            count++
#
# Fim de "recebe e trata os valores de solicitação e resposta"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# extrai os valores do object
$.extract_object_value = (data, parametro) ->
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
    # # console.log $.extract_object_value {object:banco}, {"valida":key}
    # # console.log $.extract_object_value {object:banco}, {"key":key}
    # # console.log $.extract_object_value {object:banco}, {"estrutura"}
    # # console.log $.extract_object_value {object:banco}, {}
    # # # #

    # sub função para a validação do tipo de exceução
    f_excecao = (key) ->
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
            _return = f_excecao key

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
                parametro_.estrutura = parametro.estrutura+'["'+key+'"]' if parametro.estrutura # controi a arvore de acesso
                parametro_.estrutura = '["'+key+'"]' if parametro.estrutura && parametro.estrutura is 'estrutura'
                # # #

                #Retorna todos os valores a uma NOVA FUNCAO
                $.extract_object_value data, parametro_


        # quando não é mais um objeto e sim um valor
        else # (val+'') is '[object Object]'

            # cria data.return caso não exista
            data.return = [] if !data.return

            # cria objeto para retornar a estrutura
            parametro.estrutura = parametro.estrutura+'["'+key+'"]' if parametro.estrutura # constroi a arvore de acesso
            parametro.estrutura = '["'+key+'"]' if parametro.estrutura is ('estrutura["'+key+'"]') or parametro.estrutura is ''  # retorna apenas o primeiro valor

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
$.pull_values = (html) ->
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
    pull.count = html.find("[data-template]").size()

    # pega cada ocorrencia de [data-template] em loop
    while temp['position'] < pull.count

        # # # # #
        # define os parametros para o processamento dos dados

        # define em 'pull' a posição atual 
        pull[temp['position']] = {} # define template na posição atual
        pull[temp['position']].pull = {} # define template.pull na posição atual

        # defino em 'this' no momento atual o data-template
        pull[temp['position']].this = html.find("[data-template]").eq(temp['position'])

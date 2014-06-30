# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APLICAÇÃO DE TRATAMENTO DAS SOLICITAÇÃO VIA JSON VINDA DO BANCO #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# recebe e trata os valores de solicitação e resposta
$.parser_values_request = (me, data, val) -> #recebe função

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


    # # # # # # # # # # # # # # # # # # # # # # # # # #
    # INICIA A APLIÇÃO DA FUNÇÃO $.PARSER_VALUES_REQUEST
    # # # # #

    # # # # #
    # # Descreve valores recebidos em '$.parser_values_request = (me, data, val) ->'
    # me   = html na arvore down
    # data = valor unico para tipo de campo
    # val  = valor a ser acrecentado conforme "data" ou a 
    #        solicitação do reconhecimento do campo
    # 

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

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


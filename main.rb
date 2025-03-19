class ListaAfazeres 
    
    EXPRESSAO_HORARIO = /(?:as\s*)?(\d{1,2})\s*[: ]?\s*(\d{2})?\s*(?:horas?)?/
    EXPRESSAO_ACAO = /\b[A-Za-z]+(ar|er|ir|or|ur)\b/ 
    EXPRESSAO_URL = /(https?:\/\/[\w.-]+(?:\/[\w.-]*)*(?:\?[^#\s]*)?(?:#[^\s]*)?)/
    EXPRESSAO_EMAIL = /[a-z]+[a-z_\.]*[a-z]+@[a-z]+[a-z\.]*[a-z]+/

    
    def self.verificar_horario?(horario)
        if match = horario.match(EXPRESSAO_HORARIO)
            hora = match[1].to_i
            minutos = match[2] ? match[2].to_i : 0
            horario_formatado = format("%02d:%02d", hora, minutos)
            puts "Horário: #{horario_formatado}"
            true
        else
            puts "#{horario} inválido" 
            false
        end
    end
    
    def self.verificar_acao?(acao)
        if match = acao.match(EXPRESSAO_ACAO)
            puts "Ação: #{match[0]}"
            true
        else
            puts "#{acao} inválida"
            false
        end
    end
    
    def self.verificar_url?(url)
        if match = url.match(EXPRESSAO_URL)
            puts "URL: #{match[0]}"
        else
            puts "#{url} inválida"
        end
    end
    
    def self.verificar_email?(email)
        if match = email.match(EXPRESSAO_EMAIL)
            puts "Email: #{match[0]}"
        else
            puts "#{email} inválido"
        end
    end
    
    def self.regex_lista_afazeres?(lista)
        puts "Saída"
        self.verificar_horario?(lista)
        self.verificar_acao?(lista)
        self.verificar_url?(lista)
        self.verificar_email?(lista)
    end 
end

# Array para testar as funções separadamente
testes = [
    "10:30",
    "10 30",
    "10",
    "20 horas",
    "ceder",
    "caso",
    "hoje as 13",
    "#hoje",
    "Caminhar",
    "https://sp.senac.br/pag1#teste?aula=1&teste=4",
    "brukinjo@gmail.com",
    "bruna.klpinto@senacsp.edu.br",
    "julio@123"
]

# chamada do array teste para cada função separada
#testes.each { |teste| ListaAfazeres.verificar_email?(teste) }

# Entrada tipo do exercício
lista = "Hoje vou caminhar as 10. Acesse: https://sp.senac.br/pag1#teste?aula=1&teste=4 ou me contate por fulano.ciclano@gmail.com"

# Chamada da função "oficial"
ListaAfazeres.regex_lista_afazeres?(lista)


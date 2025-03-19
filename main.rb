class ListaAfazeres
  EXPRESSAO_HORARIO = /(?:(?:[àa]s|as)\s*)?(\d{1,2})\s*[: ]?\s*(\d{2})?\s*(?:horas?)?/i
  EXPRESSAO_ACAO = /\b[A-Za-z]+(ar|er|ir|or|ur)\b/i
  EXPRESSAO_URL = /(https?:\/\/[\w\-\.]+(?:\/[\w\-\.\/_]*)*(?:\?[^#\s]*)?(?:#[^\s]*)?)/i
  EXPRESSAO_EMAIL = /[a-zA-Z0-9]+[\w\-\.]*[a-zA-Z0-9]+@[a-zA-Z0-9]+[\w\-\.]*[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)+/i
  
  # Expressão para tags
  # (?<![\/:])  garante que a tag não seja precedida por "/" ou ":" para evitar capturar fragmentos de URLs (ex: https://site.com/pagina#secao)
  # "#" que indica o início de uma tag
  # ([a-zA-Z0-9_\-\.+@&!]+) captura a tag em si, composta por letras, números, sublinhados, hífens, caracteres especiais e acentuação
  # (?!\?)  garante que a tag não seja seguida por "?", evitando fragmentos de URLs com parâmetros (ex: #secao?param=valor)
  EXPRESSAO_TAG = /(?<![\/:])#([a-zA-Z0-9_\-\.+@&!áàâãéèêíìîóòôõúùûçÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛÇ]+)(?!\?)/i 
  
  # Expressão para reconhecer datas e períodos específicos

  # Primeira parte: Data escrita por extenso (exemplo: 25 de março de 2023):
  # (\d{1,2}): Captura o dia (um ou dois dígitos).
  # ([a-zA-ZçÇ]+): Captura o nome do mês (permitindo caracteres como "ç").
  # (\d{4}|\d{2})?: Captura o ano, que pode ser de 2 ou 4 dígitos (exemplo: 23 ou 2023).
  
  # Segunda parte: Formato de data numérica (exemplo: 25/03/2023):
  # (\d{1,2}): Captura o dia.
  # [\/\.-]: Captura o separador entre os números (barra, ponto ou hífen).
  # (\d{1,2}): Captura o mês.
  # (\d{4}|\d{2})?: Captura o ano, que pode ser de 2 ou 4 dígitos.
  
  # Terceira parte: Expressões relativas a datas (exemplo: "hoje", "amanhã", "semana que vem"):
  # hoje|amanhã|depois de amanhã: Captura expressões comuns para datas próximas.
  # pr[oó]xim[oa]s?\s*: Captura variações de "próximos", "próxima", com flexões.
  # (?:dias?|semanas?|m[eê]s(?:es)?|anos?|final\s*de\s*semana): Captura a unidade de tempo após as expressões anteriores (dias, semanas, meses, anos, ou final de semana).
  EXPRESSAO_DATA = /\b(?:(?:(\d{1,2})\s*(?:de\s*)?([a-zA-ZçÇ]+)(?:\s*(?:de\s*)?(\d{4}|\d{2}))?)|(?:(\d{1,2})[\/\.-](\d{1,2})(?:[\/\.-](\d{4}|\d{2}))?)|(?:(hoje|amanh[aã]|depois\s*de\s*amanh[ãa]|pr[oó]xim[oa]s?\s*(?:dias?|semanas?|m[eê]s(?:es)?|anos?|final\s*de\s*semana)|(?:esse|este|esta)\s*(?:final\s*de\s*semana|fim\s*de\s*semana)|(?:semana|m[eê]s)\s*que\s*vem)))\b/i
  
  # Mapeamento de meses 
  MESES = {
    'janeiro' => 1, 'jan' => 1,
    'fevereiro' => 2, 'fev' => 2,
    'marco' => 3, 'março' => 3, 'mar' => 3,
    'abril' => 4, 'abr' => 4,
    'maio' => 5, 'mai' => 5,
    'junho' => 6, 'jun' => 6,
    'julho' => 7, 'jul' => 7,
    'agosto' => 8, 'ago' => 8,
    'setembro' => 9, 'set' => 9,
    'outubro' => 10, 'out' => 10,
    'novembro' => 11, 'nov' => 11,
    'dezembro' => 12, 'dez' => 12
  }
  
  # Dias da semana para implementações
  DIAS_SEMANA = {
    'domingo' => 0,
    'segunda' => 1, 'segunda-feira' => 1, 'segunda feira' => 1,
    'terca' => 2, 'terça' => 2, 'terca-feira' => 2, 'terça-feira' => 2, 'terca feira' => 2, 'terça feira' => 2,
    'quarta' => 3, 'quarta-feira' => 3, 'quarta feira' => 3,
    'quinta' => 4, 'quinta-feira' => 4, 'quinta feira' => 4,
    'sexta' => 5, 'sexta-feira' => 5, 'sexta feira' => 5,
    'sabado' => 6, 'sábado' => 6
  }
  
  def self.verificar_horario?(horario)
    if match = horario.match(EXPRESSAO_HORARIO)
      hora = match[1].to_i
      minutos = match[2] ? match[2].to_i : 0
      
      # Validação básica de hora e minutos
      return false if hora > 23 || minutos > 59
      
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
      true
    else
      puts "#{url} inválida"
      false
    end
  end
  
  def self.verificar_email?(email)
    if match = email.match(EXPRESSAO_EMAIL)
      puts "Email: #{match[0]}"
      true
    else
      puts "#{email} inválido"
      false
    end
  end
  
  def self.verificar_tag?(texto)
      tags = []
      texto.scan(EXPRESSAO_TAG).each do |tag|
        # Ignora fragmentos de URLs (se estiverem após "://")
        next if texto.include?("://") && texto.match(/https?:\/\/[^\s]*##{tag[0]}/)
        tags << tag[0]
      end
      
      if tags.any?
        puts "Tags: #{tags.join(', ')}"
        true
      else
        false
      end
  end
  
  # calcular o próximo final de semana
  def self.proximo_final_de_semana(data_base)
    # Encontra o próximo sábado
    dias_ate_sabado = (6 - data_base.wday) % 7
    dias_ate_sabado = 7 if dias_ate_sabado == 0 # Se já for sábado, vai para o próximo
    data_base + dias_ate_sabado
  end
  
  # calcular este final de semana
  def self.este_final_de_semana(data_base)
    # Encontra o próximo sábado ou o sábado atual se já for final de semana
    if data_base.wday == 0 # Domingo
      return data_base - 1 # Retorna o sábado deste final de semana
    elsif data_base.wday == 6 # Sábado
      return data_base # Já é sábado
    else
      # Dias até o próximo sábado
      return data_base + (6 - data_base.wday)
    end
  end
  
  def self.verificar_data?(texto)
    require 'date'
    
    hoje = Date.today
    
    if match = texto.match(EXPRESSAO_DATA)
      data = nil
      
      # Caso 1: "28 de Fevereiro", "13 de agosto de 2021"
      if match[1] && match[2]
        dia = match[1].to_i
        mes_nome = match[2].downcase.gsub(/[ç]/, 'c')
        
        mes = nil
        mes = MESES[mes_nome] if MESES.key?(mes_nome)
        
        # Busca por início de palavra
        if mes.nil?
          MESES.each do |nome, valor|
            if mes_nome.start_with?(nome) || nome.start_with?(mes_nome)
              mes = valor
              break
            end
          end
        end
        
        if mes
          ano = match[3] ? match[3].to_i : hoje.year
          # Ajuste para anos com dois dígitos
          ano = ano < 100 ? (ano + 2000) : ano
          
          begin
            data = Date.new(ano, mes, dia)
          rescue Date::Error
            puts "Data inválida: #{dia}/#{mes}/#{ano}"
            return false
          end
        end
      
      # Caso 2: "30/01", "20/04/2022"
      elsif match[4] && match[5]
        dia = match[4].to_i
        mes = match[5].to_i
        ano = match[6] ? match[6].to_i : hoje.year
        # Ajuste para anos com dois dígitos
        ano = ano < 100 ? (ano + 2000) : ano
        
        begin
          data = Date.new(ano, mes, dia)
        rescue Date::Error
          puts "Data inválida: #{dia}/#{mes}/#{ano}"
          return false
        end
      
      # Caso 3: Expressões temporais relativas
      elsif match[7]
        expressao_tempo = match[7].downcase.gsub(/[áàãâ]/, 'a').gsub(/[éèê]/, 'e').gsub(/[íìî]/, 'i').gsub(/[óòõô]/, 'o').gsub(/[úùû]/, 'u')
        
        case expressao_tempo
        when /^hoje/
          data = hoje
        when /^amanh/
          data = hoje + 1
        when /^depois\s*de\s*amanh/
          data = hoje + 2
        when /^proxim[oa]\s*dia/
          data = hoje + 1
        when /^proxim[oa]\s*semana/
          # Próxima semana = mesmo dia da semana na próxima semana
          data = hoje + 7
        when /semana\s*que\s*vem/
          # Semana que vem = mesmo dia da semana na próxima semana
          data = hoje + 7
        when /^proxim[oa]\s*m[eê]s/
          # Próximo mês = mesmo dia no próximo mês (ajustando para o último dia se necessário)
          proximo_mes = hoje.month + 1
          proximo_ano = hoje.year
          if proximo_mes > 12
            proximo_mes = 1
            proximo_ano += 1
          end
          
          ultimo_dia_proximo_mes = Date.new(proximo_ano, proximo_mes, -1).day
          dia_proximo_mes = [hoje.day, ultimo_dia_proximo_mes].min
          
          data = Date.new(proximo_ano, proximo_mes, dia_proximo_mes)
        when /m[eê]s\s*que\s*vem/
          # Mês que vem = mesmo dia no próximo mês (ajustando para o último dia se necessário)
          proximo_mes = hoje.month + 1
          proximo_ano = hoje.year
          if proximo_mes > 12
            proximo_mes = 1
            proximo_ano += 1
          end
          
          ultimo_dia_proximo_mes = Date.new(proximo_ano, proximo_mes, -1).day
          dia_proximo_mes = [hoje.day, ultimo_dia_proximo_mes].min
          
          data = Date.new(proximo_ano, proximo_mes, dia_proximo_mes)
        when /^proxim[oa]\s*ano/
          # Próximo ano = mesmo dia e mês no próximo ano
          data = Date.new(hoje.year + 1, hoje.month, hoje.day) rescue (hoje + 365)
        when /^proxim[oa]\s*final\s*de\s*semana/, /^proxim[oa]\s*fim\s*de\s*semana/
          # Próximo final de semana = próximo sábado
          data = proximo_final_de_semana(hoje)
        when /(?:esse|este|esta)\s*(?:final\s*de\s*semana|fim\s*de\s*semana)/
          # Este final de semana = este sábado
          data = este_final_de_semana(hoje)
        end
      end
      
      if data
        data_formatada = data.strftime("%d/%m/%Y")
        puts "Data: #{data_formatada}"
        return true
      end
    end
    
    false
  end
  
  def self.regex_lista_afazeres?(lista)
    puts "Saída:"
    data_encontrada = verificar_data?(lista)
    horario_encontrado = verificar_horario?(lista)
    acao_encontrada = verificar_acao?(lista)
    url_encontrada = verificar_url?(lista)
    email_encontrado = verificar_email?(lista)
    tag_encontrada = verificar_tag?(lista)
    
    if !data_encontrada && !horario_encontrado && !acao_encontrada && 
       !tag_encontrada && !url_encontrada && !email_encontrado
      puts "Nenhuma informação relevante encontrada."
    end
  end
end

# Array para testar as funções separadamente
testes = [
  "10:30",
  "10 30",
  "às 10",
  "as 20 horas",
  "ceder",
  "agendar",
  "hoje às 13",
  "#casa",
  "#TRABALHO",
  "Caminhar",
  "https://sp.senac.br/pag1#teste?aula=1&teste=4",
  "brukinjo@gmail.com",
  "BRUNA.klpinto@senacsp.edu.br",
  "julio@123",
  "28 de Fevereiro",
  "13 de agosto de 2021",
  "30/01",
  "20-04-2022",
  "hoje",
  "amanhã",
  "amanHa",
  "depois de amanha",
  "18 agosto",
  "18 de agosto 2023",
  "mês que vem",
  "semana que vem",
  "este final de semana",
  "esse fim de semana",
  "próximo final de semana"
]

# chamada do array teste para cada função separada
#testes.each { |teste| ListaAfazeres.verificar_tag?(teste) }

# Entrada tipo do exercício
lista = "Amanhã vou caminhar as 10. Acesse: https://sp.senac.br/pag1#teste?aula=1&teste=4 ou me contate por fulano.ciclano@gmail.com, #lazer #vida"

# Chamada da função "oficial"
ListaAfazeres.regex_lista_afazeres?(lista)
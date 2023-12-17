class CNS
  class << self
    def valid?(cns)
      cns = cns.to_s.gsub(/[^0-9]/, '')
      return false if cns.length != 15

      if cns.start_with?(/[12]/)
        cns_started_with_1_or_2_valid?(cns)
      elsif cns.start_with?(/[789]/)
        cns_started_with_7_or_8_or_9_valid?(cns)
      else
        false
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def generate
      cns = 0

      while cns.size != 15
        n1 = (rand * 3 + 1).floor
        n1 = (rand * 3 + 7).floor if n1 == 3
        n2 = (rand * 99_999 + 1).floor
        n3 = (rand * 99_999 + 1).floor
        cns = n1.to_s + "0#{n2}".split('').last(5).join + "0#{n3}".split('').last(5).join

        soma = 0
        0.upto(10) do |i|
          soma += cns[i].to_i * (15 - i)
        end

        resto = soma % 11
        dv = 11 - resto
        dv = 0 if dv == 11
        if dv == 10
          soma += 2
          resto = soma % 11
          dv = 11 - resto
          cns += "001#{dv}"
        else
          cns += "000#{dv}"
        end
      end

      cns
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def cns_started_with_1_or_2_valid?(cns)
      pis = cns[0..10]
      soma = 0
      0.upto(10) do |i|
        soma += pis[i].to_i * (15 - i)
      end

      resto = soma % 11
      dv = 11 - resto
      dv = 0 if dv == 11

      if dv == 10
        soma += 2
        resto = soma % 11
        dv = 11 - resto
        resultado = "#{pis}001#{dv}"
      else
        resultado = "#{pis}000#{dv}"
      end

      cns == resultado
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def cns_started_with_7_or_8_or_9_valid?(cns)
      soma = 0
      0.upto(14) do |i|
        soma += cns[i].to_i * (15 - i)
      end
      resto = soma % 11

      resto.zero?
    end
  end
end

class CnsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]
    return if value.nil? && options[:allow_nil]

    return if value.present? && cns_valid?(value)

    record.errors.add(attribute, :invalid, message: options[:message], value:)
  end

  private

  def cns_valid?(cns)
    cns = cns.gsub(/[^0-9]/, '')
    return false if cns.length != 15

    if cns.start_with?(/[12]/)
      cns_started_with_1_or_2_valid?(cns)
    elsif cns.start_with?(/[789]/)
      cns_started_with_7_or_8_or_9_valid?(cns)
    else
      false
    end
  end

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

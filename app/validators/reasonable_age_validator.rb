class ReasonableAgeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]
    return if value.nil? && options[:allow_nil]

    default_max_age = 120

    return if value.present? && reasonable_age?(value, options[:max_age], default_max_age)

    record.errors.add(attribute, :invalid, message: options[:message], value:)
  end

  private

  def reasonable_age?(birthdate, max_age, default_max_age)
    current_age = (Date.today - birthdate).to_i / 365
    max_age ||= default_max_age
    current_age <= max_age
  end
end

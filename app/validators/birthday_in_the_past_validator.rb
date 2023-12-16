class BirthdayInThePastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]
    return if value.nil? && options[:allow_nil]

    return if value.present? && value.before?(Date.current)

    record.errors.add(attribute, :invalid, message: options[:message], value:)
  end
end

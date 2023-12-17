class Hash
  def reject_keys(*keys)
    reject { |key, _| keys.include?(key) }
  end
end

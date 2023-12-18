module MunicipesHelper
  def municipe_ativo(municipe)
    municipe.ativo? ? 'ativo' : 'inativo'
  end

  def data_nascimento(municipe)
    municipe.data_nascimento.strftime('%d/%m/%Y')
  end

  def radio_ativos_checked?(radio, param)
    radio == param || (radio == 'todos' && param.blank?)
  end
end

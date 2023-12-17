class MunicipeMailer < ApplicationMailer
  def new_registration
    @municipe = params[:municipe]
    @attributes = @municipe.attributes.reject_keys('id', 'created_at', 'updated_at')
    mail(to: @municipe.email, subject: 'Suas informações foram cadastradas')
  end

  def status_updated
    @municipe = params[:municipe]
    municipe_ativo = params[:saved_changes].last
    @action = municipe_ativo ? 'ativado' : 'desativado'
    mail(to: @municipe.email, subject: "Seu cadastro foi #{@action}")
  end
end

class MunicipeMailer < ApplicationMailer
  def new_registration
    @municipe = params[:municipe]
    @attributes = @municipe.attributes.reject_keys('id', 'created_at', 'updated_at')
    mail(to: @municipe.email, subject: 'Suas informações foram cadastradas')
  end

  def registration_updated
    @municipe = params[:municipe]
    @changes = params[:saved_changes].reject_keys('id', 'created_at', 'updated_at')
    @attributes = @municipe.attributes.reject_keys('id', 'created_at', 'updated_at')
    mail(to: @municipe.email, subject: 'Suas informações foram atualizadas')
  end
end

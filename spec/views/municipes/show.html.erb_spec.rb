require 'rails_helper'

RSpec.describe 'municipes/show', type: :view do
  before(:each) do
    assign(:municipe, create(:municipe))
  end

  xit 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Cpf/)
    expect(rendered).to match(/Cns/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Telefone/)
    expect(rendered).to match(/false/)
  end
end

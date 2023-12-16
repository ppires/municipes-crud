require 'rails_helper'

RSpec.describe 'municipes/index', type: :view do
  before(:each) do
    assign(:municipes, create_list(:municipe, 2))
  end

  xit 'renders a list of municipes' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Nome'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Cpf'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Cns'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Email'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Telefone'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end

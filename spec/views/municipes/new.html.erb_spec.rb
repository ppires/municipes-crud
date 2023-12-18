require 'rails_helper'

RSpec.describe 'municipes/new', type: :view do
  before(:each) do
    assign(:municipe, build(:municipe))
  end

  it 'renders new municipe form' do
    render

    assert_select 'form[action=?][method=?]', municipes_path, 'post' do
      assert_select 'input[name=?]', 'municipe[nome]'

      assert_select 'input[name=?]', 'municipe[cpf]'

      assert_select 'input[name=?]', 'municipe[cns]'

      assert_select 'input[name=?]', 'municipe[email]'

      assert_select 'input[name=?]', 'municipe[telefone]'

      assert_select 'input[name=?]', 'municipe[ativo]'
    end
  end
end

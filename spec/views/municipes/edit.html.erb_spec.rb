require 'rails_helper'

RSpec.describe 'municipes/edit', type: :view do
  let(:municipe) do
    create(:municipe)
  end

  before(:each) do
    assign(:municipe, municipe)
  end

  it 'renders the edit municipe form' do
    render

    assert_select 'form[action=?][method=?]', municipe_path(municipe), 'post' do
      assert_select 'input[name=?]', 'municipe[nome]'

      assert_select 'input[name=?]', 'municipe[cpf]'

      assert_select 'input[name=?]', 'municipe[cns]'

      assert_select 'input[name=?]', 'municipe[email]'

      assert_select 'input[name=?]', 'municipe[telefone]'

      assert_select 'input[name=?]', 'municipe[ativo]'
    end
  end
end

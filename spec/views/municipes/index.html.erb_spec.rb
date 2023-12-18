require 'rails_helper'

RSpec.describe 'municipes/index', type: :view do
  before(:each) do
    create_list(:municipe, 2)
    assign(:municipes, Municipe.unscoped.page(1))
  end

  it 'renders a list of municipes' do
    render
    assert_select 'tbody>tr' do |rows|
      rows.each do |_tr|
        assert_select 'td', 10 * 2
      end
    end
  end
end

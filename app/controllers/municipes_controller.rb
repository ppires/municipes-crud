class MunicipesController < ApplicationController
  before_action :set_municipe, only: [:edit, :update]

  # GET /municipes or /municipes.json
  def index
    @municipes = Municipe.search(params[:query]).with_attached_foto
  end

  # GET /municipes/new
  def new
    @municipe = Municipe.new
    @municipe.build_endereco
    # @municipe = FactoryBot.build(:municipe)
  end

  # GET /municipes/1/edit
  def edit; end

  # POST /municipes or /municipes.json
  def create
    @municipe = Municipe.new(municipe_params)

    respond_to do |format|
      if @municipe.save
        format.html { redirect_to municipes_url, notice: 'Munícipe cadastrado com sucesso' }
        format.json { render :show, status: :created, location: @municipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipes/1 or /municipes/1.json
  def update
    respond_to do |format|
      if @municipe.update(municipe_params)
        format.html { redirect_to municipes_url, notice: 'Munícipe atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @municipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def municipe_params
    params.require(:municipe).permit(:nome, :cpf, :cns, :email, :data_nascimento, :telefone, :ativo, :foto,
                                     endereco_attributes: [:cep, :logradouro, :numero, :complemento, :bairro, :cidade,
                                                           :uf, :codigo_ibge])
  end
end

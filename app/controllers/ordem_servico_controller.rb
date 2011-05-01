class OrdemServicoController < ApplicationController

  def search
    @equipamentos = TipoEquipamento.all
  end

  def search_do
    @ordem_servicos = OrdemServico.search(params)
    render :action => 'index'
  end

  def index
    @ordem_servicos = OrdemServico.all
  end

  def new
    @equipamentos = TipoEquipamento.all
    @ordem_servico = OrdemServico.new
    if params[:cliente_id]
      cliente = Cliente.find(params[:cliente_id])
        @cliente = [ [ cliente.nome, cliente.id ] ]
      else
        @clientes = Cliente.all.map do |cliente|
          cliente = [ cliente.nome, cliente.id ]
        end

       @equipamentos = TipoEquipamento.all do |equipamento|
          equipamento = [equipamento.nome, equipamento.id]
        end

      end
    end

    def show
      @ordem_servico = OrdemServico.find(params[:id])
    end

  def create
    @ordem_servico = OrdemServico.new(params[:ordem_servico])

    if @ordem_servico.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def edit
    @ordem_servico = OrdemServico.find(params[:id])
    @tipo_equipamento = [ @ordem_servico.tipo_equipamento ]
    @cliente = [ [ @ordem_servico.cliente.nome, @ordem_servico.cliente.id ]]
  end

  def update
    @ordem_servico = OrdemServico.find(params[:id])
    if @ordem_servico.update_attributes(params[:ordem_servico])
      redirect_to :action => 'index'
    else
      flash[:error] = 'Houve algum erro no atualização dos campos'
      redirect_to :action => 'edit'
    end
  end

end


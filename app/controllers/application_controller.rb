class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter {|controller| autorizacao(controller)}

  layout :logged_layout


  ACTIONS = {"index" => :consulta, "show" => :consulta, "update" => :editar, "edit" => :editar, "destroy" => :apagar, "new" => :criar , 'search' => :consulta,"create" => :criar,  'search_do' => :consulta, 'tipo_pedido' => :consulta, 'tipo_situacao' => :consulta, 'tipo_equipamento' => :consulta, 'intervalo_valor_servico' => :consulta}
  CONTROLLERS = {"users" => "usuarios", "group" => "grupos", "clientes" => "clientes", "ordem_servico" => "ordem_servico", "tipo_equipamento" => "equipamentos", "relatorios" => "relatorios" }

  def logged_layout
    user_signed_in? ? "application" : "login"
  end

  def autorizacao(controller)
    ctrl = controller.params['controller']
    acti = controller.params['action']
    return true if [ 'home', 'devise/sessions' ].include? ctrl
    logger.info [ controller.params, CONTROLLERS[ctrl], ACTIONS[acti] ].inspect
    perms = current_user.group.send("privilegio_#{CONTROLLERS[ctrl]}".to_sym)
    unless perms.include? ACTIONS[acti]
      flash[:notice] = "Você não tem permissão para #{ACTIONS[acti]} #{CONTROLLERS[ctrl]}"
      redirect_to :action => "index", :controller => "home"
    end
  end

end

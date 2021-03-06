class AddGroupAdminAndRelatesAdminUser < ActiveRecord::Migration
  def self.up
    g = Group.new(:name => 'Administradores', :grupo_privileges => 15, :usuario_privileges => 15, :cliente_privileges => 15, :ordem_servico_privileges => 15, :equipamento_privileges => 15, :relatorios_privileges => 15)
    g.save
    u = User.find(1)
    u.update_attributes(:group => g, :password=> '123456', :password_confirmation => '123456')
  end

  def self.down
    Group.delete(Group.find_by_name('Administradores').id)
    u = User.find_by_email 'admin@admin.com.br'
    u.group = nil
    u.save
  end
end

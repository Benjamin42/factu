class CommandeService < ActiveRecord::Base
  belongs_to :commande
  belongs_to :bdl
  belongs_to :service
  
  def self.create_with_service(commande, bdl, service)
    commandeService = CommandeService.new()
    commandeService.attributes = {
      :commande => commande,
      :bdl => bdl,
      :service => service,
      :montant => 0
    }
    return commandeService
  end  
end

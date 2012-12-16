class Service < ActiveRecord::Base
  def countRef
    CommandeService.find(:all, :conditions => ["service_id = ? and montant > 0", id]).size
  end
end

class Service < ActiveRecord::Base
  def countRef
    CommandeService.find(:all, :conditions => ["service_id = ?", id]).size
  end
end

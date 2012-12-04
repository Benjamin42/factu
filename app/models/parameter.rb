class Parameter < ActiveRecord::Base
  validates_presence_of :p_name
  validates_presence_of :p_value
  validates_presence_of :grp
  
  def self.findByName(name)
    return Parameter.find(:first, :conditions => ['p_name = ?', name])
  end
end

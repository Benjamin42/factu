class Parameter < ActiveRecord::Base
  validates_presence_of :p_name
  validates_presence_of :p_value
  validates_presence_of :grp
  
  def self.findByName(name)
    p = Parameter.find(:first, :conditions => ['p_name = ?', name])
    res = ""
    if p != nil
      res = p.p_value
    end
    return res  
  end
end

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
  
  def self.findByGrp(grp)
    Parameter.find(:all, :conditions => ['grp = ?', grp])
  end
  
  def self.distinctGrp
    find_by_sql("select distinct grp from parameters order by grp")
  end
end

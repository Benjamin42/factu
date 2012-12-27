# -*- coding: utf-8 -*-
class CleaningVille < ActiveRecord::Base
  
  def self.build_from_csv(row)
    # find existing customer from email or create new
    ville = find_or_initialize_by_nom(row[1])
    ville.attributes = {
      :id => self.clean(row[0]),
      :nom => self.clean(row[1]),
      :nom_majuscule => self.clean(row[2]),
      :code_postal => self.clean(row[3]),
      :code_insee => self.clean(row[4]),
      :code_region => self.clean(row[5]),
      :latitude => self.clean(row[6]),
      :longitude => self.clean(row[7]),
      :eloignement => self.clean(row[8])
    }
    return ville
  end
  
  def self.clean(str)
    if str != nil
      return str.unpack('U*').pack('U*')
    end
    return str
  end  
  
  def self.findCodePostal(ville, codepostal)
    tabCp = find_by_sql("select code_postal from cleaning_villes where nom_majuscule like '%#{ ville }%' and code_postal like '#{ codepostal }%'").first
    if !tabCp.nil?
      return tabCp.code_postal
    end
    return codepostal
  end
end

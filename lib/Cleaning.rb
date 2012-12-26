module Cleaning
  
  def clean(client)
    
    cleanCivilite(client)
    
    cleanNumVoie(client)
    cleanVille(client)
    cleanPays(client)
    cleanTel(client)
    cleanPortable(client)
    cleanFax(client)
    cleanEmail(client)
  end
  
  def cleanCivilite(client)
    if client.civilite_id == nil
      if client.nom.match(/^M (.*)$/)
        # civilité => Monsieur
        client.civilite_id = Type.findAllWithGroupeAndCode("civilite", "Mr").id
        client.nom = client.nom.scan(/^M (.*)$/)[0][0]
        
      elsif client.nom.match(/^MME .*$/)
        # civilité => Madame
        client.civilite_id = Type.findAllWithGroupeAndCode("civilite", "Mme").id
        client.nom = client.nom.scan(/^MME (.*)$/)[0][0]
        
      elsif client.nom.match(/^MLLE .*$/)
          # civilité => Mademoiselle
          client.civilite_id = Type.findAllWithGroupeAndCode("civilite", "Mlle").id
          client.nom = client.nom.scan(/^MLLE (.*)$/)[0][0]
          
      end
      
    end
  end
  
  def cleanNumVoie(client)
    if client.num_voie != nil
      client.num_voie = majuscule(client.num_voie.gsub(/(\d+)/) { "#{$1} " })
    end
  end
  
  def cleanVille(client)
    if client.ville != nil
      resultScan = client.ville.scan(/^([0-9 ]*)(.*)$/)
      if resultScan != nil && resultScan[0][0] != nil
        client.codepostal = resultScan[0][0].gsub(" ", "")
      end
      if resultScan != nil && resultScan[0][1] != nil
        client.ville = resultScan[0][1]
      end
      
    end
    client.ville = majuscule(client.ville)
  end
  
  def cleanPays(client)
    if client.pays == nil
      client.pays = "France"
    end
  end
  
  def cleanTel(client)
    client.tel = cleanPhoneNumber(client, client.tel)
  end
  
  def cleanPortable(client)
    client.portable = cleanPhoneNumber(client, client.portable)
  end  
  
  def cleanFax(client)
    client.fax = cleanPhoneNumber(client, client.fax)
  end    
  
  def cleanPhoneNumber(client, number)
    if number != nil && (client.pays == nil || client.pays == "France")
      number = number.gsub(" ", "")
      if number.size < 10
        number = "0#{number}"
      end
      
      number = number.gsub(/(\d{2})/) { "#{$1} " }
    end    
    
    return number
  end
  
  def cleanEmail(client)
    if client.email != nil
      client.email = client.email.gsub(",", ".")
    end
  end
  
  def majuscule(text)
    return text.split(" ").map {|w| w.capitalize}.join(" ")
  end
end

module Cleaning
  
  def clean(client)
    
    cleanCivilite(client)
    cleanPrenom(client)
    cleanNumVoie(client)
    cleanVille(client)
    cleanTel(client)
    cleanPortable(client)
    cleanFax(client)
    cleanEmail(client)
    
    # Laisser en dernier
    cleanPays(client)
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
  
  def cleanPrenom(client)
    d = SexMachine::Detector.new(:case_sensitive => false)
    tokeniser = client.nom.gsub(/[,\.]/, "").split(" ")
    client.prenom = ""
    client.nom = ""
    tokeniser.each do |w|
      if w.length > 2
        if d.get_gender(w) == :andy
          client.nom = "#{client.nom}#{ if client.nom == "" then "" else " " end }#{ w.upcase }"
        else
          if client.prenom != ""
            concat = "#{ client.prenom}-#{ majuscule(w) }"
            genderConcat = d.get_gender(concat)
            if genderConcat != :andy
              client.prenom = concat
              if genderConcat == :male && client.civilite_id.nil?
                client.civilite_id = Type.findAllWithGroupeAndCode("civilite", "Mr").id
              end
            else
              client.prenom = "#{ client.prenom} et #{ majuscule(w) }"
            end
          else
            client.prenom = majuscule(w)
          end
          
          #client.prenom = "#{client.prenom}#{ if client.prenom == "" then "" else " " end }#{ majuscule(w) }"
        end
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


    client.codepostal = CleaningVille.findCodePostal(client.ville, client.codepostal) 
  end
  
  def cleanPays(client)
    if client.pays == nil || client.pays == ""
      client.pays = CleaningPay.findByCode(Parameter.findByName("code_pays_defaut"))
    else
      client.pays = CleaningPay.findByNom(client.pays)
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
    if number != nil
      number = number.gsub(" ", "")

        if number != "" && (client.pays == nil || client.pays == "")
        number = number.gsub(" ", "")
        while number.size < 10
          number = "0#{number}"
        end
        
        number = number.gsub(/(\d{2})/) { "#{$1} " }
      end
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

class Commande < ActiveRecord::Base
  has_many :commande_produit
  belongs_to :client

  validates_presence_of :client
  def self.next_num_factu
    resReq = find_by_sql("select max(num_factu) + 1 as num_factu from commandes").first.num_factu
    if resReq != nil && resReq != "" then
    return resReq
    else
    return 0
    end
  end

  def commande_produit_attributes=(commande_produit_attributes)
    commande_produit_attributes.each do |id,attributes|
      commandeProduit = CommandeProduit.find(id)
      if commandeProduit == nil
        commandeProduit = commande_produit.build(attributes)
      end
      commandeProduit.attributes = {
        :qty => attributes[:qty],
        :qty_cadeau => attributes[:qty_cadeau],
        :produit => Produit.find(attributes[:produit_id])
      }
      commandeProduit.save
    end
  end

  def qtyTotal
    count = 0
    self.commande_produit.all.each do |commandeProduit|
      if commandeProduit.qty != nil
      count += commandeProduit.qty
      end
    end

    return count
  end

  def self.build_from_csv(row)
    # find existing customer from email or create new
    commande = nil
    client = Client.find(:all, :conditions => ['num_client = ?', row[3]]).first
    if client != nil
      commande = find_or_initialize_by_num_factu(row[0])
      commande.attributes = {
        :num_factu => row[0],
        #:bdl_id => row[1], # TODO
        :client_id => client.id,
        :date_factu => Date.strptime(row[4], '%d/%m/%y'),
        :nb_etiquette => row[21],
        :statut => "" #row[0] # TODO
      }
    end
    return commande
  end
end

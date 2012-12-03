class FinDeMois
  attr_reader :dater, :num_bdl, :num_factu, :hashProduit
  
  def initialize(num_bdl, num_factu, dater)
    @num_bdl = num_bdl
    @num_factu = num_factu
    @dater = dater
    @hashProduit = Hash.new
  end
  
  
  def addProduit(label, qty, qty_cadeau)
    @hashProduit[label] = (qty != nil ? qty : 0) + (qty_cadeau != nil ? qty_cadeau : 0)
  end
end
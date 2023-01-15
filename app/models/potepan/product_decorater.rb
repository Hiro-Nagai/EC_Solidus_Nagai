module Potepan::ProductDecorator
    def ralated_products
        Spree::Product.in_taxons(taxons).includes(master: [:images, :default_price]).where.not(id: id).order("RAND()").distinct
    end

        Spree::Product.prepend self
end

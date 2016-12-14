class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!



  def exist_product(product)
    Product.exists?(:client_id => product, :site_id => session[:site])
  end


  def add_product_to_bdd(name,
                        photo,
                        client_id,
                        ean,
                        short_description,
                        long_description,
                        brand,
                        reference,
                        supplier_reference,
                        available,
                        category_default,
                        site)
    p = Product.new
    p.title = name
    p.photo = photo
    p.client_id = client_id
    p.ean = ean
    p.short_description = short_description
    p.long_description = long_description
    p.brand = brand
    p.reference = reference
    p.supplier_reference = supplier_reference
    p.available = available
    p.defaut_categorie = category_default
    p.site_id = site
    p.save
  end


  def exist_category(private_category)
    Categorie.exists?(:private_id => private_category, :site_id => session[:site])
  end

  def get_category_id_by_private_id(id)
    categorie_id = Categorie.find_by(private_id: id)
    return categorie_id.id
  end

  def add_categorie(category_name, private_id, site)
    c = Categorie.new
    c.name = category_name
    c.private_id = private_id
    c.site_id = site
    c.save
  end

end

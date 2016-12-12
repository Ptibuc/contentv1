class PrestashopController < ApplicationController

  require 'json'
  require 'httparty'

  WEB_SERVICE_KEY = 'XV5S4JTRIH8JEEDUSVWNSQZT9EWGIWUF'
  SITE_URL= 'http://www.balluchon.fr'

  def index

    # récupération de toutes les catégories
    response = get_categories
    @categories = response['prestashop']['categories']['category']

    # on boucle sur les catégories pour ajouter les nouvelles trouvées
    @categories.each do |category|
      # si la catégorie n'existe pas encore
      if !exist_category(category['id'])
        # on récupère le nom de la catégorie
        category_name = get_category_name(category['id'])
        # on l'ajoute à la base
        c = Categorie.new
        c.name = category_name
        c.private_id = category['id']
        c.site_id = session[:site]
        c.save
      end
    end

    response = get_category(175)
    @category = response['prestashop']['category']

    @qte_new_product = 0

    # récupération de la liste des produits
    response = get_products
    @products = response['prestashop']['products']

    # pour chaque produit récupéré
    @products['product'].each do |product|
      #on regarde si le produit existe
      if !exist_product(product['id'])

        # il n'existe pas, on récupère les informations pour cet ID
        response = get_product(product['id'])
        product_infos = response['prestashop']['product']

        # on l'ajoute à la BDD
        add_product_to_bdd(
                product_infos['name']['language']['__content__'],
                product_infos['id_default_image']['__content__'],
                product_infos['id'],
                product_infos['ean13'],
                product_infos['description_short']['language']['__content__'],
                product_infos['description']['language']['__content__']
                )


      end
    end

    response = get_product(127)
    @produit = response['prestashop']['product']
    url_photo = response['prestashop']['product']['id_default_image']['__content__']


#
#    @affich = "<ul>";
#    products['product'].each do |product|
#      response = get_product(product)
#      @affich &= "<li>#{product}</li>"
#    end
#    @affich &= "</ul>"

  end

private

  def exist_product(product)
    Product.exists?(:client_id => product, :site_id => session[:site])
  end

  def exist_category(private_category)
    Categorie.exists?(:private_id => private_category, :site_id => session[:site])
  end

  def add_product_to_bdd(langage,
                        photo,
                        client_id,
                        ean,
                        short_description,
                        long_description)
    p = Product.new
    p.title = product_infos['name']['language']['__content__']
    p.photo = product_infos['id_default_image']['__content__']
    p.client_id = product_infos['id']
    p.ean = product_infos['ean13']
    p.short_description = product_infos['description_short']['language']['__content__']
    p.long_description = product_infos['description']['language']['__content__']
    p.site_id = session[:site]
    p.save
  end

  def get_products
    HTTParty.get "#{SITE_URL}/api/products?limit=120", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_product(product)
    HTTParty.get "#{SITE_URL}/api/products/#{product}", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_product_photo(product_image_path)
    HTTParty.get "#{product_image_path}", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_categories
    HTTParty.get "#{SITE_URL}/api/categories", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_category(category)
    HTTParty.get "#{SITE_URL}/api/categories/#{category}", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_category_name(category)
    response = get_category(category)
    return response['prestashop']['category']['name']['language']['__content__']
  end

end

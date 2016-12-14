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
        add_categorie(
          category_name,
          category['id'],
          session[:site])
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

        # on récupère l'ID de la base de la catégorie par défaut
        @category_default = get_category_id_by_private_id(product_infos['id_category_default']['__content__'])

        # on l'ajoute à la BDD
        add_product_to_bdd(
                product_infos['name']['language']['__content__'],
                product_infos['id_default_image']['__content__'],
                product_infos['id'],
                product_infos['ean13'],
                product_infos['description_short']['language']['__content__'],
                product_infos['description']['language']['__content__'],
                product_infos['manufacturer_name']['__content__'],
                product_infos['reference'],
                product_infos['supplier_reference'],
                product_infos['active'],
                @category_default,
                session[:site]
                )


      end
    end

    response = get_product(127)
    @produit = response['prestashop']['product']
    url_photo = response['prestashop']['product']['id_default_image']['__content__']

  end

private

  def get_products
    HTTParty.get "#{SITE_URL}/api/products?limit=20", basic_auth: {username: WEB_SERVICE_KEY }
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

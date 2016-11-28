class PrestashopController < ApplicationController

  require 'json'
  require 'httparty'

  WEB_SERVICE_KEY = 'XV5S4JTRIH8JEEDUSVWNSQZT9EWGIWUF'
  SITE_URL= 'http://www.balluchon.fr'

  def index

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
        p = Product.new
        p.title = product_infos['name']['language']['__content__']
        p.photo = product_infos['id']
        p.client_id = product_infos['id']
        p.ean = product_infos['ean13']
        p.short_description = product_infos['description_short']['language']['__content__']
        p.long_description = product_infos['description']['language']['__content__']
        p.save

      end
    end

    response = get_product(127)
    @produit = response['prestashop']['product']

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

  def get_products
    HTTParty.get "#{SITE_URL}/api/products", basic_auth: {username: WEB_SERVICE_KEY }
  end

  def get_product(product)
    HTTParty.get "#{SITE_URL}/api/products/#{product}", basic_auth: {username: WEB_SERVICE_KEY }
  end

end

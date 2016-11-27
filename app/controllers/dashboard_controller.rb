class DashboardController < ApplicationController
  def index
    if !session[:site] && current_user.sites.count==1
      site = Site.find_by user_id: current_user.id
      assign_site_to_session(site.id)
    end
  end

  def select_site
    # passer en session la valeur du site sélectionné
    assign_site_to_session(params[:site])
  end

  def change_site
    session[:site] = nil
    redirect_to dashboard_path
  end

  private

  def assign_site_to_session(site)
    if Site.exists?(site) && Site.find(site).user_id==current_user.id
      session[:site] = site
      redirect_to dashboard_path, notice: "Site sélectionné"
    else
      redirect_to dashboard_path, alert: "Erreur, impossible de sélectionner ce site. Vérifiez qu'il est bien à vous ou qu'il existe."
    end
  end

end

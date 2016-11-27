class DashboardController < ApplicationController
  def index
  end

  def select_site
    # passer en session la valeur du site sélectionné
    if Site.exists?(params[:site]) && Site.find(params[:site]).user_id==current_user.id
      session[:site] = params[:site]
      redirect_to dashboard_path, notice: "Site sélectionné"
    else
      redirect_to dashboard_path, alert: "Erreur, impossible de sélectionner ce site. Vérifiez qu'il est bien à vous ou qu'il existe."
    end

  end

  def change_site
    session[:site] = nil
    redirect_to dashboard_path
  end

end

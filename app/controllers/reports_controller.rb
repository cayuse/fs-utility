class ReportsController < ApplicationController
    def index
    end

  def dispatch
    unless params[:month]
      flash[:error] = 'You must select a Month.'
      return redirect_to(reports_url)
    end

    case params[:submit]

    when "By Site for Month"
      1
    when "Combined for Month"
      1
    else
    redirect_to(reports_url)
    end
  end 
end

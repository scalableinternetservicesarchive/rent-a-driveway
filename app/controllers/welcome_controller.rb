class WelcomeController < ApplicationController
    def new

    end

    def index
        print params[:parameters]
    end

    def search_location
        print params 
        print params[:location]
        print params[:start_time]
        print params[:end_time]
        render "welcome/index"
    end
end

class WelcomeController < ApplicationController
    def new

    end

    def index
        print params[:parameters]
    end

    def search_listings
        print "--------------------------------------------------"
        print params 
        print "--------------------------------------------------"
        print params[:longitude]
        print params[:latitude]
        newArray = []
        for i in 0..10
            newArray[i] = Hash("longitude" => params[:longitude].to_f + (Random.rand(0..100000) - 50000) * 0.0000001, "latitude" => params[:latitude].to_f + (Random.rand(0..100000) - 50000) * 0.0000001)
        end
        render json: newArray 
    end
end

require 'net/https'

class PostulacionesController < ApplicationController

    def findByEmail
        email = params[:email]
        uri = URI('https://api.workon.law/technical_challenge/get_lawyers')
        res = Net::HTTP.get(uri)
        can = JSON.parse(res)
        works = can["candidates"].select{|c| c["email"] == email}
        if works.length==0
            return render json: {"email" => nil , "work_experience_years" => nil}
        end
        works = works.first["works"]
        arr = (Date.parse("2000-01-01")..Date.today).to_a
        count = 0.0
        arr.each do |d|
            works.each do |lim|
            limSup = (lim["end"]==nil)?true:d<=Date.parse(lim["end"])
            if Date.parse(lim["start"])<d and limSup
                count+=1.0
                break
            end
          end
        end
        render json: {"email" => email , "work_experience_years" => (count / 365.0).round(1)}
    end

end
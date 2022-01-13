require "test_helper"

class PostulacionesControllerTest < ActionDispatch::IntegrationTest
    test "Verificar experiencia de nikola@tesla.org" do
        get "/postulaciones?email=nikola@tesla.org"
        res = JSON.parse(@response.body)
        diff = (Date.today - Date.parse("2020-03-15")).to_i
        antiquity = (( 584.0 + diff.to_d) / 365.0).round(1)
        assert_equal antiquity, res["work_experience_years"].to_d
    end

    test "Verificar experiencia de jane@goodall.org" do
        get "/postulaciones?email=jane@goodall.org"
        res = JSON.parse(@response.body)
        diff = (Date.today - Date.parse("2007-04-27")).to_i
        antiquity = (diff.to_d / 365.0).to_d.round(1)
        assert_equal 14.7, res["work_experience_years"].to_d
    end

    test "Verificar experiencia de isaac@asimov.org" do
        get "/postulaciones?email=isaac@asimov.org"
        res = JSON.parse(@response.body)
        assert_equal 0.0, res["work_experience_years"].to_d
    end

    test "Verificar experiencia de usuario inexistente" do
        get "/postulaciones?email=asdf"
        res = JSON.parse(@response.body)
        assert_equal nil, res["work_experience_years"]
    end
      
end

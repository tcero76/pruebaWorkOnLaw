require "test_helper"

class PostulacionesControllerTest < ActionDispatch::IntegrationTest
    test "Verificar experiencia de nikola@tesla.org" do
        get "/postulaciones?email=nikola@tesla.org"
        years = JSON.parse(@response.body)
        diff = (Date.today - Date.parse("2020-03-15")).to_i
        antiquity = (( 584.0 + diff) / 365).to_d.round(1)
        assert_equal antiquity, years["work_experience_years"].to_d
    end

    test "Verificar experiencia de jane@goodall.org" do
        get "/postulaciones?email=jane@goodall.org"
        years = JSON.parse(@response.body)
        assert_equal 14.7, years["work_experience_years"].to_d
    end

    test "Verificar experiencia de isaac@asimov.org" do
        get "/postulaciones?email=isaac@asimov.org"
        years = JSON.parse(@response.body)
        assert_equal 0.0, years["work_experience_years"].to_d
    end
      
end

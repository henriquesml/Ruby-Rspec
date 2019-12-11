require 'rails_helper'

RSpec.describe "Weapons", type: :request do
    describe "GET /weapons" do
        context "Index action" do
            it "Returns success status" do
                get weapons_path        
                expect(response).to have_http_status(200)
            end
            it "The Weapons's title and current power is present" do
                weapons = create_list(:weapon, 3)
                get weapons_path
           
                weapons.each do |weapon|
                    # Title, Current Power and /weapon:id link
                    expect(response.body).to include(weapon.title , weapon.current_power , weapons_path(weapon.id))
                end
            end
        end

        context "Show action" do
            it "Returns success status" do
                weapon = create(:weapon)
               
                get "/weapons/#{weapon.id}"      
                expect(response).to have_http_status(200)

            end
            it "The Weapons's title and current power is present" do
                weapon = create(:weapon)
               
                get "/weapons/#{weapon.id}"
                expect(response.body).to include(weapon.title, weapon.description, weapon.current_power, weapon.power_step.to_s, weapon.power_base.to_s, weapons_path, 'data-method="delete"', weapons_path(weapon.id))
               
            end  
            
        end
    end

    describe "POST /weapons" do
        context "When it has valid parameters" do
            it "Creates the weapon with correct attributes" do
                weapon_attributes = FactoryBot.attributes_for(:weapon)
                post weapons_path, params: { weapon: weapon_attributes }
                expect(Weapon.last).to have_attributes(weapon_attributes)
            end
        end

        context "When it has no valid parameters" do
            it "Does not create weapon" do
                expect{
                    post weapons_path, params: { weapon: { name: '', description: '', power_base: '', power_step: '', level: '' } }
                }.to_not change(Weapon, :count)
            end
        end
    end

    describe "DELETE /weapons" do
   
        it "Delete weapon" do
            weapon = create(:weapon)
    
            delete "/weapons/#{weapon.id}"
            expect{Weapon.find(weapon.id)}.to raise_error("Couldn't find Weapon with 'id'=#{weapon.id}")
           
        end
       
    end
end
require 'rails_helper'

RSpec.describe "Enemies", type: :request do

  describe "GET /enemies Create" do
    context "When the enemy exists" do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }

      before(:each) { post "/enemies", params: enemy_attributes }

      it 'Return status code 200 Index' do
       
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "GET /enemies Index" do
    context "When the enemy exists" do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }

      before(:each) { post "/enemies", params: enemy_attributes }

      it 'Return status code 200 Index' do
       
        get "/enemies"

        expect(response).to have_http_status(200)
      end

      it 'Return enemies Index' do

        get "/enemies"

        expect(response.body).to include(enemy_attributes[:name], enemy_attributes[:power_base].to_s, enemy_attributes[:power_step].to_s, enemy_attributes[:level].to_s, enemy_attributes[:kind])
      end

      it 'Return enemies Show' do

        get "/enemies#{enemy_attributes[:id]}"
        
        expect(response.body).to include(enemy_attributes[:name], enemy_attributes[:power_base].to_s, enemy_attributes[:power_step].to_s, enemy_attributes[:level].to_s, enemy_attributes[:kind])
      end
    end

    context "When the enemy does not exists Index" do
      before(:each) { get '/enemies', params: attributes_for(:enemy) } 

      it 'Returns status code 200' do
    
        expect(response).to have_http_status(200)
      end
      it 'Returns a not found message' do

        expect(response.body).to match(/No enemies found/)
      end

      it 'Return enemies Show' do

        get "/enemies/0"
        
        expect(response.body).to match(/Couldn't find Enemy with 'id'=0/)
      end
    end
  end

  describe "PUT /enemies" do
    context "When the enemy exists" do

      # Criando enemy e enemy_attributes para reutilização no contexto
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }

      before(:each) { put "/enemies/#{enemy.id}", params: enemy_attributes }

      it 'Return status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'Update the enemy' do

        expect(enemy.reload).to have_attributes(enemy_attributes)

      end
      it 'Returns the enemy updated' do

        # Using json helper for remove 'created_at' and 'updated_at'
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end

    context "When the enemy does not exists" do
      before(:each) { put '/enemies/0', params: attributes_for(:enemy) } 

      it 'Returns status code 404' do

        expect(response).to have_http_status(404)
      end
      it 'Returns a not found message' do

        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "DELETE /enemies" do
    context "When the enemy exists" do
      let(:enemy) { create(:enemy) }
      before(:each) { delete "/enemies/#{enemy.id}" }

      it 'Return status code 204' do

        expect(response).to have_http_status(204)
      end
      it 'Destroy the enemy' do

        expect{ enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "When the enemy does not exists" do
      before(:each) { delete '/enemies/0' }

      it 'Return status code 404' do
       
        expect(response).to have_http_status(404)
      end
      it 'Returns a not found message' do

        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

end

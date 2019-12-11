require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "PUT /enemies" do
    describe "When the enemy exists" do
      it 'Return status code 200' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes

        expect(response).to have_http_status(200)
      end
      it 'Update the enemy' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes

        expect(enemy.reload).to have_attributes(enemy_attributes)

      end
      it 'Returns the enemy updated' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes

        json_response = JSON.parse(response.body)
        expect(enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at'))
      end
    end

    describe "When the enemy does not exists" do
      it 'Returns status code 404' do
        enemy_attributes = attributes_for(:enemy)
        put '/enemies/0', params: enemy_attributes

        expect(response).to have_http_status(404)
      end
      it 'Returns a not found message' do
        enemy_attributes = attributes_for(:enemy)
        put '/enemies/0', params: enemy_attributes

        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "DELETE /enemies" do
    describe "When the enemy exists" do
      it 'Return status code 204' do
          enemy = create(:enemy)
          delete "/enemies/#{enemy.id}"

          expect(response).to have_http_status(204)
      end
      it 'Destroy the enemy' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"

        expect{ enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    describe "When the enemy does not exists" do
      it 'Return status code 404' do
        delete '/enemies/0'

        expect(response).to have_http_status(404)
      end
      it 'Returns a not found message' do
        delete '/enemies/0'

        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

end

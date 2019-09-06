require 'rails_helper'

RSpec.describe FlipsController, type: :controller do 
  describe "GET #index" do 
    it "renders the flips index" do
      get :index 
      expect(response).to render_template(:index)
    end
  end 

  describe "GET #show" do 
    it "renders the show page for a flip" do
      create(:flip)
      get :show, params: { id: Flip.last }
      expect(response).to render_template(:show)
    end
  end 

  describe "GET #new" do 
    it "brings up the form to create a new flip" do
      allow(subject).to receive(:logged_in?).and_return(true)

      get :new
      expect(response).to render_template(:new)
    end 
  end 

  describe "DELETE #destroy" do
    let!(:test_flip) { create(:flip) }

    before :each do 
      allow(subject).to receive(:current_user).and_return(test_flip.author)
      delete :destroy, params: { id: test_flip.id }
    end 

    it "destroys the flip" do 
      expect(Flip.exists?(test_flip.id)).to be false
    end 

    it "redirects to flips_url" do 
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(flips_url)
    end 
  end 

  describe "POST #create" do 
    before :each do 
      create(:user)
      allow(subject).to receive(:current_user).and_return(User.last)
    end 

    let(:valid_params) { {flip: { body: "flip!"}}}
    let(:invalid_params) { {flip: { not_body: "no fleep :("}}}
    
    context "with valid params" do 
      it "creates the flip" do 
        post :create, params: valid_params
        expect(Flip.last.body).to eq("flip!")
      end 

      it "redirects to flip's show page" do 
        post :create, params: valid_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(flip_url(Flip.last.id))
      end 
    end 

    context "with invalid params" do 
      before :each do 
        post :create, params: invalid_params
      end 

      it "renders the new flip form" do 
        expect(response).to render_template(:new)
      end

      it "adds errors to flash" do 
        expect(flash[:errors]).to be_present
      end 
    end 
  end 
end   
require 'rails_helper'

describe NodesController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns the nodes' do
      node = create(:node, user: user)
      get :index
      expect(assigns(:nodes)).to match_array [node]
    end
  end

  describe 'GET #new' do
    it 'assigns a new user node' do
      get :new
      expect(assigns(:node).class).to eq(Node)
      expect(assigns(:node)).to be_new_record
      expect(assigns(:node).user).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates new user node' do
        expect{
          post :create, node: attributes_for(:node)
        }.to change{user.nodes.count}.by(1)
      end

      it 'redirects to nodes page' do
        post :create, node: attributes_for(:node)
        expect(response).to redirect_to nodes_path
      end

      it 'assigns node' do
        post :create, node: attributes_for(:node)
        expect(assigns(:node)).to be
      end
    end

    context 'with invalid attributes' do
      before do
        post :create, node: attributes_for(:node, aetitle: nil)
      end

      it 'renders new template' do
        expect(response).to render_template :new
      end

      it 'assigns node' do
        expect(assigns(:node)).to be
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:node) { create(:node, user: user) }

    it 'deletes node' do
      expect{
        delete :destroy, id: node
      }.to change{user.nodes.count}.by(-1)
    end

    it 'redirects to nodes page' do
      delete :destroy, id: node
      expect(response).to redirect_to(nodes_url)
    end

    it 'assigns node' do
      delete :destroy, id: node
      expect(assigns(:node)).to eq(node)
    end
  end

  describe 'GET #edit' do
    let!(:node) { create(:node, user: user) }

    it 'assigns node' do
      get :edit, id: node
      expect(assigns(:node)).to eq(node)
    end
  end

  describe 'PATCH #update' do
    let!(:node) { create(:node, user: user) }

    context 'with valid attributes' do
      let(:attributes) { attributes_for(:node) }

      it 'assigns node' do
        put :update, id: node, node: attributes
        expect(assigns(:node)).to eq(node)
      end

      it 'redirects to nodes page' do
        put :update, id: node, node: attributes
        expect(response).to redirect_to(nodes_url)
      end

      it 'updates node' do
        expect(node.name).to_not eq(attributes[:name])
        put :update, id: node, node: attributes
        node.reload
        expect(node.name).to eq(attributes[:name])
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { attributes_for(:node, name: nil) }

      it 'renders edit page' do
        put :update, id: node, node: attributes
        expect(response).to render_template(:edit)
      end
    end
  end
end

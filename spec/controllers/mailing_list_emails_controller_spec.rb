require 'rails_helper'

RSpec.describe MailingListEmailsController, type: :controller do
  describe "#create" do
    it "sign up for mailing list" do
      post :create, email: "test@example.com"
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to_not be_present
    end
  end
end

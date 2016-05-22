require 'rails_helper'
require "random_data"

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }

  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:sponsored_posts) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:name).is_at_least(5) }
  it { is_expected.to validate_length_of(:description).is_at_least(15) }
  
  describe "attributes" do
      it "responds to name and description attributes" do
        expect(topic).to have_attributes(name: topic.name, description: topic.description)
      end
  end

  describe "scopes" do
     before do
       @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
       @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
     end
 
     describe "visible_to(user)" do
       it "returns all topics if the user is present" do
         user = User.new
         expect(Topic.visible_to(user)).to eq(Topic.all)
       end
 
       it "returns only public topics if user is nil" do
         expect(Topic.visible_to(nil)).to eq([@public_topic])
       end
     end
   end
end

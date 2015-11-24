RSpec.describe NamedGradientStore do

  let(:riak) { $riak }
  let(:id) { SecureRandom.uuid }
  let(:gradient) { Gradient::Map.new(
    Gradient::Point.new(0, Color::RGB.new(0,0,0), 1),
    Gradient::Point.new(1, Color::RGB.new(255,255,255), 1),
  ) }

  subject(:store) {
    described_class.new(riak: riak, style: "test")
  }

  describe "#save" do
    it "stores the correct gradient in a riak database" do
      object = store.save(id, name: "Kiwi", gradient: gradient)
      expect(object.reload.data).to match a_hash_including("name" => "Kiwi", "gradient" => [[0,"rgb",[0,0,0],1],[1,"rgb",[255,255,255],1]])
      store.delete(id)
    end
  end

  describe "#delete" do
    it "removes the object from the gradients bucket" do
      store.save(id, name: "Kiwi", gradient: gradient)
      store.delete(id)
      expect(riak.bucket("gradients").exists?(id)).to eq false
    end
  end

end
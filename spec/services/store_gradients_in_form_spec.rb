RSpec.describe StoreGradientsInForm do

  describe "#call" do
    it "saves the form attributes in the store" do
      form = GradientsForm.new([
        ActionController::Parameters.new(name: "One", points: "[[0,\"rgb\",[0,0,0],1],[1,\"rgb\",[255,255,255],1]]", save: "1"),
        ActionController::Parameters.new(name: "Two", points: "[[0,\"rgb\",[0,0,0],1],[1,\"rgb\",[255,255,255],1]]", save: "0"),
        ActionController::Parameters.new(name: "Three", points: "[[0,\"rgb\",[0,0,0],1],[1,\"rgb\",[255,255,255],1]]", save: "1")
      ])
      store = double
      expect(store).to receive(:save).with(id: anything, name: "One", points: [[0,"rgb",[0,0,0],1],[1,"rgb",[255,255,255],1]]).once
      expect(store).to receive(:save).with(id: anything, name: "Three", points: [[0,"rgb",[0,0,0],1],[1,"rgb",[255,255,255],1]]).once
      expect(store).to_not receive(:save).with(id: anything, name: "Two", points: [[0,"rgb",[0,0,0],1],[1,"rgb",[255,255,255],1]])
      result = described_class.new(store, form).call
      expect(result).to eq [true, false, true]
    end
  end

end
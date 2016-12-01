describe Game do
  subject { described_class.new }

  def take_multiple_turns(array_of_turns)
    array_of_turns.each do |turn|
      subject.take_turn(turn[0], turn[1])
    end
  end

  describe "board" do
    it "should be a grid of 3 x 3 cells" do
      expect(subject.board.count).to eq(3)
      all_rows_have_3_elements = subject.board.all? {|row| row.length == 3 }
      expect(all_rows_have_3_elements).to be_truthy
    end
  end

  it "can take an X turn" do
    subject.take_turn(0, 0)
    expect(subject.board.flatten).to include("X")
  end

  it "second turn should place a O" do
    subject.take_turn(1, 1)
    subject.take_turn(1, 0)
    expect(subject.board.flatten).to include("O")
  end

  describe "attempted overwrite filed" do
    it "raises an error and won't allow over-writing" do
      subject.take_turn(1, 1)
      expect{ subject.take_turn(1, 1) }.to raise_error("Field taken, choose another")
      expect(subject.board.flatten).not_to include("O")
      subject.take_turn(0, 1)
      expect(subject.board.flatten).to include("O")
    end
  end

  describe "game over" do
    it "isn't over if not over" do
      shots = [[1, 1], [2, 1]]
      take_multiple_turns(shots)
      expect(subject).not_to be_game_over
    end

    it "game over if 3 in a row horizontal" do
      row_complete = [[1, 1], [0, 0], [1, 0], [0, 1], [1, 2]]
      take_multiple_turns(row_complete)
      expect(subject).to be_game_over
    end

    it "game over if 3 in a row vertical" do
      column_complete = [[1, 1], [0, 0], [0, 1], [1, 2], [2, 1]]
      take_multiple_turns(column_complete)
      expect(subject).to be_game_over
    end

    it "game over if 3 in a row diagonal" do
      diagonal_complete = [[1, 1], [2, 1], [0, 0], [1, 2], [2, 2]]
      take_multiple_turns(diagonal_complete)
      expect(subject).to be_game_over
    end

    it "game over if 3 in a row diagonal" do
      diagonal_complete = [[1, 1], [2, 1], [0, 2], [1, 2], [2, 0]]
      take_multiple_turns(diagonal_complete)
      expect(subject).to be_game_over
    end

    it "can't take another shot if game over" do
      row_complete = [[1, 1], [0, 0], [1, 0], [0, 1], [1, 2]]
      take_multiple_turns(row_complete)
      expect{subject.take_turn(2, 2)}.to raise_error("Game Over")
    end
  end
end

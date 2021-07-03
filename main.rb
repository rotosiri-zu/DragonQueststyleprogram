class Brave

  # initializeメソッドを定義
  def initialize
    @name = "テリー"
    @hp = 500
    @offense = 150
    @defense = 100
  end

  # nameのゲッター
  def name
    @name
  end

  # hpのセッター
  def hp
    @hp
  end
  
  # offenseのゲッター
  def offense
    @offense
  end

  # defenseのゲッター
  def defense
    @defense
  end
end

brave = Brave.new

puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE#{brave.defense}
TEXT
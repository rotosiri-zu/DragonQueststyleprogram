require './brave'
require './monster'
  
  brave = Brave.new(name:"テリー", hp:500, offense:150, defense:100)
  # ハッシュ形式でデータを渡すのでどういうデータを渡しているのか把握しやすくなる
  monster = Monster.new(name:"スライム", hp:250, offense:200, defense:100)
  loop do
    brave.attack(monster)

    # モンスターのHPが0以下になったら無限ループを終了させる
    # 1行で記述
    break if monster.hp <= 0

    monster.attack(brave)
    # 勇者のHPが0以下になったら無限ループを終了させる
    # 1行で記述
    break if brave.hp <= 0
  end

battle_result = brave.hp > 0

if battle_result
  exp = (monster.offense + monster.defense) * 2
  gold = (monster.offense + monster.defense) * 3
  puts "#{brave.name}はたたかいに勝った"
  puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
else
  puts "#{brave.name}は戦いに負けた"
  puts "目の前が真っ暗になった"
end


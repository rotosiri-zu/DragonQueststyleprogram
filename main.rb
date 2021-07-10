class Brave

  #attr_readerの記載でゲッターを省略することができる
  # 複数の値を同時に指定することができる
  attr_reader :name, :offense, :defense
  # attr_writerでセッターを定義
  # セッターゲッターを一括定義
  attr_accessor :hp

  # 必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  # initializeメソッドを定義
  #paramsで一括で受け取る
  #引数に**を記載:ハッシュしか受け取れなくなる
  def initialize(**params)
    #各パラメータをハッシュで取得
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  # 攻撃処理を実装するメソッド
  # 引数でモンスタークラスのインスタンスを受け取る
  def attack(monster)
   # @offense:勇者インスタンスの攻撃力
   # monster.defeense:モンスターインスタンスの防御力
   
   puts "#{@name}の攻撃"

   # decision_attack_typeメソッドの呼び出し
   attack_type = decision_attack_type

   # calculate_damageメソッドの呼び出し
   # キーワード引数を設定
   damage = calculate_damage(target:monster, attack_type:attack_type)

   # ダメージをHPに反映させる
   # キーワード引数を設定
   cause_damage(target:monster, damage:damage)

    # メッセージを追記
    # puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  # ここから下のメソッドをprivateメソッドにする
  private
  # 攻撃の種類（通常攻撃 or 必殺攻撃）を判定するメソッド
  def decision_attack_type
    #0~3の間でランダムに数字が変わる
    attack_num = rand(4)
  
    if attack_num == 0
      puts "必殺攻撃"
      "special_attack"
    else
      puts "通常攻撃"
      "normal_attac"
    end
  end

  # ダメージの計算メソッド
  # **paramsで受け取る
  def calculate_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    target = params[:target]
    attack_type = params[:attack_type]

    # attack_typeを用いて攻撃処理を振り分け
   if attack_type == "special_attack"
    calculate_special_attack - target.defense
   else
    @offense - target.defense
   end
  end

  # HPにダメージを反映させる
  # **paramsで受け取る
  def cause_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    damage = params[:damage]
    target = params[:target]

    # ダメージ計算の処理を追加
    # damage = @offense - monster.defense
    # モンスターのhpから計算したダメージを引く
    # 自己代入：monster.hpからdamageを引いた値をmonster.hpに代入
    target.hp -= damage

    # もしターゲットのHPがマイナスになるなら0を代入
    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
    # special_attackが実行されているか確かめるためのテスト
    # puts "calculate_special_attackが呼び出されました"
    # 攻撃力が1.5倍
    @offense * SPECIAL_ATTACK_CONSTANT
  end

end

class Monster
  # 値の取り出し飲み可能
  # attr_readerにnameを削除
  attr_reader :offense, :defense
  # 値の代入・取り出しが可能
  # attr_accessorにnameを追加
  attr_accessor :hp, :name

  POWER_UP_RATE = 1.5
  # HPの半分の値を計算する定数
  CALC_HALF_HP = 0.5

  # **paramsにすることでハッシュ形式の引数しか受け付けないようにできる
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]

    # モンスターが変身したかどうかを判定するフラグ
    @transform_flag = false

    # 変身する際の閾値(トリガー)を計算
    # 定数を使用
    @trigger_of_transform = params[:hp] * CALC_HALF_HP

  end
  
  def attack(brave)
      # HPが半分以下、かつ、モンスター変身判定フラグがfalseの時に実行
      if @hp <= @trigger_of_transform && @transform_flag == false
        # モンスター変身判定フラグにtrueを代入
        @transform_flag = true
        # 変身メソッドを実行
        transform
      end

      puts "#{@name}の攻撃"
      
      # ダメージ計算処理の呼び出し
      damage = calculate_damage(brave)
      
      # ダメージ反映処理の呼び出し
      cause_damage(target:brave, damage:damage)
     
      puts "#{brave.name}の残りHPは#{brave.hp}だ"
    end

    # クラス外から呼び出せないようにする
    private

    # ダメージ計算処理
    def calculate_damage(target)
      @offense - target.defense
    end

    # ダメージ反映処理
    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]
      
      target.hp -= damage
      
      # もしターゲットのHPがマイナスになるなら0を代入
      target.hp = 0 if target.hp < 0

      puts "#{target.name}は#{damage}のダメージを受けた"
    end

    # 変身メソッドの定義
    def transform
      # 変身後の名前
      transform_name = "ドラゴン"

      # 変身メッセージ
      puts <<~EOS
      #{@name}は怒っている
      #{@name}は#{transform_name}に変身した
      EOS

      # モンスターの攻撃力を1.5倍にする
       # 代入演算子で計算
      @offense * POWER_UP_RATE
      # モンスターの名前を変更
      @name = transform_name
    end

  end
  
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

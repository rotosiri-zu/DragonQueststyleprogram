require './character'

class Brave < Character

  #attr_readerの記載でゲッターを省略することができる
  # 複数の値を同時に指定することができる
  # attr_reader :name, :offense, :defense
  # attr_writerでセッターを定義
  # セッターゲッターを一括定義
  # attr_accessor :hp

  # 必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  # initializeメソッドを定義
  #paramsで一括で受け取る
  #引数に**を記載:ハッシュしか受け取れなくなる
  # def initialize(**params)
    #各パラメータをハッシュで取得
  #   @name = params[:name]
  #   @hp = params[:hp]
  #   @offense = params[:offense]
  #   @defense = params[:defense]
  # end

  # 攻撃処理を実装するメソッド
  # 引数でモンスタークラスのインスタンスを受け取る
  def attack(monster)
   # @offense:勇者インスタンスの攻撃力
   # monster.defeense:モンスターインスタンスの防御力

  #  puts "#{@name}の攻撃"

   # decision_attack_typeメソッドの呼び出し
   attack_type = decision_attack_type

   # calculate_damageメソッドの呼び出し
   # キーワード引数を設定
   damage = calculate_damage(target:monster, attack_type:attack_type)

   # ダメージをHPに反映させる
   # キーワード引数を設定
   cause_damage(target:monster, damage:damage)

   # attack_messageの呼び出し
   # attack_typeを引数に渡す
   attack_message(attack_type:attack_type)

    # メッセージを追記
    # puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  # ここから下のメソッドをprivateメソッドにする
  private
  # 攻撃の種類（通常攻撃 or 必殺攻撃）を判定するメソッド
  def decision_attack_type
    #0~3の間でランダムに数字が変わる
    attack_num = rand(4)
  
    if attack_num == 0
      # puts "必殺攻撃"
      "special_attack"
    else
      # puts "通常攻撃"
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


    # puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
    # special_attackが実行されているか確かめるためのテスト
    # puts "calculate_special_attackが呼び出されました"
    # 攻撃力が1.5倍
    @offense * SPECIAL_ATTACK_CONSTANT
  end

end
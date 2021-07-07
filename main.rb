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

   #0~3の間でランダムに数字が変わる
   attack_num = rand(4)

   #4分の1の確率でspecial_attackを実行
   if attack_num == 0
    # 必殺攻撃の表示
    puts "必殺攻撃"
    # calculate_special_attackの呼び出し
    # 攻撃力の1.5倍の数値が戻り値として返ってくる
    damage = calculate_special_attack - monster.defense
   else
    # 通常攻撃の表示
    puts "通常攻撃"
    damage = @offense - monster.defense
   end
   # ダメージ計算の処理を追加
  # damage = @offense - monster.defense
   # モンスターのhpから計算したダメージを引く
   # 自己代入：monster.hpからdamageを引いた値をmonster.hpに代入
   monster.hp -= damage

   # メッセージを追記
   puts "#{monster.name}は#{damage}のダメージを受けた"
   puts "#{monster.name}の残りHPは#{monster.hp}だ"
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
      
      # 勇者に与えるダメージの計算
      damage = @offense - brave.defense
      
      # 勇者クラスのHPにダメージを反映
      brave.hp -= damage
      
      puts "#{brave.name}は#{damage}のダメージを受けた"
      puts "#{brave.name}の残りHPは#{brave.hp}だ"
    end

    # クラス外から呼び出せないようにする
    private

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
  
  
  brave.attack(monster)
  monster.attack(brave)
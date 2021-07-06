class Brave

  #attr_readerの記載でゲッターを省略することができる
  # 複数の値を同時に指定することができる
  attr_reader :name, :offense, :defense
  # attr_writerでセッターを定義
  # セッターゲッターを一括定義
  attr_accessor :hp
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
   #ダメージ計算の処理を追加
   damage = @offense-monster.defense
   # モンスターのhpから計算したダメージを引く
   # 自己代入：monster.hpからdamageを引いた値をmonster.hpに代入
   monster.hp -= damage

   # メッセージを追記
   puts "#{monster.name}は#{damage}のダメージを受けた"
   puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

end

class Monster
  # 値の取り出し飲み可能
  attr_reader :name, :offense, :defense
  # 値の代入・取り出しが可能
  attr_accessor :hp

  # **paramsにすることでハッシュ形式の引数しか受け付けないようにできる
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end  

end

brave = Brave.new(name:"テリー", hp:500, offense:150, defense:100)
# ハッシュ形式でデータを渡すのでどういうデータを渡しているのか把握しやすくなる
monster = Monster.new(name:"スライム", hp:250, offense:200, defense:100)

brave.attack(monster)
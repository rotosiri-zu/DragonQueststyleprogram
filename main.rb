class Brave

  #attr_readerの記載でゲッターを省略することができる
  # 複数の値を同時に指定することができる
  attr_reader :name, :hp, :offense, :defense
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

end

brave = Brave.new(name:"テリー", hp:500, offense:150, defense:100)

puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE#{brave.defense}
TEXT

brave.hp -= 30

puts "#{brave.name}はダメージを受けた！残りは#{brave.hp}だ"
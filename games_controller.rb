require './message_dialog'

class GamesController

  # MessageDialogモジュールのinclude
  include MessageDialog

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  # バトルの処理
  def battle(**params)
   # build_charactersを呼びだし
   build_characters(params)

    loop do
      # インスタンス変数に変更
      @brave.attack(@monster)

      # モンスターのHPが0以下になったら無限ループを終了させる
      # 1行で記述
      break if battle_end? #引数が必要なくなる

      # インスタンス変数に変更
      @monster.attack(@brave)
      # 勇者のHPが0以下になったら無限ループを終了させる
      # 1行で記述
      break if battle_end? #引数が必要なくなる
    end

    # battle_judgmentメソッドを呼び出す
    battle_judgment
  end

# 以下のメソッドはクラス外から呼び出す必要がないのでprivate以下に記述する
private

  # キャラクターのインスタンスをインスタンス変数に格納
  def build_characters(**params)
    # 勇者クラス、モンスタークラスそれぞれのインスタンスをインスタンス変数に代入
    @brave = params[:brave]
    @monster = params[:monster]
  end

  # バトル終了の判定
  # 引数が必要なくなる
  def battle_end?
    # 勇者かモンスター、どちらかのHPが0になったらバトルが終了する
    @brave.hp <= 0 || @monster.hp <= 0
  end

  # 勇者の勝利判定
  # 引数が必要なくなる
  # brave_win?にメソッド名を変更
  def brave_win?
    # インスタンス変数に変更
    @brave.hp > 0
  end

  # 勇者の勝敗によりメッセージを変更する
  def battle_judgment
    result = calculate_of_exp_and_gole #引数が必要なくなる
     
    # end_messageを呼び出す
    end_message(result)
  end
  # 経験値とゴールドの計算
  # 引数が必要なくなる
  def calculate_of_exp_and_gole
    if brave_win?
      brave_win_flag = true
      exp = (@monster.offense + @monster.defense) * EXP_CONSTANT
      gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT
    else
      brave_win_flag = false
      exp = 0
      gold = 0
    end

    {brave_win_flag:brave_win_flag,exp:exp,gold:gold}
  end
end
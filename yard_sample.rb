# coding: utf-8
# ポケモンを表すクラス
# @author Yuta Hashimoto
# @attr [String] name ポケモンの名前
# @attr [Fixnum] hp ポケモンの体力
class Pokemon

  attr_accessor :name, :hp

  # コンストラクタ
  # @param name [String] ポケモンの名前
  # @param hp [Integer] ポケモンの初期体力
  def initialize(name, hp)
    @name = name
    @hp = hp
  end

  # ポケモンがダメージを受ける時に呼ばれるメソッド
  # @param amount [Fixnum] 与えるダメージ
  # @return [Pokemon] ポケモン自身を返す
  # @example 50のダメージを受ける
  #   pokemon.gain_damage(50)
  def gain_damage(amount)
    @hp -= amount
    self
  end

  # 他のポケモンを攻撃する
  # @param [Pokemon] enemy 攻撃対象のポケモン
  def attack(enemy)
    enemy.gain_damage(50)
  end
end

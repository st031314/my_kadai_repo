# coding: utf-8
require 'minitest/autorun'


class VendingMachine

  attr_accessor :stock, :cash
  PRICE = 120

  def initialize
    @stock = Hash.new(0)
    @cash = 0
  end

  def replenish(drinks)
    drinks.each do |name, count|
      @stock[name] += count
    end
  end

  def insert_coin(amount)
    @cash += amount
  end

  def sell(name)
    raise "Drink sold out"  if @stock[name] == 0
    raise "Cash not enough" if @cash <= PRICE
    @stock[name] -= 1
    @cash -= PRICE
    name
  end

  def return_change
    change = @cash
    @cash = 0
    change
  end

end



class TestVendingMachine < Minitest::Test

  def setup
    @vm = VendingMachine.new
  end

  # 初期状態では stock は空のハッシュであることをテスト
  def test_initial_stock
    assert_equal({}, @vm.stock)
  end

  # 初期状態では cash は0であることをテスト
  def test_initial_cash
    assert_equal(0, @vm.cash)
  end

  # replenishがstockを増やすことをテストする
  def test_replenish
    @vm.replenish({coke:3, water: 2, coffee: 5})
    assert_equal({coke:3, water: 2, coffee: 5}, @vm.stock)
    @vm.replenish({coke:1, water: 1, coffee: 1})
    assert_equal({coke:4, water: 3, coffee: 6}, @vm.stock)
  end

  # insert_coinがcashを増やすことをテストする
  def test_insert_coin
    @vm.insert_coin(50)
    assert_equal(50, @vm.cash)
    @vm.insert_coin(100)
    assert_equal(150, @vm.cash)
  end

  # sellでジュースを売ると、
  # 1. ジュースの名前を返す
  # 2. 在庫の本数が1本減る
  # 3. 投入金額が120円減る　ことをテストする
  def test_sell
    @vm.replenish(coke: 5)
    @vm.insert_coin(150)
    assert_equal(:coke, @vm.sell(:coke))
    assert_equal({coke: 4}, @vm.stock)
    assert_equal(30, @vm.cash)
  end

  # 投入金額が120円に満たない時、
  # sellメソッドを呼ぶと例外が発生することをテストする
  def test_sell_error1
    @vm.replenish(coke: 5)
    @vm.insert_coin(100)
    assert_raises do
      @vm.sell(:coke)
    end
  end

  # 在庫の本数がゼロのとき、
  # sellメソッドを売ると例外が発生することをテストする
  def test_sell_error2
    @vm.replenish(coke: 5, water: 0)
    @vm.insert_coin(150)
    assert_raises do
      @vm.sell(:water)
    end
  end

  # return_changeを呼ぶと、
  # 1. 現在の投入金額が返ってくること
  # 2. 投入金額が0になること　
  # をテストする
  def test_return_change
    @vm.insert_coin(100)
    assert_equal(100, @vm.cash)
    assert_equal(100, @vm.return_change)
    assert_equal(0, @vm.cash)
  end
end

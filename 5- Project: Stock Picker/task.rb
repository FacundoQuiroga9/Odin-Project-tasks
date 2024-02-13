def stock_picker(day_prices)
  best_profit = 0
  best_days = [0, 0]

  day_prices.each_with_index do |buy_price, buy_day|
    day_prices[buy_day+1..-1].each_with_index do |sell_price, sell_day|
      profit = sell_price - buy_price

      if profit > best_profit
        best_profit = profit
        best_days = [buy_day, sell_day + buy_day + 1]
      end
    end
  end

  p best_days
end


stock_picker([17,3,6,9,15,8,6,1,10])

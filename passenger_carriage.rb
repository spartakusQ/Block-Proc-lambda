#класс пассажирского вагона, родительским является вагон
class PassengerCarriage < Carriage
  def initialize
    super(:passenger)
  end
end

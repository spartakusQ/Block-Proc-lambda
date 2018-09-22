#класс грузового вагона, родительским является класс вагон
class CargoCarriage < Carriage
  def initialize
    super(:cargo)
  end
end

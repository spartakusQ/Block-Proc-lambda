#создание родительского класса carriage для passenger_carriage и cargo_carriage
class Carriage
  include CompanyName
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

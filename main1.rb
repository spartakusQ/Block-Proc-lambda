require_relative 'train'
require_relative 'route'
require_relative 'train_station'
require_relative 'carriage'
require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'validation'

class Main
  attr_accessor :station, :trains, :train, :route, :stations,
                :number, :name, :carriage, :type, :carriages, :num

  include Validate

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def menu
    puts %Q(
      Выберете нужное вам меню:
      1.Создание станции.
      2.Создание поезда.
      3.Создание маршрута и управление станциями.
      4.Назначение маршрута поезду.
      5.Добавление выгоны к поезду.
      6.Отцепить вагоны от поезда.
      7.Перемещать поезд по маршруту вперёд и назад.
      8.Просматривать список станций и список поездов на станции.
      9.Просмотр данных о поезде.
      0.Выход из меню.
      )
    puts 'Введите номер команды: '
    input = gets.to_i
    case input
    when 1
      #1.Создание станции.rdy
      create_station
    when 2
      #2.Создание поезда.rdy
      create_train
    when 3
      #3.Создание маршрута и управление станциями.rdy
      create_route
    when 4
      #4.Назначение маршрута поезду.
      route_train
    when 5
      #5.Добавление выгоны к поезду.
      add_carriage
    when 6
      #6.Отцепить вагоны от поезда.
      unhook_carriage
    when 7
      #7.Перемещать поезд по маршруту вперёд и назад.
      move_train
    when 8
      #8.Просматривать список станций и список поездов на станции.
      station_list
    when 9
      #9.Просмотр данных о поезде.
      train_info
    when 0
      #0.Выход из меню.
      puts 'Счастливого пути!'
      exit
    end
  end
  private
  #все вызовы будут происходить через case input
  #создание станции
  def create_station
    puts 'Введите название станции которую хотите создать: '
    name = gets.chomp.capitalize
    @station = TrainStation.new(name)
    @stations << station
    puts "Станция #{name}  создана"
    menu
  end

  #создание поезда
  def create_train
    puts 'Поезд с каким номером хотите создать?'
    puts '1 - пассажирский; 2 - грузовой'
    input = gets.chomp.to_i

    case input
    when 1
      puts 'Для создания пассажирского поезда, введите номер поезда '
      number = gets.chomp
      @train = PassengerTrain.new(number)
      @trains << train
      puts "Поезд номер #{number}  пассажирского типа создан"
      menu
    when 2
      puts 'Для создания грузового поезда, введите номер поезда'
      number = gets.chomp
      @train = CargoTrain.new(number)
      @trains << train
      puts "Поезд номер #{number} грузового типа создан"
      menu
    end
    #обработка кода ошибки RuntimeError
  rescue RuntimeError => e
    puts e.message
    menu
  end
  #маршрутный лист станий (показывает все станции)
  def station_list
    stations.each { |station| puts station.station_name } || 'Станций не существует'
  end
  #Создание маршрута и управление станциями.
  def create_route
      station_list
      puts 'Выберете начальную станцию маршрута из списка:'
      input = gets.chomp.capitalize
      index = @stations.find_index { |station| station.station_name == input }
      first = @stations[index]
      puts 'Выберите конечную станцию маршрута из списка:'
      input = gets.chomp.capitalize
      index = @stations.find_index { |station| station.station_name == input }
      last = @stations[index]
      @route = Route.new(first, last)
      @routes << @route
      puts "Маршрут #{route.stations} создан"
      menu
    rescue RuntimeError, TypeError => e
      puts e.message
      retry
  end
end

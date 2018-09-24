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

  CARRIAGE_TYPES = {'cargo' => CargoCarriage, 'passenger' => PassengerCarriage}

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
      #1.Создание станции.
      create_station
    when 2
      #2.Создание поезда.
      create_train
    when 3
      #3.Создание маршрута и управление станциями.
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
end

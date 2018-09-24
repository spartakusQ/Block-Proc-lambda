require_relative 'train'
require_relative 'route'
require_relative 'train_station'
require_relative 'carriage'
require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'validation'

stations = []
trains = []
CARRIAGE_TYPES = {'cargo' => CargoCarriage, 'passenger' => PassengerCarriage}

puts %Q(
  Выберете нужное вам меню:
  1.Создание станции. rdy
  2.Создание поезда. rdy
  3.Создание маршрута и управление станциями.
  4.Назначение маршрута поезду.
  5.Добавление выгоны к поезду.
  6.Отцепить вагоны от поезда.
  7.Перемещать поезд по маршруту вперёд и назад.
  8.Просматривать список станций и список поездов на станции.
  9.Просмотр данных о поезде.
  0.Выход из меню.
  )
loop do
  puts 'Введите номер команды: '
  input = gets.to_i

case input
  when 1
      puts 'C каким названием?'
      name = gets.chomp
      stations << TrainStation.new(name)
  when 2
    puts 'Поезд с каким номером хотите создать?'
    puts '1 - пассажирский; 2 - грузовой'
    number = gets.chomp.to_i
      case number
        when 1
          trains << PassengerTrain.new(number)
        when 2
          trains << CargoTrain.new(number)
        else
          puts "Поезд не создан. Надо было ввести 1 или 2"
      end
  when 3
    if stations.empty?
      puts 'Сначала необходимо создать станцию'
    elsif trains.empty?
     puts 'Сначала необходимо создать поезд'
    else
      stations.each { |station| puts stations.name }
      puts "Маршрутный лист содержит станции:#{stations}"
      puts 'Введите начальную станцию:'
      start_station = gets.chomp
      if start_station == stations.include?
         puts 'Станция есть в списке.'
      end
    end
  when 4
    if trains.empty?
      puts 'Сначала необходимо создать поезд'
    elsif stations.empty?
      puts 'Сначала необходимо создать станцию'
    else
      puts 'Какой поезд? (введите номер)'
      number = gets.chomp
      train = trains.detect{|train| train.number == number}
      unless train
        puts 'Поезда с таким номером нет'
      else
        puts 'На какую станцию? (название)'
        name = gets.chomp
        station = stations.detect{|station| station.name == name}
        if station.nil?
          puts 'Такой станции нет'
        else
          station.get_train(train)
        end
      end
    end
  when 5
    if trains.empty?
      puts 'Сначала необходимо создать поезд'
    else
      puts 'К какому? (введите номер)'
      number = gets.chomp
      train = trains.detect{|train| train.number == number}
      unless train
        puts 'Поезда с таким номером нет'
      else
        train.add_carriage(CARRIAGE_TYPES[train.type])
      end
    end
  when 6
    if trains.empty?
      puts 'Сначала необходимо создать поезд'
    else
      puts 'От какого? (введите номер)'
      number = gets.chomp
      train = trains.detect{|train| train.number == number}
      unless train
        puts 'Поезда с таким номером нет'
      elsif train.carriages.empty?
        puts 'У этого поезда и так нет вагонов'
      else
        train.remove_carriage(train.carriages.last)
      end
    end
  when 7
    puts 'Выберите в каком направлении хотите отправить поезд.'
    puts '1 - вперёд; 2 - назад.'
      trace = gets.chomp.to_i
      case trace
      when 1
        puts "Введите номер поезда, который хотите отправить вперед"
        selected_train.move_next
        puts "Поезд #{train.number} прибыл на станцию #{@train.current_station.name}"
      when 2
        puts "Введите номер поезда, который хотите отправить вперед"
        selected_train.move_next
        puts "Поезд #{train.number} прибыл на станцию #{@train.current_station.name}"
      end
  when 8
    puts 'Список станций:'
      stations.each{|station| puts station.name}
    if stations.empty?
      puts 'Сначала необходимо создать станцию'
    else
      puts 'На какой? (название)'
      name = gets.chomp
      station = stations.detect{|station| station.name == name}
      if station.nil?
        puts 'Такой станции нет'
      else
        station.show_trains
      end
    end
  when 9
    puts 'Информация о поездах.'
    selected_train.each_carriage { |carriage| puts carriage.to_s }
  when 0
    puts 'Счастливого пути!'
    exit
  end
end

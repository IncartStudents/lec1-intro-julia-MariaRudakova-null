# Выболнить большую часть заданий ниже - привести примеры кода под каждым комментарием


#===========================================================================================
1. Переменные и константы, области видимости, cистема типов:
приведение к типам,
конкретные и абстрактные типы,
множественная диспетчеризация,
=#

# Что происходит с глобальной константой PI, о чем предупреждает интерпретатор?
#const PI = 3.14159
PI = 3.14159
PI = 3.14
# В языке Julia невозможно переопределить константу

# Что происходит с типами глобальных переменных ниже, какого типа `c` и почему?
a = 1
b = 2.0
c = a + b
#= 
Перенная а - Int64; перенная b - Float64; перенная с - Float64.
При операциях с переменными типов Int64 и Float64 переменная типа Int64 становиться типа Float64,
чтобы сохранить точность
=#

# Что теперь произошло с переменной а? Как происходит биндинг имен в Julia?
a = "foo"
# Теперь переменная а стала типа Str

# Что происходит с глобальной переменной g и почему? Чем ограничен биндинг имен в Julia?
g::Int = 1
#g = "hi"
#=
Сначала переменная g объявлена как целое число (Int) через аннотацию типа ::Int. 
Попытка присвоить ей строку вызывает ошибку, потому что Julia требует строгого соблюдения типов 
после их объявления. Попытка изменить тип уже объявленной переменной вызовет ошибку компиляции.
=#

function greet()
    g = "hello"
    println(g)
end
greet()
# Переменные в функции являются локальными, и их создание не затрагивает глобальные переменные с таким же именем.

# Чем отличаются присвоение значений новому имени - и мутация значений?
v = [1,2,3]
z = v
v[1] = 3
v = "hello"
z
#=
Присваивание строки "hello" переменной v не влияет на объект, который хранится в z, так как z всё еще указывает на 
исходный массив. В отличие от изменения элемента массива v[1] = 3, которое изменяет сам массив, и это изменение 
отражается на всех переменных, ссылающихся на этот массив.
=#

# Написать тип, параметризованный другим типом
struct MyType{A}
    another_type::A
end

#=
Написать функцию для двух аругментов, не указывая их тип,
и вторую функцию от двух аргментов с конкретными типами,
дать пример запуска
=#
function with_out_type(a, b)
    return a + b
end

function with_type(a::Int, b::Int)
    return a * b
end

with_out_type(1, 2)       # Возвращает 3
with_type(3, 4)  # Возвращает 12

#=
Абстрактный тип - ключевое слово? abstract type
Примитивный тип - ключевое слово? primitive type
Композитный тип - ключевое слово? struct
=#

#=
Написать один абстрактный тип и два его подтипа (1 и 2)
Написать функцию над абстрактным типом, и функцию над её подтипом-1
Выполнить функции над объектами подтипов 1 и 2 и объяснить результат
(функция выводит произвольный текст в консоль)
=#
abstract type Animal end

struct Dog <: Animal
    name::String
end

struct Cat <: Animal
    name::String
end

function make_sound(animal::Animal)
    if animal isa Dog
        println("Woof!")
    elseif animal isa Cat
        println("Meow!")
    else
        println("Unknown sound")
    end
end

function dog_specific(dog::Dog)
    println("This is a dog named $(dog.name)")
end

dog = Dog("Buddy")
cat = Cat("Whiskers")

make_sound(dog)  # Выведет "Woof!"
make_sound(cat)  # Выведет "Meow!"

dog_specific(dog)  # Выведет "This is a dog named Buddy"
#= Функция make_sound работает с любым объектом типа Animal, проверяя конкретный подтип. 
Функция dog_specific предназначена исключительно для объектов типа Dog =#

#===========================================================================================
2. Функции:
лямбды и обычные функции,
переменное количество аргументов,
именованные аргументы со значениями по умолчанию,
кортежи
=#

# Пример обычной функции
function f(a, b)
    return a + b
end

println(f(2, 4))

# Пример лямбда-функции (аннонимной функции)
square = x -> x^2  # Определение лямбда-функции

println(square(5))

# Пример функции с переменным количеством аргументов
function sum_varargs(args...)
    total = 0
    for arg in args
        total += arg
    end
    return total
end

println(sum_varargs(1, 2, 3, 4, 5))  

# Пример функции с именованными аргументами
function greet_person(name="World"; greeting="Hello")
    return "$greeting, $name!"
end

println(greet_person())                
println(greet_person("John"))          
println(greet_person(greeting="Hi"))   

# Функции с переменным кол-вом именованных аргументов
function process_kwargs(; kwargs...)
    for (key, value) in pairs(kwargs)
        println("$key => $value")
    end
end

process_kwargs(a=1, b=2, c=3) 

#=
Передать кортеж в функцию, которая принимает на вход несколько аргументов.
Присвоить кортеж результату функции, которая возвращает несколько аргументов.
Использовать splatting - деструктуризацию кортежа в набор аргументов.
=#
function print_tuple(tup)
    println("Tuple elements:")
    for elem in tup
        println(elem)
    end
end

mytuple = (1, "two", 3.0)
print_tuple(mytuple)

function add_three_numbers(a, b, c)
    return a + b + c
end

numbers = (1, 2, 3)
result = add_three_numbers(numbers...)  # Используем splatting

println(result) 

#===========================================================================================
3. loop fusion, broadcast, filter, map, reduce, list comprehension
=#

#=
Перемножить все элементы массива
- через loop fusion и
- с помощью reduce
=#
function multiply_elements(arr)
    result = 1
    @inbounds for i in eachindex(arr)
        result *= arr[i]
    end
    return result
end

arr = [1, 2, 3, 4]
prod_result = multiply_elements(arr)
println(prod_result)  

arr = [1, 2, 3, 4]
prod_result = reduce(*, arr)
println(prod_result)  

#=
Написать функцию от одного аргумента и запустить ее по всем элементам массива
с помощью точки (broadcast)
c помощью map
c помощью list comprehension
указать, чем это лучше явного цикла?
=#
# с помощью точки (broadcast)
arr = [1, 2, 3, 4]
squared_arr = arr .^ 2  
println(squared_arr)  

# c помощью map
arr = [1, 2, 3, 4]
squared_arr = map(x -> x^2, arr)
println(squared_arr)

# c помощью list comprehension
arr = [1, 2, 3, 4]
squared_arr = [x^2 for x in arr]
println(squared_arr)  # Output: [1, 4, 9, 16]
#=
Эти подходы делают код короче и проще для понимания.
Broadcast и map могут эффективно обрабатывать большие объемы данных, особенно с использованием 
многопоточных операций.
Нет необходимости вручную управлять индексами и границами массива.
=#

# Перемножить вектор-строку [1 2 3] на вектор-столбец [10,20,30] и объяснить результат
row_vector = [1 2 3]
column_vector = [10, 20, 30]
result_matrix = row_vector * column_vector
println(result_matrix) 

# В одну строку выбрать из массива [1, -2, 2, 3, 4, -5, 0] только четные и положительные числа
arr = [1, -2, 2, 3, 4, -5, 0]
even_positive = filter(x -> iseven(x) && x > 0, arr)
println(even_positive) 

# Объяснить следующий код обработки массива names - что за number мы в итоге определили?
using Random
Random.seed!(123)
names = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]
# ---
same_names = unique(map(y -> split(y, ".")[1], filter(x -> startswith(x, "A"), names)))
numbers = parse.(Int, map(x -> split(x, "_")[end], same_names))
numbers_sorted = sort(numbers)
number = findfirst(n -> !(n in numbers_sorted), 0:9)
#= Код выбирает уникальные имена файлов, начинающиеся с буквы 'A', и находит первое отсутствующее число 
среди первых цифр этих уникальных имён.=#

# Упростить этот код обработки:
using Random
Random.seed!(123)
names = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]

filtered_names = filter(x -> startswith(x, "A"), names)
extracted_digits = parse.(Int, map(x -> split(split(x, ".")[1], "_")[2], filtered_names))
sorted_digits = sort(unique(extracted_digits))
number = findfirst(n -> !(n in sorted_digits), 0:9)

#===========================================================================================
4. Свой тип данных на общих интерфейсах
=#

#=
написать свой тип ленивого массива, каждый элемент которого
вычисляется при взятии индекса (getindex) по формуле (index - 1)^2
=#
struct LazyArray
    len::Int
end

Base.getindex(lazy_array::LazyArray, index::Int) = (index - 1)^2

lazy = LazyArray(10)

for i in 1:10
    println(lazy[i])  # Вывод: 0, 1, 4, 9, ..., 81
end

#=
Написать два типа объектов команд, унаследованных от AbstractCommand,
которые применяются к массиву:
`SortCmd()` - сортирует исходный массив
`ChangeAtCmd(i, val)` - меняет элемент на позиции i на значение val
Каждая команда имеет конструктор и реализацию метода apply!
=#
abstract type AbstractCommand end
apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented for type $(typeof(cmd))")

struct SortCmd <: AbstractCommand end

function apply!(cmd::SortCmd, target::Vector)
    sort!(target)
end

struct ChangeAtCmd{I, T} <: AbstractCommand
    index::I
    value::T
end

function apply!(cmd::ChangeAtCmd, target::Vector)
    target[cmd.index] = cmd.value
end

# Аналогичные команды, но без наследования и в виде замыканий (лямбда-функций)
sort_lambda = () -> (x::Vector) -> sort!(x)
change_at_lambda = (i, v) -> (x::Vector) -> (x[i] = v)

array = [3, 1, 4, 1, 5, 9]

(sort_lambda())(array)
println(array)  # Массив отсортирован: [1, 1, 3, 4, 5, 9]

(change_at_lambda(3, 10))(array)
println(array)  # Массив изменен: [1, 1, 10, 4, 5, 9]

#===========================================================================================
5. Тесты: как проверять функции?
=#

# Написать тест для функции
using Test

# Определяем функцию, которую будем тестировать
function add(a, b)
    return a + b
end

# Тестовая секция
@testset "Testing the add function" begin
    # Проверяем базовый случай
    @test add(2, 3) == 5
    
    # Проверяем отрицательные числа
    @test add(-1, 1) == 0
    
    # Проверяем дробные числа
    @test add(2.5, 3.5) ≈ 6.0 atol=1e-8
    
    # Проверяем граничные случаи
    @test add(typemax(Int), 0) == typemax(Int)
    @test_throws OverflowError add(typemax(Int), 1)
end

#===========================================================================================
6. Дебаг: как отладить функцию по шагам?
=#

#=
Отладить функцию по шагам с помощью макроса @enter и точек останова
=#


#===========================================================================================
7. Профилировщик: как оценить производительность функции?
=#

#=
Оценить производительность функции с помощью макроса @profview,
и добавить в этот репозиторий файл со скриншотом flamechart'а
=#
function generate_data(len)
    vec1 = Any[]
    for k = 1:len
        r = randn(1,1)
        append!(vec1, r)
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end

@time generate_data(1_000_000);

using ProfileView

Profile.clear()
@profile generate_data(1_000_000)
ProfileView.view()


# Переписать функцию выше так, чтобы она выполнялась быстрее:
function generate_data_optimized(len)
    # Создаем вектор с заранее выделенной памятью и типом Float64
    vec1 = Vector{Float64}(undef, len)
    for k = 1:len
        vec1[k] = randn()
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end

@time generate_data_optimized(1_000_000);

#===========================================================================================
8. Отличия от матлаба: приращение массива и предварительная аллокация?
=#

#=
Написать функцию определения первой разности, которая принимает и возвращает массив
и для каждой точки входного (x) и выходного (y) выходного массива вычисляет:
y[i] = x[i] - x[i-1]
=#

#=
Аналогичная функция, которая отличается тем, что внутри себя не аллоцирует новый массив y,
а принимает его первым аргументом, сам массив аллоцируется до вызова функции
=#

#=
Написать код, который добавляет элементы в конец массива, в начало массива,
в середину массива
=#


#===========================================================================================
9. Модули и функции: как оборачивать функции внутрь модуля, как их экспортировать
и пользоваться вне модуля?
=#


#=
Написать модуль с двумя функциями,
экспортировать одну из них,
воспользоваться обеими функциями вне модуля
=#
module Foo
    #export ?
end
# using .Foo ?
# import .Foo ?


#===========================================================================================
10. Зависимости, окружение и пакеты
=#

# Что такое environment, как задать его, как его поменять во время работы?

# Что такое пакет (package), как добавить новый пакет?

# Как начать разрабатывать чужой пакет?

#=
Как создать свой пакет?
(необязательно, эксперименты с PkgTemplates проводим вне этого репозитория)
=#


#===========================================================================================
11. Сохранение переменных в файл и чтение из файла.
Подключить пакеты JLD2, CSV.
=#

# Сохранить и загрузить произвольные обхекты в JLD2, сравнить их

# Сохранить и загрузить табличные объекты (массивы) в CSV, сравнить их


#===========================================================================================
12. Аргументы запуска Julia
=#

#=
Как задать окружение при запуске?
=#

#=
Как задать скрипт, который будет выполняться при запуске:
а) из файла .jl
б) из текста команды? (см. флаг -e)
=#

#=
После выполнения задания Boids запустить julia из командной строки,
передав в виде аргумента имя gif-файла для сохранения анимации
=#

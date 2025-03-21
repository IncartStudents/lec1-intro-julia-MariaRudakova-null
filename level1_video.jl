# переписать ниже примеры из первого часа из видеолекции: 
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции

println("I'm excites to learn Julia")

my_answer = 42
typeof(my_answer)

my_pi = 3.14159
typeof(my_pi)

my_name = "Maria"
typeof(my_name)

my_answer = my_name
typeof(my_answer)

#Строка комментария
#=
Много
строк
=#

sum = 5 + 6
difference = 8 - 6
product = 5 * 3
quotient = 50 / 5
power = 6 ^ 3
moduls = 101 % 2

s1 = "I am a string"
s2 = """I am also a string"""

s3 = """Here, we get an "error" because it's ambiguous where this string"""
s4 =  """Look, Mom, no "errors" """
typeof('a')
#s5 = 'we will get an error here'

name = "Jane"
num_fingers = 10
num_toes = 10

println("Hello, my name is $name")
println("I have a $num_fingers fingers and $num_toes toes. That is $(num_fingers + num_toes) digits all")

string("How many cats", "are too many cats?")
string("I don't know, but",10,"are too few")

s6 = "How many cats"
s7 = "are too many cats?"
s = s6 * s7
println("$s6$s7")

myphonebook = Dict("jenny"=>"867-5309", "Ghostbusters"=>"555-2368")
myphonebook["Kramer"] = "555-FILK"
myphonebook
myphonebook["Kramer"]
pop!(myphonebook, "Kramer")
myphonebook

myfavoriteanimals = ("penguins", "cats", "dogs")
myfavoriteanimals[1]
myfavoriteanimals[1] = "otters"

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
fibonacci = [1, 1, 2, 3, 5, 8, 13]
mix = [1, 2, 3.0, "hi"]
myfriends[3]
myfriends[3] = "Baby Bop"
myfriends
push!(fibonacci, 21)
pop!(fibonacci)
fibonacci

favorites = [["koobiteh", "chocolate", "eggs"], ["cats", "penguins", "sugarglides"]]
numbers = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]
rand(4, 3)
rand(4, 3, 2)

n = 0
while n < 10
    n += 1
    println(n)
end

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
i = 1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi, $friend")
    i += 1
end

for n in 1:10
    println(n)
end

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
for friend in myfriends
    println("Hi, $friend")
end

for n = 1:10
    println(n)
end

m, n = 5, 5
A = zeros(m, n)
for i in 1:n
    for j in 1:m
        A[i, j] = i + j
    end
end

B = zeros(m, n)
for i in 1:n, j in 1:m
        B[i, j] = i + j
end

C = [i + j for i in 1:n, j in 1:m]

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

x = 3
y = 90
if x > y
    println("$x is lager than $y")
elseif y > x
    println("$y is lager than $x")
else
    println("$x and $y are equal")
end

if x > y
    println(x)
else
    println(y)
end

(x > y) ? x : y

(x > y) && println("$x is lager than $y")
(x < y) && println("$y is lager than $x")

function sayhi(name)
    println("Hi, $name")
end

function f(x)
    x^2
end

sayhi("C-3PO")
f(42)

sayhi2(name) = println("Hi, $name")
f2(x) = x^2

sayhi3 = name -> println("Hi, $name")
f3 = x -> x^2

A = rand(3, 3)
A
f(A)

v = rand(3)
f(v)

v = [3, 5, 2]
sort(v)
v
sort!(v)
v

A = [i + 3*j for j in 0:2, i in 1:3]
f(A)
B = f.(A)

A[2, 2]
A[2, 2]^2
b[2, 2]

v = [1, 2, 3]
f.(v)

Pkg.add("Example")
using Example
hello("it's me")

Pkg.add("Colors")
using Colors
palette = distinguishable_colors(100)
rand(palett, 3, 3)

Pkg.add("Plots")
using Plots

x = -3:0.1:3
f(x) = x^2

y = f.(x)

gr()
plot(x, y, label="line")
scatter!(x, y, label="points")

plotyjs()
plot(x, y, label="line")
scatter!(x, y, label="points")

globaltemperatures = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8]
numpirates = [45000, 20000, 15000, 400, 17]

#First, plot the data
plot(numpirates, globaltemperatures, legend=false)
scatter!(numpirates, globaltemperatures, legend=false)

xlabal!("Number of Pirates [Approximate]")
ylabel!("Global Temperature (C)")
title!("Influence of pirate population on global warming")

p1 = plot(x, x)
p2 = plot(x, x.^2)
p3 = plot(x, x.^3)
p4 = plot(x, x.^4)
plot(p1, p2, p3, p4, layout=(2,2), legend=false)

methods(+)
@whitch 3 + 3
@whitch 3.0 + 3.0
@whitch 3 + 3.0

import Base: +
"heelo" + "world"
@whitch "heelo" + "world"
+(x::String, y::String) = string(x, y)
"hello" + "world"
@whitch "heelo" + "world"

foo(x,y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo with an integer and a float")
foo(x::Float64, y::Float64) = println("foo with 2 floats")
foo(x::Int, y::Int) = println("foo with 2 integer floats")
foo(1, 1)
foo(1., 1.)
foo(1, 1.0)
foo(true, false)

A = rand(1:4, 3, 3)
B = A
C = copy(A)
[ B C]
A[1] = 17
[B C]

x = ones(3)
b = A*x
Asym = A + A'
Apd = A'A
A\b
Atall = A[:,1:2]
display(Atall)
Atall\b
A = randn(3,3)
[A[:,1] A[:,1]]\b

using JuliaParser
using FactCheck

const Parser = JuliaParser.Parser

facts("test token stream constructor") do
    io = IOBuffer("testfunc(i) = i * i") 
    try
        ts = TokenStream(io)
        @fact true => true
    catch
        @fact false => false
    end
end

facts("test special case all whitespace") do
    io = IOBuffer("")
    Parser.parse(io)
    @fact eof(io) => true

    io = IOBuffer(" \n")
    Parser.parse(io)
    @fact eof(io) => true

    io = IOBuffer("# test comment\n")
    Parser.parse(io)
    @fact eof(io) => true

    io = IOBuffer("#= test comment \n
                  another comment =#\n")
    Parser.parse(io)
    @fact eof(io) => true
end

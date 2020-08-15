module Accessories

###=============================================================================
### Suits
###=============================================================================

abstract type Suit end

##==============================================================================
## Colored suits
##==============================================================================

import Base: show

abstract type ColoredSuit <: Suit end

struct Club     <: ColoredSuit end
struct Spade    <: ColoredSuit end
struct Heart    <: ColoredSuit end
struct Diamond  <: ColoredSuit end

show(io::IO, ::Type{Club})      = print(io, "♣")
show(io::IO, ::Type{Spade})     = print(io, "♠")
show(io::IO, ::Type{Heart})     = print(io, "♡")
show(io::IO, ::Type{Diamond})   = print(io, "♢")

##==============================================================================
## Tarock
##==============================================================================

import Base: show

struct Tarock <: Suit
    value::Integer
    function Tarock(value::Integer)
        @assert value ∈ 1:22
        return new(value)
    end
end

# TODO choose a better character to show
show(io::IO, ::Type{Tarock}) = print(io, "#")

###=============================================================================
### Faces
###=============================================================================

import Base: show

abstract type Face end

struct Ace      <: Face end
struct Jack     <: Face end
struct Knight   <: Face end
struct Queen    <: Face end
struct King     <: Face end

show(io::IO, ::Type{Ace})       = print(io, "A")
show(io::IO, ::Type{Jack})      = print(io, "J")
show(io::IO, ::Type{Knight})    = print(io, "C")
show(io::IO, ::Type{Queen})     = print(io, "Q")
show(io::IO, ::Type{King})      = print(io, "K")

const Value = Union{Face, Val}

# TODO mark these showed `Val`s to differtiate from simple values
show(io::IO, ::Type{Val{V}}) where {V} = print(io, V)

###=============================================================================
### Card
###=============================================================================

import Base: show

struct Card{S <: Suit, V <: Value}
    # no field just parametric types

    function Card(S::Type{<: ColoredSuit}, F::Type{<: Face})
        return new{S, F}()
    end

    function Card(T::Type{Tarock}, value::Integer)
        @assert value ∈ 1:22
        @assert Val{value} <: Value
        return new{T, Val{value}}()
    end
end

show(io::IO, ::Card{S, V}) where {S, V} = print(io, "<", S, V, ">")

##==============================================================================
## Named cards
##==============================================================================

const Pagat     = Card{Tarock, Val{1}}
const TwentyOne = Card{Tarock, Val{21}}
const Skys      = Card{Tarock, Val{22}}

const Honours = Union{Pagat, TwentyOne, Skys}

const CARDS = [Card.(Tarock,    1:22);
               Card.(Club,      [Ace, Jack, Knight, Queen, King]);
               Card.(Spade,     [Ace, Jack, Knight, Queen, King]);
               Card.(Heart,     [Ace, Jack, Knight, Queen, King]);
               Card.(Diamond,   [Ace, Jack, Knight, Queen, King])]

###=============================================================================
### Card
###=============================================================================

import Base: length, in, isempty, popfirst!, append!, take!
import Random: rand
import Random: shuffle!
using Random: shuffle

struct Deck
    cards::Vector{<: Card}
    Deck(cards = CARDS) = new(cards)
end

length(deck::Deck)::Integer = length(deck.cards)

in(card::Card, deck::Deck)::Bool = card in deck.cards

isempty(deck::Deck) = isempty(deck.cards)

popfirst!(deck::Deck)::Card = popfirst!(deck.cards)

function cut!(deck::Deck, n::Integer = rand(1:length(a)))::Deck
    return Deck(take!(deck, n))
end

append!(a::Deck, b::Deck)::Deck = (append!(a.cards, b.cards); a)

take!(deck::Deck, n::Integer = 1) = [popfirst!(deck) for _ in 1:n]

shuffle!(deck::Deck)::Deck = (shuffle!(deck.cards); deck)

function rand(::Type{Deck})::Deck
    return Deck(shuffle(CARDS))
end

end # module

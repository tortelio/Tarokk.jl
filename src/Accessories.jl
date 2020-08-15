module Accessories

###=============================================================================
### Suits
###=============================================================================

abstract type Suit end

##==============================================================================
## Colored suits
##==============================================================================

abstract type ColoredSuit <: Suit end

struct Club     <: ColoredSuit end
struct Spade    <: ColoredSuit end
struct Heart    <: ColoredSuit end
struct Diamond  <: ColoredSuit end

##==============================================================================
## Tarock
##==============================================================================

struct Tarock <: Suit
    value::Integer
    function Tarock(value::Integer)
        @assert value ∈ 1:22
        return new(value)
    end
end

###=============================================================================
### Faces
###=============================================================================

abstract type Face end

struct Ace      <: Face end
struct Jack     <: Face end
struct Knight   <: Face end
struct Queen    <: Face end
struct King     <: Face end

const Value = Union{Face, Val}

###=============================================================================
### Card
###=============================================================================

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

import Base: length, in
import Random: rand
using Random: shuffle

struct Deck
    cards::Vector{<: Card}
    Deck(cards = CARDS) = new(cards)
end

length(deck::Deck) = length(deck.cards)

in(card::Card, deck::Deck) = card in deck.cards

function rand(::Type{Deck})::Deck
    return Deck(shuffle(CARDS))
end

end # module

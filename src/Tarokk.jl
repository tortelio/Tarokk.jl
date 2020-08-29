module Tarokk

export Game, Player

include("Accessories.jl")

###=============================================================================
### Player
###=============================================================================

using Base: @kwdef

using .Accessories: Card

@kwdef struct Player
    name::String
    cards::Vector{Card} = Card[]
end

###=============================================================================
### Game
###=============================================================================

using Base: @kwdef

using .Accessories: Deck, Card

@kwdef struct Game
    players::NTuple{4, Player}
    deck::Deck = Deck()
    talon::Vector{Card} = Card[]

    licits::Dict{Player, Any} = Dict{Player, Any}()
end

function dealer(game::Game)::Player
    return game.players |> first
end

function player(game::Game)::Player
    idxs = findall(game.licits)
    return 
end

##==============================================================================
## Actions
##==============================================================================

using .Accessories: Deck, Card
using .Accessories: shuffle!

##------------------------------------------------------------------------------
## Take places
##------------------------------------------------------------------------------

function take_places!(game::Game)::Game
    # TODO
    return game
end

##------------------------------------------------------------------------------
## Shuffle deck
##------------------------------------------------------------------------------

function shuffle_deck!(game::Game)::Game
    shuffle!(game.deck)
    return game
end

##------------------------------------------------------------------------------
## Deal
##------------------------------------------------------------------------------

function deal!(game::Game)::Game
    for player in game.players
        append!(player.cards, take!(game.deck, 5))
    end

    append!(game.talon, take!(game.deck, 6))

    for player in game.players
        append!(player.cards, take!(game.deck, 4))
    end

    return game
end

##------------------------------------------------------------------------------
## Licit
##------------------------------------------------------------------------------

function licit!(game::Game, player::Player, licit)::Game
    game.licits[player] = licit
    return game
end

function licit!(player::Player, licit)::Function
    return game -> licit!(game, player, licit)
end

end # module

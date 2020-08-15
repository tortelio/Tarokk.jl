module Utilities

import Base: first, last, step, iterate

struct Range{T} <: AbstractRange{T}
    start::T
    stop::T
end

function first(range::Range{T})::T where {T}
    return range.start
end

function last(range::Range{T})::T where {T}
    return range.stop
end

function step(::Range)
    return nothing
end

function hasnext end
function next end

function iterate(range::Range{T}, state::T = first(range)) where {T}
    if hasnext(state)
        return (state, next(range))
    else
        return nothing
    end
end

end # module

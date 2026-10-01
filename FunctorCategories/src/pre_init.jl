# To avoid name clashes, we exclude some names from the global namespace of the extension module.
empty!(ExcludedNames)

@FilterIntersection( IsCapCategory, IsFinite )


# Maybe move those to GAP emulation.jl
global const IsEvenInt = iseven
global const IsOddInt = isodd

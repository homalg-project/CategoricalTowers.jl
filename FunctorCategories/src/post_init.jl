empty!(ExcludedNames)

function (F::IsObjectInFunctorCategory.abstract_type)(c::IsCapCategoryCell.abstract_type)
	CallFuncList(F, [c])
end

function (F::IsMorphismInFunctorCategory.abstract_type)(c::IsCapCategoryObject.abstract_type)
	CallFuncList(F, [c])
end

function (F::IsObjectInCoPreSheafCategory.abstract_type)(c::IsCapCategoryCell.abstract_type)
	CallFuncList(F, [c])
end

function (F::IsMorphismInCoPreSheafCategory.abstract_type)(c::IsCapCategoryObject.abstract_type)
	CallFuncList(F, [c])
end

function (F::IsObjectInPreSheafCategoryOfFpEnrichedCategory.abstract_type)(c::IsCapCategoryCell.abstract_type)
	CallFuncList(F, [c])
end

function (F::IsMorphismInPreSheafCategoryOfFpEnrichedCategory.abstract_type)(c::IsCapCategoryObject.abstract_type)
	CallFuncList(F, [c])
end

function CreateBouquet( n::Int, loops::Vector{Int} )
    return CreateBouquet( BigInt( n ), BigInt.( loops ) )
end

function CreateBouquet(
        category_of_bouquets::TheJuliaAbstractTypeIsCategoryOfBouquets,
        n::Int,
        loops::Vector{Int} )
    return CreateBouquet( category_of_bouquets, BigInt( n ), BigInt.( loops ) )
end

function CreateBouquetMorphism(
	source::TheJuliaAbstractTypeIsObjectInCategoryOfBouquets,
	images_of_vertices::Vector{Int},
	images_of_loops::Vector{Int},
	range::TheJuliaAbstractTypeIsObjectInCategoryOfBouquets )
	return CreateBouquetMorphism( source,
				BigInt.( images_of_vertices ),
				BigInt.( images_of_loops ),
				range )
end

function CreateQuiver( n::Int, arrows::Vector{Int} )
    return CreateQuiver( BigInt( n ), BigInt.( arrows ) )
end

function CreateQuiver(
        category_of_quivers::TheJuliaAbstractTypeIsCategoryOfQuivers,
        n::Int,
        arrows::Vector{Int} )
    return CreateQuiver( category_of_quivers, BigInt( n ), BigInt.( arrows ) )
end

function CreateQuiverMorphism(
	source::TheJuliaAbstractTypeIsObjectInCategoryOfQuivers,
	images_of_vertices::Vector{Int},
	images_of_arrows::Vector{Int},
	range::TheJuliaAbstractTypeIsObjectInCategoryOfQuivers )
	return CreateQuiverMorphism( source,
				BigInt.( images_of_vertices ),
				BigInt.( images_of_arrows ),
				range )
end

function CreateReflexiveQuiver( n::Int, loops::Vector{Int}, arrows::Vector{Int} )
    return CreateReflexiveQuiver( BigInt( n ), BigInt.( loops ), BigInt.( arrows ) )
end

function CreateReflexiveQuiver(
        category_of_quivers::TheJuliaAbstractTypeIsCategoryOfReflexiveQuivers,
        n::Int,
        loops::Vector{Int},
        arrows::Vector{Int} )
    return CreateReflexiveQuiver( category_of_quivers, BigInt( n ), BigInt.( loops ), BigInt.( arrows ) )
end

function CreateReflexiveQuiverMorphism(
	source::TheJuliaAbstractTypeIsObjectInCategoryOfReflexiveQuivers,
	images_of_vertices::Vector{Int},
	images_of_arrows::Vector{Int},
	range::TheJuliaAbstractTypeIsObjectInCategoryOfReflexiveQuivers )
	return CreateReflexiveQuiverMorphism( source,
				BigInt.( images_of_vertices ),
				BigInt.( images_of_arrows ),
				range )
end

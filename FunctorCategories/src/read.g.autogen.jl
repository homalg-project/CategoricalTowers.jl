# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Reading the implementation part of the package.
#

include( "gap/precompiled_categories/FinBouquetsPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/FinBouquetsAsCCCPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/FinQuiversPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/FinQuiversAsCCCPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/FinReflexiveQuiversPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/FinReflexiveQuiversAsCCCPrecompiled.gi.autogen.jl");

#= comment for Julia
if IsPackageMarkedForLoading( "Algebroids", ">= 2026.07-04" ) then
    include( "gap/precompiled_categories/PreSheavesOfFpCategoryDefinedByQuiverAlgebraInSkeletalFinSetsPrecompiled.gi.autogen.jl");
    include( "gap/precompiled_categories/PreSheavesOfFpCategoryDefinedByQuiverAlgebraInSkeletalFinSetsSubobjectClassifierPrecompiled.gi.autogen.jl");
fi;
# =#

include( "gap/precompiled_categories/PreSheavesOfCategoryFromDataTablesInSkeletalFinSetsPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/PreSheavesOfCategoryFromDataTablesInSkeletalFinSetsSubobjectClassifierPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/PreSheavesOfFreeAlgebroidInCategoryOfRowsPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/PreSheavesOfAlgebroidWithRelationsInCategoryOfRowsPrecompiled.gi.autogen.jl");
include( "gap/precompiled_categories/PreSheavesOfAlgebroidFromDataTablesInCategoryOfRowsPrecompiled.gi.autogen.jl");

include( "gap/Tools.gi.autogen.jl");
include( "gap/ToolsMethodRecord.gi.autogen.jl");
include( "gap/ToolsMethodRecordInstallations.autogen.gi.autogen.jl");
include( "gap/ToolsDerivedMethods.gi.autogen.jl");

include( "gap/PreSheaves.gi.autogen.jl");
include( "gap/HomStructure.gi.autogen.jl");

include( "gap/FunctorCategories.gi.autogen.jl");
include( "gap/CoPreSheaves.gi.autogen.jl");

include( "gap/FiniteCocompletion.gi.autogen.jl");
include( "gap/CategoryOfBouquets.gi.autogen.jl");
include( "gap/CategoryOfQuivers.gi.autogen.jl");

#= comment for Julia (requires SliceCategories)
include( "gap/CategoryOfDecoratedQuivers.gi.autogen.jl");
# =#

include( "gap/CategoryOfReflexiveQuivers.gi.autogen.jl");
include( "gap/FiniteCompletion.gi.autogen.jl");
include( "gap/FreeDistributiveCompletion.gi.autogen.jl");

include( "gap/AbelianClosure.gi.autogen.jl");
include( "gap/Functors.gi.autogen.jl");
include( "gap/DirectSumDecomposition.gi.autogen.jl");
include( "gap/HomologicalMethods.gi.autogen.jl");
include( "gap/QuotientsOfAlgebroidsFromDataTablesUsingPreSheaves.gi.autogen.jl" );

#= comment for Julia
if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    include( "gap/Julia.gi.autogen.jl" );
fi;
# =#

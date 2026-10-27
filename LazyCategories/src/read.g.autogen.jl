# SPDX-License-Identifier: GPL-2.0-or-later
# LazyCategories: Construct an equivalent lazy category out of a CAP category
#
# Reading the implementation part of the package.
#

include( "gap/LazyCategory.gi.autogen.jl");

#= comment for Julia
if IsPackageMarkedForLoading( "Digraphs", ">= 1.3.1" ) then
    include( "gap/ToolsUsingDigraphs.gi.autogen.jl");
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    include( "gap/Julia.gi.autogen.jl" );
fi;
# =#

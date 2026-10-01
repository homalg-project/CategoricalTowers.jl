# SPDX-License-Identifier: GPL-2.0-or-later
# FunctorCategories: Categories of functors
#
# Declarations
#

#! @Chapter Free Abelian category of a finitely presented linear category

####################################
#
#! @Section &GAP; Categories
#
####################################

#! @Description
#!  The &GAP; category of an Abelian closure category.
#! @Arguments category
@DeclareFilter( "IsAbelianClosure",
        IsWrapperCapCategory );

#! @Description
#!  The &GAP; category of cells in an Abelian closure category.
#! @Arguments cell
@DeclareFilter( "IsCellInAbelianClosure",
        IsCapCategoryCell );

#! @Description
#!  The &GAP; category of objects in an Abelian closure category.
#! @Arguments obj
@DeclareFilter( "IsObjectInAbelianClosure",
        FilterIntersection( IsWrapperCapCategoryObject, IsCellInAbelianClosure ) );

#! @Description
#!  The &GAP; category of morphisms in an Abelian closure category.
#! @Arguments mor
@DeclareFilter( "IsMorphismInAbelianClosure",
        FilterIntersection( IsWrapperCapCategoryMorphism, IsCellInAbelianClosure ) );

####################################
#
#! @Section Attributes
#
####################################

#! @Arguments abelian_closure
@DeclareAttribute( "UnderlyingCategory",
        IsAbelianClosure );

#! @Arguments abelian_closure
#! @Returns a &CAP; functor
@DeclareAttribute( "EmbeddingOfUnderlyingCategory",
        IsAbelianClosure );

####################################
#
#! @Section Constructors
#
####################################

#! @Description
#!  Construct an Abelian closure category.
#! @Returns a &CAP; category
#! @Arguments B
#! @Group AbelianClosure
@DeclareOperation( "AbelianClosure",
        [ IsFpAlgebroid ] );

@DeclareOperation( "AbelianClosure",
        [ IsFpAlgebroid, IsCapCategory ] );

# SPDX-License-Identifier: GPL-2.0-or-later
# SliceCategories: Slice categories
#
# Declarations
#

#! @Chapter Slice categories (eager data structure)

####################################
#
#! @Section GAP categories
#
####################################

#! @Description
#!  The &GAP; category of an eager slice category.
@DeclareFilter( "IsEagerSliceCategory",
        IsSliceCategory );

#! @Description
#!  The &GAP; category of cells in an eager slice category.
@DeclareFilter( "IsCellInAnEagerSliceCategory",
        IsCellInASliceCategory );

#! @Description
#!  The &GAP; category of objects in an eager slice category.
@DeclareFilter( "IsObjectInAnEagerSliceCategory",
        FilterIntersection( IsObjectInASliceCategory, IsCellInAnEagerSliceCategory ) );

#! @Description
#!  The &GAP; category of morphisms in an eager slice category.
@DeclareFilter( "IsMorphismInAnEagerSliceCategory",
        FilterIntersection( IsMorphismInASliceCategory, IsCellInAnEagerSliceCategory ) );

#! @Description
#!  The &GAP; category of an eager slice category over the tensor unit.
@DeclareFilter( "IsEagerSliceCategoryOverTensorUnit",
        FilterIntersection( IsSliceCategoryOverTensorUnit, IsEagerSliceCategory ) );

#! @Description
#!  The &GAP; category of cells in an eager slice category over the tensor unit.
@DeclareFilter( "IsCellInAnEagerSliceCategoryOverTensorUnit",
        FilterIntersection( IsCellInSliceCategoryOverTensorUnit, IsCellInAnEagerSliceCategory ) );

#! @Description
#!  The &GAP; category of objects in an eager slice category over the tensor unit.
@DeclareFilter( "IsObjectInAnEagerSliceCategoryOverTensorUnit",
        FilterIntersection( IsObjectInSliceCategoryOverTensorUnit, IsObjectInAnEagerSliceCategory ) );

#! @Description
#!  The &GAP; category of morphisms in an eager slice category over the tensor unit.
@DeclareFilter( "IsMorphismInAnEagerSliceCategoryOverTensorUnit",
        FilterIntersection( IsMorphismInSliceCategoryOverTensorUnit, IsMorphismInAnEagerSliceCategory ) );

####################################
#
#! @Section Constructors
#
####################################

#! @Arguments B
@DeclareAttribute( "SliceCategory",
        IsCapCategoryObject );

#! @Arguments M
@DeclareAttribute( "SliceCategoryOverTensorUnit",
        IsCapCategory );

#! @Arguments mor
@DeclareAttribute( "AsSliceCategoryCell",
        IsCapCategoryMorphism );

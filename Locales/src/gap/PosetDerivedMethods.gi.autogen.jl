# SPDX-License-Identifier: GPL-2.0-or-later
# Locales: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
AddDerivationToCAP( AreIsomorphicForObjectsIfIsHomSetInhabited,
        "AreIsomorphicForObjectsIfIsHomSetInhabited using IsEqualForObjectsIfIsHomSetInhabited",
        [ [ IsEqualForObjectsIfIsHomSetInhabited, 1 ] ],
        
  function( cat, A, B )
    
    return IsEqualForObjectsIfIsHomSetInhabited( cat, A, B );
    
end; CategoryFilter = IsPosetCategory );

##
AddDerivationToCAP( IsEqualForObjectsIfIsHomSetInhabited,
        "IsEqualForObjectsIfIsHomSetInhabited using AreIsomorphicForObjectsIfIsHomSetInhabited",
        [ [ AreIsomorphicForObjectsIfIsHomSetInhabited, 1 ] ],
        
  function( cat, A, B )
    
    return AreIsomorphicForObjectsIfIsHomSetInhabited( cat, A, B );
    
end; CategoryFilter = IsPosetCategory );

##
AddDerivationToCAP( IsEqualForObjects,
        "",
        [ [ IsHomSetInhabited, 1 ],
          [ AreIsomorphicForObjectsIfIsHomSetInhabited, 1 ] ],
        
  function( cat, A, B )
    
    return IsHomSetInhabited( cat, A, B ) &&
           AreIsomorphicForObjectsIfIsHomSetInhabited( cat, A, B );
    
end; CategoryFilter = IsPosetCategory );

##
AddDerivationToCAP( DirectProduct,
        "",
        [ [ IsHomSetInhabited, 2 ] ],
        
  function( cat, L )
    
    return First( SortedList( L, ( A, B ) -> IsHomSetInhabited( cat, A, B ) ) );
    
end; CategoryFilter = cat -> HasIsTotalOrderCategory( cat ) && IsTotalOrderCategory( cat ) && !( @IsBound( cat.supports_empty_limits ) && cat.supports_empty_limits == true ) );

##
AddDerivationToCAP( Coproduct,
        "",
        [ [ IsHomSetInhabited, 2 ] ],
        
  function( cat, L )
    
    return Last( SortedList( L, ( A, B ) -> IsHomSetInhabited( cat, A, B ) ) );
    
end; CategoryFilter = cat -> HasIsTotalOrderCategory( cat ) && IsTotalOrderCategory( cat ) && !( @IsBound( cat.supports_empty_limits ) && cat.supports_empty_limits == true ) );

##
AddDerivationToCAP( SetOfGeneratingMorphismsOfCategory,
        "SetOfGeneratingMorphismsOfCategory using SetOfObjectsOfCategory, IsHomSetInhabited, and UniqueMorphism",
        [ [ SetOfObjectsOfCategory, 1 ],
          [ IsHomSetInhabited, 20 ],
          [ UniqueMorphism, 4 ] ],
        
  function( cat )
    local objects, l;
    
    objects = SetOfObjectsOfCategory( cat );
    l = Length( objects );
    
    # Compute the Hasse diagram: s → t is a covering relation iff s ≠ t,
    # Hom(s,t) is inhabited, and there is no u with s ≠ u ≠ t and
    # Hom(s,u), Hom(u,t) inhabited.  Transitivity of the order guarantees
    # that every redundant edge has such a length-2 witness, so checking
    # length-2 paths suffices (no deeper search needed).
    return @Concatenation( List( (1):(l), s ->
                   List( Filtered( (1):(l), t ->
                           t != s &&
                           IsHomSetInhabited( cat, objects[s], objects[t] ) &&
                           @not ForAny( (1):(l), u ->
                                   u != s && u != t &&
                                   IsHomSetInhabited( cat, objects[s], objects[u] ) &&
                                   IsHomSetInhabited( cat, objects[u], objects[t] ) ) ),
                         t -> UniqueMorphism( cat, objects[s], objects[t] ) ) ) );
    
end; CategoryFilter = cat -> HasIsPosetCategory( cat ) && IsPosetCategory( cat ) && HasIsFiniteCategory( cat ) && IsFiniteCategory( cat ) );

if (IsPackageMarkedForLoading( "Digraphs", ">= 1.3.1" ))

##
AddDerivationToCAP( SetOfGeneratingMorphismsOfCategory,
        "SetOfGeneratingMorphismsOfCategory using DigraphReflexiveTransitiveReduction",
        [ [ SetOfObjectsOfCategory, 1 ],
          [ IsHomSetInhabited, 1 ],
          [ UniqueMorphism, 4 ] ],
        
  function( cat )
    local objects, l, digraph;
    
    objects = SetOfObjectsOfCategory( cat );
    
    l = Length( objects );
    
    digraph = DigraphReflexiveTransitiveReduction( Digraph( objects, IsHomSetInhabited ) );
    
    return @Concatenation( List( (1):(l), s ->
                   List( OutNeighborsOfVertex( digraph, s ), t ->
                         UniqueMorphism( cat, objects[s], objects[t] ) ) ) );
    
end; CategoryFilter = cat -> HasIsPosetCategory( cat ) && IsPosetCategory( cat ) && HasIsFiniteCategory( cat ) && IsFiniteCategory( cat ) );

end;

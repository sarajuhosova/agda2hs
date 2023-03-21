module Haskell.Law.Eq.Maybe where

open import Haskell.Prim
open import Haskell.Prim.Eq
open import Haskell.Prim.Maybe

open import Haskell.Law.Eq.Def
open import Haskell.Law.Equality
open import Haskell.Law.Maybe

private
  reflectsJust : ⦃ iEqA : Eq a ⦄ → ⦃ iLawfulEq : IsLawfulEq a ⦄
    → ∀ (x y : a) → Reflects (Just x ≡ Just y) ((Just x) == (Just y))
  reflectsJust ⦃ iLawfulEq = lEq ⦄ x y with (x == y) in h
  ... | True  = ofY (cong Just (IsLawfulEq.equality lEq x y h))
  ... | False = ofN (λ eq → (IsLawfulEq.nequality lEq x y h) (injective eq))

instance
  iLawfulEqMaybe : ⦃ iEqA : Eq a ⦄ → ⦃ iLawfulEq : IsLawfulEq a ⦄ → IsLawfulEq (Maybe a)
  iLawfulEqMaybe .isEquality Nothing Nothing = ofY refl
  iLawfulEqMaybe .isEquality Nothing (Just _) = ofN λ()
  iLawfulEqMaybe .isEquality (Just _) Nothing = ofN λ()
  iLawfulEqMaybe .isEquality (Just x) (Just y) = reflectsJust x y
 
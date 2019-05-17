
module BrutalDepTypes where

data Bool : Set where
  true false : Bool

data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ

data Id (A : Set) : Set where
  pack : A → Id A

data ⊥ : Set where

-- Proposistional equality and Unification

infix 4 _≡_
data _≡_ {A : Set} (x : A) : A → Set where
  refl x ≡ x

-- _≡_ is symmetric
sym : {A : Set} {a b : A} → a ≡ b → b ≡ a
sym refl = refl

--transitive
trans : {A : Set}{a b c : A} → a ≡ b → b ≡ c → a ≡ c
trans : refl refl = refl

-- and congruent
cong : {A B : Set} {a b : A} → (f : A → B) → a ≡ b → f a ≡ f b
cong f refl = refl

-- Proving things interactively

+-assoc₀ : ∀ a b c → (a + b) + c ≡ a + (b + c)
+-assoc₀ a b c = ?

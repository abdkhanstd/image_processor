
--   Title      : NUMERIC_UNSIGNED arithmetic package for synthesis
--              : Rev. 1.0 (April 17 1995)
--              :
--   Library    : This package shall be compiled into a library symbolically
--              : named IEEE.
--              :
--   Developers : Mentor Graphics
--              :
--   Purpose    : This package defines signed arithmetic operations on STD-LOGIC_VECTOR
--              :
-- ----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

package NUMERIC_UNSIGNED is

  function "+" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
  -- Result: UNSIGNED add of two STD_LOGIC_VECTOR vectors that may be of different lengths.

  function "+" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(R'LENGTH-1 downto 0).
  -- Result: Adds an INTEGER, L(may be positive or negative), to a STD_LOGIC_VECTOR
  --         R which is assumed to be UNSIGNED.

  function "+" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(L'LENGTH-1 downto 0).
  -- Result: Adds a STD_LOGIC_VECTOR vector assumed UNSIGNED, L, to an INTEGER, R.

  function "-" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
  -- Result: UNSIGNED subtraction of two STD_LOGIC_VECTOR vectors that may be of different lengths.

  function "-" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(R'LENGTH-1 downto 0).
  -- Result: Subtracts a UNSIGNED STD_LOGIC_VECTOR, R, from an INTEGER, L.

  function "-" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(L'LENGTH-1 downto 0).
  -- Result: Subtracts an INTEGER, R, from a UNSIGNED STD_LOGIC_VECTOR vector, L.

  function "*" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR((L'LENGTH+R'LENGTH-1) downto 0)
  -- Result: Multiplies two STD_LOGIC_VECTOR vectors that may possibly be of
  --         different lengths.  The inputs and outputs are assumed to be UNSIGNED.

  function "*" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR((L'LENGTH+L'LENGTH-1) downto 0)
  -- Result: Multiplies a STD_LOGIC_VECTOR vector, L, with an INTEGER, R. R is
  --         converted to a UNSIGNED vector of SIZE L'LENGTH before
  --         multiplication.  The multiplication is UNSIGNED.

  function "*" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR((R'LENGTH+R'LENGTH-1) downto 0)
  -- Result: Multiplies a STD_LOGIC_VECTOR vector, R, with an INTEGER, L. L is
  --         converted to a UNSIGNED vector of SIZE R'LENGTH before
  --         multiplication.  The multiplication is UNSIGNED.

  function "/" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Divides an STD_LOGIC_VECTOR vector, L, by another STD_LOGIC_VECTOR vector, R.
  --         This is an unsigned divide.

  function "/" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Divides a STD_LOGIC_VECTOR vector, L, by an INTEGER, R.
  --         If NO_OF_BITS(R) > L'LENGTH, result is truncated to L'LENGTH.
  --         This is an unsigned divide.

  function "/" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Divides an INTEGER, L, by a STD_LOGIC_VECTOR vector, R.
  --         If NO_OF_BITS(L) > R'LENGTH, result is truncated to R'LENGTH.
  --         This is an unsigned divide.

  function "rem" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L rem R" where L and R are STD_LOGIC_VECTOR vectors.
  --         This is an unsigned operation.

  function "rem" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Computes "L rem R" where L is STD_LOGIC_VECTOR vector and R is an INTEGER.
  --         If NO_OF_BITS(R) > L'LENGTH, result is truncated to L'LENGTH.
  --         This is an unsigned operation.

  function "rem" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L rem R" where R is STD_LOGIC_VECTOR vector and L is an INTEGER.
  --         If NO_OF_BITS(L) > R'LENGTH, result is truncated to R'LENGTH.
  --         This is an unsigned operation.

  function "mod" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L mod R" where L and R are STD_LOGIC_VECTOR vectors.
  --         This is an unsigned operation.

  function "mod" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(L'LENGTH-1 downto 0)
  -- Result: Computes "L mod R" where L is a STD_LOGIC_VECTOR vector and
  --         R is an INTEGER.
  --         If NO_OF_BITS(R) > L'LENGTH, result is truncated to L'LENGTH.
  --         This is an unsigned operation.

  function "mod" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(R'LENGTH-1 downto 0)
  -- Result: Computes "L mod R" where L is an INTEGER and
  --         R is a STD_LOGIC_VECTOR vector.
  --         If NO_OF_BITS(L) > R'LENGTH, result is truncated to R'LENGTH.
  --         This is an unsigned operation.

  --============================================================================
  -- Shift and Rotate Functions
  --============================================================================

  function SHIFT_LEFT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a shift-left on a STD_LOGIC_VECTOR vector COUNT times.
  --         The vacated positions are filled with '0'.
  --         The COUNT leftmost elements are lost.

  function SHIFT_RIGHT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a shift-right on a STD_LOGIC_VECTOR vector COUNT times.
  --         The vacated positions are filled with '0'.
  --         The COUNT rightmost elements are lost.

  function ROTATE_LEFT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a logical rotate-left of a STD_LOGIC_VECTOR
  --         vector COUNT times.

  function ROTATE_RIGHT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: Performs a logical rotate-right of a STD_LOGIC_VECTOR
  --         vector COUNT times.

  --  -----------------------------------------------------------------------
  --  Note : This function is not compatible with VHDL 1076-1987. Comment
  --  out the function (declaration and body) for VHDL 1076-1987 compatibility.
  --  -----------------------------------------------------------------------
  function "SLL" (ARG: STD_LOGIC_VECTOR; COUNT: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: SHIFT_LEFT(ARG,COUNT)

  --  -----------------------------------------------------------------------
  --  Note : This function is not compatible with VHDL 1076-1987. Comment
  --  out the function (declaration and body) for VHDL 1076-1987 compatibility.
  --  -----------------------------------------------------------------------
  function "SRL" (ARG: STD_LOGIC_VECTOR; COUNT: integer) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: STD_LOGIC_VECTOR(SHIFT_RIGHT(SIGNED(ARG),COUNT))

  --  -----------------------------------------------------------------------
  --  Note : This function is not compatible with VHDL 1076-1987. Comment
  --  out the function (declaration and body) for VHDL 1076-1987 compatibility.
  --  -----------------------------------------------------------------------
  function "ROL" (ARG: STD_LOGIC_VECTOR; COUNT: INTEGER) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: ROTATE_LEFT(ARG,COUNT)

  --  -----------------------------------------------------------------------
  --  Note : This function is not compatible with VHDL 1076-1987. Comment
  --  out the function (declaration and body) for VHDL 1076-1987 compatibility.
  --  -----------------------------------------------------------------------
  function "ROR" (ARG: STD_LOGIC_VECTOR; COUNT: integer) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(ARG'LENGTH-1 downto 0)
  -- Result: ROTATE_RIGHT(ARG,COUNT)

  --============================================================================
  --  RESIZE Functions
  --============================================================================

  function RESIZE (ARG: STD_LOGIC_VECTOR; NEW_SIZE: NATURAL) return STD_LOGIC_VECTOR;
  -- Result subtype: STD_LOGIC_VECTOR(NEW_SIZE-1 downto 0)
  -- Result: ReSIZEs the STD_LOGIC_VECTOR vector ARG to the specified SIZE.
  --         To create a larger vector, the new [leftmost] bit positions
  --         are filled with '0'.

  --============================================================================
  -- Conversion Functions
  --============================================================================

  function TO_INTEGER (ARG: STD_LOGIC_VECTOR) return INTEGER;
  -- Result subtype: INTEGER
  -- Result: Converts an unsigned STD_LOGIC_VECTOR vector to an INTEGER.

end NUMERIC_UNSIGNED;


package body NUMERIC_UNSIGNED is

  function "+" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) + UNSIGNED(R)));
  end;

  function "+" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(L + UNSIGNED(R)));
  end;

  function "+" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) + R));
  end;

  function "-" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) - UNSIGNED(R)));
  end;

  function "-" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(L - UNSIGNED(R)));
  end;

  function "-" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) - R));
  end;

  function "*" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) * UNSIGNED(R)));
  end;

  function "*" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) * R));
  end;

  function "*" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(L * UNSIGNED(R)));
  end;

  function "/" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) / UNSIGNED(R)));
  end;

  function "/" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) / R));
  end;

  function "/" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(L / UNSIGNED(R)));
  end;

  function "rem" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) rem UNSIGNED(R)));
  end;

  function "rem" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) rem R));
  end;

  function "rem" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(L rem UNSIGNED(R)));
  end;

  function "mod" (L, R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) mod UNSIGNED(R)));
  end;

  function "mod" (L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(UNSIGNED(L) mod R));
  end;

  function "mod" (L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(L mod UNSIGNED(R)));
  end;

  function SHIFT_LEFT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(ARG), COUNT)));
  end;

  function SHIFT_RIGHT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(SHIFT_RIGHT(UNSIGNED(ARG), COUNT)));
  end;

  function ROTATE_LEFT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(ROTATE_LEFT(UNSIGNED(ARG), COUNT)));
  end;

  function ROTATE_RIGHT (ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(ROTATE_RIGHT(UNSIGNED(ARG), COUNT)));
  end;

  function "SLL" (ARG: STD_LOGIC_VECTOR; COUNT: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(ARG), COUNT)));
  end;

  function "SRL" (ARG: STD_LOGIC_VECTOR; COUNT: integer) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(SHIFT_RIGHT(UNSIGNED(ARG), COUNT)));
  end;

  function "ROL" (ARG: STD_LOGIC_VECTOR; COUNT: INTEGER) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(ROTATE_LEFT(UNSIGNED(ARG), COUNT)));
  end;

  function "ROR" (ARG: STD_LOGIC_VECTOR; COUNT: integer) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(ROTATE_RIGHT(UNSIGNED(ARG), COUNT)));
  end;

  function RESIZE (ARG: STD_LOGIC_VECTOR; NEW_SIZE: NATURAL) return STD_LOGIC_VECTOR is
  begin
    return(STD_LOGIC_VECTOR(RESIZE(UNSIGNED(ARG), NEW_SIZE)));
  end;

  function TO_INTEGER (ARG: STD_LOGIC_VECTOR) return INTEGER is
  begin
    return(TO_INTEGER(UNSIGNED(ARG)));
  end;

end NUMERIC_UNSIGNED;
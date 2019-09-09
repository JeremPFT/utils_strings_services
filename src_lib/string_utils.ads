with Ada.Unchecked_Deallocation;
with Ada.Containers.Vectors;
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Bounded;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;

package String_Utils is

  -----------------------------------------------------------------------------
  --  renaming of predefined elements

  package T_IO renames Ada.Text_IO;
  package F_Str renames Ada.Strings.Fixed;
  package U_Str renames Ada.Strings.Unbounded;
  package A_Str renames Ada.Strings;

  type String_Access is access String;

  type String_Array is array (Positive range <>) of String_Access;

  function "+"
    (Value : String)
    return not null access String
    is (new String'(Value));

  subtype U_String is U_Str.Unbounded_String;

  procedure Free is new Ada.Unchecked_Deallocation
    (Object => String, Name => String_Access);

  function To_String
    (Source : U_String)
    return String with Inline;

  function To_U_String
    (Source : String)
    return U_String with Inline;

  function To_String
    (Source : not null access String)
    return String with Inline;

  Null_U_String : U_String renames U_Str.Null_Unbounded_String;

  package B_Str is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 256);

  subtype B_String is B_Str.Bounded_String;

  Null_B_String : B_String renames B_Str.Null_Bounded_String;

  function To_String
    (Source : B_String)
    return String renames B_Str.To_String;

  --  function "-"
  --   (Source : B_String)
  --   return String renames B_Str.To_String;

  function "+"
    (Source : String)
    return U_String renames To_U_String;

  function "-"
    (Source : U_String)
    return String renames To_String;

  function To_B_String
    (Source : String;
     Drop   : Ada.Strings.Truncation := Ada.Strings.Error)
    return B_String renames B_Str.To_Bounded_String;

  --  function "=" (Left, Right : U_String) return Boolean renames U_Str."=";

  function "*"
    (Left  : Natural;
     Right : Character) return String
    renames Ada.Strings.Fixed."*";

  -----------------------------------------------------------------------------

  package U_String_Vectors is
    new Ada.Containers.Vectors
    (Index_Type   => Positive,
     Element_Type => U_String,
     "="          => U_Str."=");

  type U_String_Array is array (Positive range <>) of U_String;

  -----------------------------------------------------------------------------

  function Quote
    (Source : in String)
    return String
    is ("""" & Source & """");

  function Quote
    (Source : in U_String)
    return String
    is (Quote (To_String (Source)));

  -----------------------------------------------------------------------------

  procedure To_Mixed
    (Text : in out U_String);

  function To_Mixed
    (Text : in U_String)
    return String;

  function To_Mixed
    (Text : in String)
    return String;

  -----------------------------------------------------------------------------

  EOL : constant String (1 .. 1) := (1 => ASCII.LF);

  -----------------------------------------------------------------------------

  --  generic
  --    type String_Ref is access String;
  --    type String_Array is array (Integer range <>) of String_Ref;
  --    Sep : in String;
  --  function Split
  --   (Source : in String)
  --   return String_Array;
  --  --  resulting substrings are trimed on both side

  -----------------------------------------------------------------------------

end String_Utils;

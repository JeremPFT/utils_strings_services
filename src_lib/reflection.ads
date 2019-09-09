with Ada.Strings.Fixed;
with Ada.Tags;

with String_Utils;

generic
package Reflection is

  Name : constant String;

private
  type T is abstract tagged null record;

  Tag_Str : constant String := Ada.Tags.Expanded_Name (T'Tag);
  Dot     : constant String := ".";

  Backward : Ada.Strings.Direction renames Ada.Strings.Backward;

  package F_Str renames Ada.Strings.Fixed;

  Last_Dot_Index : constant Natural := F_Str.Index
    (Source  => Tag_Str,
     Pattern => Dot,
     Going   => Backward);

  S_Last_Dot_Index : constant Natural := F_Str.Index
    (Source  => Tag_Str,
     Pattern => Dot,
     Going   => Backward,
     From    => Last_Dot_Index - 1);

  Name : constant String := String_Utils.To_Mixed
    (Tag_Str (Tag_Str'First .. S_Last_Dot_Index - 1));
end Reflection;

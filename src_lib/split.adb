with Ada.Strings.Fixed;
with Ada.Text_IO;

with String_Vectors;
with String_Utils;

function Split
  (Source    : in String;
   Separator : in String)
  return String_Vectors.Vector
is
  pragma Check_Policy (Debug, Off);

  package T_IO renames Ada.Text_IO;
  Both : Ada.Strings.Trim_End renames Ada.Strings.Both;

  pragma Debug (T_IO.Put_Line ("Split, in"));
  pragma Debug (T_IO.Put_Line ("  source = " & String_Utils.Quote (Source)));
  pragma Debug (T_IO.Put_Line ("  separator = " & String_Utils.Quote (Separator)));

  package F_Str renames Ada.Strings.Fixed;

  Sep_Count : constant Natural := F_Str.Count (Source  => Source,
                                               Pattern => Separator);

  Source_Length : constant Natural := F_Str.Trim (Source => Source,
                                                  Side   => Both)'Length;

  pragma Debug (T_IO.Put_Line ("  sep_count = "
                                 & String_Utils.Quote (Sep_Count'Img)));

  Start_Index : Integer := Source'First;
  Stop_Index  : Integer := F_Str.Index (Source  => Source,
                                        Pattern => Separator) - 1;


  Result : String_Vectors.Vector := String_Vectors.Empty_Vector;

  begin

  if Sep_Count = 0 then

    pragma Debug (T_IO.Put_Line ("  no separator"));

    if Source_Length > 0 then
      Result.Append
        (F_Str.Trim (Source => Source,
                     Side   => Both));
    end if;

  else

 On_Substrings :
    for I in 1 .. Sep_Count + 1 loop

      declare
        Substr : constant String :=
          F_Str.Trim (Source => Source (Start_Index .. Stop_Index),
                      Side   => Both);
        pragma Debug (T_IO.Put_Line ("  substring (" & I'Img & ") : "
                                       & String_Utils.Quote (Substr)));
      begin
        if Substr /= "" then
          Result.Append (Substr);
        end if;
      end;

      Start_Index := Stop_Index + Separator'Length + 1;

      Stop_Index := F_Str.Index (Source  => Source,
                                 Pattern => Separator,
                                 From    => Start_Index);

      Stop_Index := (if I = Sep_Count then
                       Source'Last
                     else
                       Stop_Index - 1);
    end loop On_Substrings;

  end if;

  pragma Debug (T_IO.Put_Line ("Split, out"));
  return Result;
end Split;

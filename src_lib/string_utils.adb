with GNAT.Case_Util;

package body String_Utils is

  function To_String
    (Source : U_String)
    return String is (U_Str.To_String (Source));

  function To_U_String
    (Source : String)
    return U_String is (U_Str.To_Unbounded_String (Source));

  function To_String
    (Source : not null access String)
    return String is (Source.all);

  procedure To_Mixed
    (Text : in out U_String)
  is
    To_Upcase : Boolean := True;
  begin
    for I in 1 .. U_Str.Length (Text) loop
      declare
        Char : Character renames U_Str.Element (Text, I);
      begin
        if To_Upcase then
          U_Str.Replace_Element
            (Source => Text,
             Index  => I,
             By     => GNAT.Case_Util.To_Upper (Char));
        else
          U_Str.Replace_Element
            (Source => Text,
             Index  => I,
             By     => GNAT.Case_Util.To_Lower (Char));
        end if;

        To_Upcase := Char = '_' or else Char = '.';
      end;
    end loop;
  end To_Mixed;

  function To_Mixed
    (Text : in U_String)
    return String
  is
    Copy : U_String := Text;
  begin
    To_Mixed (Copy);
    return To_String (Copy);
  end To_Mixed;

  function To_Mixed
    (Text : in String)
    return String
    is (To_Mixed (To_U_String (Text)));

  -----------------------------------------------------------------------------

end String_Utils;

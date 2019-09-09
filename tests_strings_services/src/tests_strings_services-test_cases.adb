with Ada.Text_IO;
with Gnat.Source_Info;
with AUnit.Assertions;

with Assertions;
with String_Vectors;
with String_Utils;
with Split;

package body Tests_Strings_Services.Test_Cases
is


  -----------------------------------------------------------------------------
  --  debug configuration
  -----------------------------------------------------------------------------

  pragma Check_Policy (Debug, On); --  -gnata

  -----------------------------------------------------------------------------
  --  tests preparations
  -----------------------------------------------------------------------------

  package T_IO renames Ada.Text_IO;
  package Assert renames Assertions;

  pragma Debug ( T_IO.Put_Line (Gnat.Source_Info.File & "::" &
                                  Gnat.Source_Info.Enclosing_Entity) );
  pragma Debug ( T_IO.Put_Line (Gnat.Source_Info.Compilation_Iso_Date & "::" &
                                  Gnat.Source_Info.Compilation_Time) );

  procedure Setup_Tests
    ( T : in out Test_Case )
  is
    pragma Unused (T);
  begin
    pragma Debug ( T_IO.Put_Line (Gnat.Source_Info.File & "::" &
                                    Gnat.Source_Info.Enclosing_Entity) );
    pragma Debug ( T_IO.Put_Line (Gnat.Source_Info.Compilation_Iso_Date & "::" &
                                    Gnat.Source_Info.Compilation_Time) );
    null;
  end Setup_Tests;

  procedure Register_Tests
    ( T: in out Test_Case )
  is
    use AUnit.Test_Cases.Registration;
  begin
    Register_Routine
      (T,
       Test_Split'Access,
       "Test_Split");

    Register_Routine
      (T,
       Test_Quote'Access,
       "Test_Quote");
  end Register_Tests;

  procedure Tear_Down
    (T : in out Test_Case)
  is
  begin
    null;
  end Tear_Down;

  -----------------------------------------------------------------------------
  --  tests definitions
  -----------------------------------------------------------------------------

  procedure Test_Split
    (T : in out AUnit.Test_Cases.Test_Case'Class)
  is
    Test : Test_Case'Class renames Test_Case'Class (T);
    pragma Unreferenced (Test);
  begin
    --  Aunit.Assertions.Assert (False, "NOT IMPLEMENTED");

    declare
      Full_String : constant String       := " un deux trois   x";
      Separator   : constant String       := " ";
      Substrings  : String_Vectors.Vector := String_Vectors.Empty_Vector;
    begin
      Substrings := Split (Full_String, Separator);

      Assert.Check_Integer (Integer (Substrings.Length), 4);
      Assert.Check_String (Substrings.Element (1), "un");
      Assert.Check_String (Substrings.Element (2), "deux");
      Assert.Check_String (Substrings.Element (3), "trois");
      Assert.Check_String (Substrings.Element (4), "x");
    end;

  end Test_Split;

  -----------------------------------------------------------------------------

  procedure Test_Quote
    (T : in out AUnit.Test_Cases.Test_Case'Class)
  is
    Test : Test_Case'Class renames Test_Case'Class (T);
    pragma Unreferenced (Test);
    use String_Utils;
  begin
    Assert.Check_String (Quote ("abcd"), """" & "abcd" & """");
  end Test_Quote;

  -----------------------------------------------------------------------------

  procedure Test_Something
    (T : in out AUnit.Test_Cases.Test_Case'Class)
  is
    Test : Test_Case'Class renames Test_Case'Class (T);
    pragma Unreferenced (Test);
  begin
    AUnit.Assertions.Assert (False, "NOT IMPLEMENTED");
  end Test_Something;
  pragma Unreferenced (Test_Something);

  -----------------------------------------------------------------------------

end Tests_Strings_Services.Test_Cases;

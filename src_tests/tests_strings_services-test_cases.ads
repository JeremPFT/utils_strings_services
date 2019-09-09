with AUnit;
with AUnit.Test_Cases;

package Tests_Strings_Services.Test_Cases is

  type Test_Case is new AUnit.Test_Cases.Test_Case with private;

  overriding
  function Name
    (Test : Test_Case)
    return AUnit.Message_String
    is ( AUnit.Format ( "Tests_Strings_Services" ) ) ;

  overriding
  procedure Register_Tests
    ( T: in out Test_Case );

  not overriding
  procedure Setup_Tests
    ( T : in out Test_Case );

  overriding
  procedure Tear_Down (T : in out Test_Case);

  -----------------------------------------------------------------------------
  --  tests cases
  -----------------------------------------------------------------------------

  procedure Test_Split
    (T : in out AUnit.Test_Cases.Test_Case'Class);

  procedure Test_Quote
    (T : in out AUnit.Test_Cases.Test_Case'Class);

private

  type Test_Case is new AUnit.Test_Cases.Test_Case with null record;

end Tests_Strings_Services.Test_Cases;

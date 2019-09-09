with Tests_Strings_Services.Test_Cases;
with Ada.Text_IO;

package body Tests_Strings_Services.Suites is

  pragma Check_Policy (Debug, On);

  package T_IO renames Ada.Text_IO;

  pragma Debug (T_IO.Put_Line ("tests_strings_services.suites"));
  Result : aliased AUnit.Test_Suites.Test_Suite;

  Test_Case : aliased Tests_Strings_Services.Test_Cases.Test_Case;

  function Suite
    return AUnit.Test_Suites.Access_Test_Suite
  is
  begin
    AUnit.Test_Suites.Add_Test (Result'Access, Test_Case'Access);

    return Result'Access;
  end Suite;

end Tests_Strings_Services.Suites;

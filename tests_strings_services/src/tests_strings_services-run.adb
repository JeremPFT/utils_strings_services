with Gnat.Traceback.Symbolic;
with Gnat.Traceback;
--  with GNAT.Exception_Traces;
with System.Assertions;

with Ada.Exceptions;
with Ada.Text_IO;

--  with GNAT.Traceback;
--  with GNAT.Traceback.Symbolic;

with AUnit.Run;
with AUnit.Reporter.Text;

with Tests_Strings_Services.Suites;

procedure Tests_Strings_Services.Run is

  pragma Check_Policy (Debug, On); -- -gnata

  package T_IO renames Ada.Text_IO;

  pragma Debug (T_IO.Put_Line ("tests_strings_services.run"));

  procedure Call_Stack is
    Trace  : Gnat.Traceback.Tracebacks_Array (1 .. 1_000);
    Length : Natural;
  begin
    Gnat.Traceback.Call_Chain (Trace, Length);
    T_IO.Put_Line (Gnat.Traceback.Symbolic.Symbolic_Traceback
                     (Trace (1 .. Length)));
  end Call_Stack;

  Reporter : AUnit.Reporter.Text.Text_Reporter;

  use Ada.Exceptions;

begin
  declare
    procedure Run is new AUnit.Run.Test_Runner
      (Tests_Strings_Services.Suites.Suite);
  begin
    Run (Reporter);
  end;

exception
   when Error: System.Assertions.Assert_Failure =>
     Call_Stack;
     T_IO.Put ("ASSERT exception: ");
     T_IO.Put_Line (Exception_Information(Error));
     raise;

   when Error: others =>
     Call_Stack;
     T_IO.Put ("Unexpected exception: ");
     T_IO.Put_Line (Exception_Information(Error));
     raise;

     --  GNAT.Exception_Traces.Trace_On
     --  (GNAT.Exception_Traces.Unhandled_Raise);

end Tests_Strings_Services.Run;

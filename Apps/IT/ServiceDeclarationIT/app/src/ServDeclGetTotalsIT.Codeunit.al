codeunit 12215 "Serv. Decl. Get Totals IT"
{
    TableNo = "Data Exch.";

    trigger OnRun()
    var
        DataExchField: Record "Data Exch. Field";
        DataExchFieldMapping: Record "Data Exch. Field Mapping";
        LocalServiceDeclarationMgt: Codeunit "Service Declaration Mgt. IT";
        DecVar: Decimal;
        TotalRoundedAmount: Integer;
    begin
        TotalRoundedAmount := 0;
        DataExchFieldMapping.SetRange("Data Exch. Def Code", Rec."Data Exch. Def Code");
        DataExchFieldMapping.SetRange("Data Exch. Line Def Code", Rec."Data Exch. Line Def Code");
        DataExchFieldMapping.SetRange("Field ID", 12220);
        if DataExchFieldMapping.FindLast() then begin
            DataExchField.SetRange("Data Exch. No.", Rec."Entry No.");
            DataExchField.SetRange("Column No.", DataExchFieldMapping."Column No.");
            if DataExchField.FindSet() then
                repeat
                    Evaluate(DecVar, DataExchField.GetValue());
                    TotalRoundedAmount += Round(DecVar, 1);
                until DataExchField.Next() = 0;
        end;

        LocalServiceDeclarationMgt.SetTotals(TotalRoundedAmount, DataExchField."Line No.");
    end;
}
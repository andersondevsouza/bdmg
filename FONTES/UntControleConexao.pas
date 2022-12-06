unit UntControleConexao;

interface

uses
  Windows, Messages, SysUtils, Classes,  Controls, Forms, Dialogs,
  Variants, Contnrs, StrUtils, inifiles, UntConexaoBD, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.DApt;

type
  TControleConexao = class
    private
      FConexaoBD: TConexaoBD;
      FQryGeral: TFDQuery;
    public
      constructor Create;
      destructor Destroy; override;

      property QryGeral: TFDQuery read FQryGeral write FQryGeral;
  end;

implementation

{ TControleConexao }

constructor TControleConexao.Create;
begin
  FConexaoBD  := TConexaoBD.Create;
  FQryGeral := TFDQuery.Create(nil);
  FQryGeral.Connection := FConexaoBD.FDConexao;
end;

destructor TControleConexao.Destroy;
begin

  inherited;
end;

end.

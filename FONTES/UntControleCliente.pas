unit UntControleCliente;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, ComCtrls, UntControleConexao, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.DApt,
  UntConexaoBD, Datasnap.DBClient, StrUtils, Math;

type
  TControleCliente = class
    private
      FId: Integer;
      FNome: String;
      FCpf: String;
      FStatus: String;
      FDataNascimento: TDate;

      FControleConexao: TControleConexao;
    public
      constructor Create(pControleConexao:TControleConexao);
      destructor Destroy; override;

      function Inserir: Boolean;
      function Alterar: Boolean;
      function Excluir: Boolean;
      function Pesquisar(Texto: String; cdsPesquisa: TClientDataSet): TControleCliente;
      function VerificarCPFValido(pCPF: string): Boolean;
      function VerificarCPFRepetido(pCPF: string): Boolean;


      property Id: Integer read FId write FId;
      property Nome: String read FNome write FNome;
      property Cpf: String read FCpf write FCpf;
      property Status: String read FStatus write FStatus;
      property DataNascimento: TDate read FDataNascimento write FDataNascimento;
  end;

implementation

{ TControleCliente }

function TControleCliente.Alterar: Boolean;
begin
  FControleConexao.QryGeral.SQL.Clear;
  FControleConexao.QryGeral.SQL.Add(' UPDATE clientes');
  FControleConexao.QryGeral.SQL.Add(' SET nome = :nome, ');
  FControleConexao.QryGeral.SQL.Add('     cpf = :cpf, ');
  FControleConexao.QryGeral.SQL.Add('     status = :status, ');
  FControleConexao.QryGeral.SQL.Add('     data_nascimento = :datanascimento ');
  FControleConexao.QryGeral.SQL.Add(' WHERE id = :id');
  FControleConexao.QryGeral.ParamByName('nome').AsString := Self.FNome;
  FControleConexao.QryGeral.ParamByName('cpf').AsString := Self.FCpf;
  FControleConexao.QryGeral.ParamByName('status').AsString := Self.FStatus;
  FControleConexao.QryGeral.ParamByName('datanascimento').AsDate := Self.FDataNascimento;
  FControleConexao.QryGeral.ParamByName('id').AsInteger := Self.FId;

  try
    FControleConexao.QryGeral.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

constructor TControleCliente.Create(pControleConexao: TControleConexao);
begin
  FControleConexao := pControleConexao;
end;

destructor TControleCliente.Destroy;
begin

  inherited;
end;

function TControleCliente.Excluir: Boolean;
begin
  FControleConexao.QryGeral.SQL.Clear;
  FControleConexao.QryGeral.SQL.Add(' DELETE FROM clientes WHERE id = :id');
  FControleConexao.QryGeral.ParamByName('id').AsInteger := Self.FId;

  try
    FControleConexao.QryGeral.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TControleCliente.Inserir: Boolean;
begin
  FControleConexao.QryGeral.SQL.Clear;
  FControleConexao.QryGeral.SQL.Add(' INSERT INTO clientes (nome, cpf, status, data_nascimento)');
  FControleConexao.QryGeral.SQL.Add('               VALUES (:nome, :cpf, :status, :datanascimento)');
  FControleConexao.QryGeral.ParamByName('nome').AsString := Self.FNome;
  FControleConexao.QryGeral.ParamByName('cpf').AsString := Self.FCpf;
  FControleConexao.QryGeral.ParamByName('status').AsString := Self.FStatus;
  FControleConexao.QryGeral.ParamByName('datanascimento').AsDate := Self.FDataNascimento;

  try
    FControleConexao.QryGeral.ExecSQL;
    Result := True;
  except
    Result := False;
  end;
end;

function TControleCliente.Pesquisar(Texto: String; cdsPesquisa: TClientDataSet): TControleCliente;
begin
  FControleConexao.QryGeral.SQL.Clear;
  FControleConexao.QryGeral.SQL.Add(' SELECT id, nome, status, cpf, data_nascimento');
  FControleConexao.QryGeral.SQL.Add('   FROM clientes');
  FControleConexao.QryGeral.SQL.Add('  WHERE nome like ''%'+Texto+'%'' ');
  FControleConexao.QryGeral.SQL.Add(' ORDER BY nome ');
  FControleConexao.QryGeral.Open;

  cdsPesquisa.EmptyDataSet;
  FControleConexao.QryGeral.First;
  while not FControleConexao.QryGeral.Eof do
  begin
    cdsPesquisa.Append;

    cdsPesquisa.FieldByName('id').AsInteger :=
      FControleConexao.QryGeral.FieldByName('id').AsInteger;
    cdsPesquisa.FieldByName('nome').AsString :=
      FControleConexao.QryGeral.FieldByName('nome').AsString;
    cdsPesquisa.FieldByName('status').AsString :=
      FControleConexao.QryGeral.FieldByName('status').AsString;
    cdsPesquisa.FieldByName('cpf').AsString :=
      FControleConexao.QryGeral.FieldByName('cpf').AsString;
    cdsPesquisa.FieldByName('data_nascimento').AsDateTime :=
      FControleConexao.QryGeral.FieldByName('data_nascimento').AsDateTime;

    cdsPesquisa.Post;

    FControleConexao.QryGeral.Next;
  end;
end;

function TControleCliente.VerificarCPFRepetido(pCPF: string): Boolean;
begin
  FControleConexao.QryGeral.SQL.Clear;
  FControleConexao.QryGeral.SQL.Add(' SELECT id, nome');
  FControleConexao.QryGeral.SQL.Add('   FROM clientes');
  FControleConexao.QryGeral.SQL.Add('  WHERE cpf = :cpf ');
  FControleConexao.QryGeral.ParamByName('cpf').AsString := pCPF;
  FControleConexao.QryGeral.Open;

  Result := False;
  if FControleConexao.QryGeral.RecordCount > 0 then
    Result := True;
end;

function TControleCliente.VerificarCPFValido(pCPF: string): Boolean;
var
  v: array [0 .. 1] of Word;
  cpf: array [0 .. 10] of Byte;
  I: Byte;
begin
  Result := False;

  if Length(pCPF) <> 11 then
  begin
    Exit;
  end;

  if pCPF = StringOfChar('0', 11) then
    Exit;

  if pCPF = StringOfChar('1', 11) then
    Exit;

  if pCPF = StringOfChar('2', 11) then
    Exit;

  if pCPF = StringOfChar('3', 11) then
    Exit;

  if pCPF = StringOfChar('4', 11) then
    Exit;

  if pCPF = StringOfChar('5', 11) then
    Exit;

  if pCPF = StringOfChar('6', 11) then
    Exit;

  if pCPF = StringOfChar('7', 11) then
    Exit;

  if pCPF = StringOfChar('8', 11) then
    Exit;

  if pCPF = StringOfChar('9', 11) then
    Exit;

  try
    for I := 1 to 11 do
      cpf[I - 1] := StrToInt(pCPF[I]);

    v[0] := 10 * cpf[0] + 9 * cpf[1] + 8 * cpf[2];
    v[0] := v[0] + 7 * cpf[3] + 6 * cpf[4] + 5 * cpf[5];
    v[0] := v[0] + 4 * cpf[6] + 3 * cpf[7] + 2 * cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] >= 10, 0, v[0]);

    v[1] := 11 * cpf[0] + 10 * cpf[1] + 9 * cpf[2];
    v[1] := v[1] + 8 * cpf[3] + 7 * cpf[4] + 6 * cpf[5];
    v[1] := v[1] + 5 * cpf[6] + 4 * cpf[7] + 3 * cpf[8];
    v[1] := v[1] + 2 * v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);

    Result := ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except
    on E: Exception do
      Result := False;
  end;
end;

end.

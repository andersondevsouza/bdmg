unit UntControleCliente;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, ComCtrls, UntControleConexao;

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
      function Pesquisar(Texto: String): TControleCliente;

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

function TControleCliente.Pesquisar(Texto: String): TControleCliente;
begin

end;

end.

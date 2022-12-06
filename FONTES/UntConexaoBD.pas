unit UntConexaoBD;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MSSQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, IniFiles, Forms, FMX.Dialogs;

type
  TConexaoBD = class
    private
      FFDConexao: TFDConnection;

      procedure LerArquivoConfig;
      procedure ConfigurarConexao(Server, DataBase, UserName, Password: String);
    public
      constructor Create;
      destructor Destroy; override;

      function GetConexao: TFDConnection;

      property FDConexao: TFDConnection read GetConexao;
  end;

implementation

{ TConexaoBD }

procedure TConexaoBD.ConfigurarConexao(Server, DataBase, UserName, Password: String);
var
  FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
begin
  try
    FDPhysMSSQLDriverLink1 := TFDPhysMSSQLDriverLink.Create(nil);
    FFDConexao := TFDConnection.Create(nil);
    FFDConexao.Params.DriverID := 'MSSQL';
    FFDConexao.Params.UserName := UserName;
    FFDConexao.Params.Password := Password;
    FFDConexao.Params.Database := DataBase;
    FFDConexao.Params.Add('server='+Server+' ');
    FFDConexao.Connected := True;
  finally
    if FFDConexao.Connected then begin
      FFDConexao.Close;
    end;
  end;
end;

constructor TConexaoBD.Create;
begin
  LerArquivoConfig;
end;

destructor TConexaoBD.Destroy;
begin
  FreeAndNil(FFDConexao);
  inherited;
end;

function TConexaoBD.GetConexao: TFDConnection;
begin
  Result := FFDConexao;
end;

procedure TConexaoBD.LerArquivoConfig;
var
  ArquivoINI, Servidor, Caminho, DriverName, UserName, PassWord, DataBase : string;
  LocalServer : Integer;
  Configuracoes : TIniFile;
begin
  ArquivoINI := ExtractFilePath(Application.ExeName) + '\config.ini';
  if not FileExists(ArquivoINI) then
  begin
    ShowMessage('Arquivo de Config não Encontrado - Entre em contato como suporte técnico!');
    Exit;
  end;

  Configuracoes := TIniFile.Create(ArquivoINI);
  try
    DataBase := Configuracoes.ReadString('SQLServer', 'DataBase', DataBase);
    Servidor := Configuracoes.ReadString('SQLServer', 'Servidor', Servidor);
    UserName := Configuracoes.ReadString('SQLServer', 'UserName', UserName);
    Password := Configuracoes.ReadString('SQLServer', 'Password', Password);

    ConfigurarConexao(Servidor, DataBase, UserName, Password);
  finally
    FreeAndNil(Configuracoes);
  end;
end;

end.

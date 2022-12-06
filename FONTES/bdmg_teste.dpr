program bdmg_teste;

uses
  Vcl.Forms,
  UntConexaoBD in 'UntConexaoBD.pas',
  UntControleConexao in 'UntControleConexao.pas',
  UntControleCliente in 'UntControleCliente.pas',
  UntCadCliente in 'UntCadCliente.pas' {FrmCadCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmCadCliente, FrmCadCliente);
  Application.Run;
end.

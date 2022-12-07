program bdmg_teste;

uses
  Vcl.Forms,
  UntConexaoBD in 'UntConexaoBD.pas',
  UntControleConexao in 'UntControleConexao.pas',
  UntControleCliente in 'UntControleCliente.pas',
  UntPadraoCadastro in 'UntPadraoCadastro.pas' {FrmPadraoCadastro},
  UntCadastroCliente in 'UntCadastroCliente.pas' {FrmCadastroCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmCadastroCliente, FrmCadastroCliente);
  Application.Run;
end.

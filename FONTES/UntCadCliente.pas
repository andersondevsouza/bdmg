unit UntCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntControleCliente, UntControleConexao, Vcl.StdCtrls;

type
  TFrmCadCliente = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FConexao: TControleConexao;
    FCliente: TControleCliente;
  public
    { Public declarations }
  end;

var
  FrmCadCliente: TFrmCadCliente;

implementation

{$R *.dfm}

procedure TFrmCadCliente.Button1Click(Sender: TObject);
begin
  FCliente.Nome := 'Testando';
  FCliente.Cpf := '39336397869';
  FCliente.Status := 'A';
  FCliente.DataNascimento := StrToDate('31/12/1989');
  FCliente.Inserir;
end;

procedure TFrmCadCliente.FormCreate(Sender: TObject);

begin
  FConexao := TControleConexao.Create;
  FCliente := TControleCliente.Create(FConexao);
end;

end.

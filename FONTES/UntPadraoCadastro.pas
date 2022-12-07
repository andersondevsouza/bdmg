unit UntPadraoCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TFrmPadraoCadastro = class(TForm)
    PageControl1: TPageControl;
    tsManutencao: TTabSheet;
    Bevel1: TBevel;
    tsPesquisa: TTabSheet;
    Bevel2: TBevel;
    DBGrid1: TDBGrid;
    ds: TDataSource;
    Panel2: TPanel;
    Label4: TLabel;
    edtPesquisar: TEdit;
    Panel1: TPanel;
    btnAdicionar: TButton;
    btnCancelar: TButton;
    btnGravar: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnPesquisar: TButton;
    Panel3: TPanel;
    Button1: TButton;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    FEdicaoInclusao: Boolean;
    FIdRegistro: Integer;
  private
    { Private declarations }
    procedure MostrarTabManutencao;
    procedure MostrarTabPesquisa;
    procedure AlterarState;
  public
    { Public declarations }
  end;

var
  FrmPadraoCadastro: TFrmPadraoCadastro;

implementation

{$R *.dfm}

procedure TFrmPadraoCadastro.AlterarState;
begin
  btnAdicionar.Enabled := not FEdicaoInclusao;
  btnCancelar.Enabled := FEdicaoInclusao;
  btnGravar.Enabled := FEdicaoInclusao;
  btnEditar.Enabled := (not FEdicaoInclusao) and (FIdRegistro > 0);
  btnExcluir.Enabled := (not FEdicaoInclusao) and (FIdRegistro > 0);
  btnPesquisar.Enabled := not FEdicaoInclusao;
end;

procedure TFrmPadraoCadastro.btnAdicionarClick(Sender: TObject);
begin
  FEdicaoInclusao := True;
  FIdRegistro := 0;
  AlterarState;
  MostrarTabManutencao;
end;

procedure TFrmPadraoCadastro.btnCancelarClick(Sender: TObject);
begin
  FEdicaoInclusao := False;
  AlterarState;
end;

procedure TFrmPadraoCadastro.btnEditarClick(Sender: TObject);
begin
  FEdicaoInclusao := True;
  MostrarTabManutencao;
  AlterarState;
end;

procedure TFrmPadraoCadastro.btnExcluirClick(Sender: TObject);
begin
  FEdicaoInclusao := False;
  MostrarTabManutencao;
  AlterarState;
end;

procedure TFrmPadraoCadastro.btnGravarClick(Sender: TObject);
begin
  FEdicaoInclusao := False;
  AlterarState;
end;

procedure TFrmPadraoCadastro.btnPesquisarClick(Sender: TObject);
begin
  FEdicaoInclusao := False;
  FIdRegistro := 0;
  AlterarState;
  MostrarTabPesquisa;
end;

procedure TFrmPadraoCadastro.Button1Click(Sender: TObject);
begin
  FEdicaoInclusao := False;
  FIdRegistro := 0;
  AlterarState;
  MostrarTabManutencao;
end;

procedure TFrmPadraoCadastro.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
    MostrarTabManutencao;
end;

procedure TFrmPadraoCadastro.FormCreate(Sender: TObject);
begin
  tsPesquisa.TabVisible := False;
  AlterarState;
end;

procedure TFrmPadraoCadastro.MostrarTabManutencao;
begin
  tsPesquisa.TabVisible := False;
  tsManutencao.TabVisible := True;
  tsManutencao.Show;
end;

procedure TFrmPadraoCadastro.MostrarTabPesquisa;
begin
  tsPesquisa.TabVisible := True;
  tsManutencao.TabVisible := False;
  tsPesquisa.Show;
end;

end.

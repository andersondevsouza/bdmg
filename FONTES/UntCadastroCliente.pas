unit UntCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntPadraoCadastro, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, UntControleCliente, UntControleConexao, Datasnap.DBClient,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.DApt;

type
  TFrmCadastroCliente = class(TFrmPadraoCadastro)
    Label1: TLabel;
    edtNome: TEdit;
    edtCpf: TEdit;
    Label2: TLabel;
    rgStatus: TRadioGroup;
    edtDataNascimento: TDateTimePicker;
    Label3: TLabel;
    cdsPesquisa: TClientDataSet;
    cdsPesquisaid: TIntegerField;
    cdsPesquisanome: TStringField;
    cdsPesquisastatus: TStringField;
    cdsPesquisacpf: TStringField;
    cdsPesquisadata_nascimento: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
  private
    { Private declarations }
    FConexao: TControleConexao;
    FCliente: TControleCliente;
    procedure PopulaDadosCliente;
    procedure PesquisarCliente;
    procedure LimparRegistro;
  public
    { Public declarations }
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

{$R *.dfm}

procedure TFrmCadastroCliente.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  LimparRegistro;
  edtNome.SetFocus;
end;

procedure TFrmCadastroCliente.btnEditarClick(Sender: TObject);
begin
  inherited;
  edtNome.Text := cdsPesquisanome.Text;
  edtCpf.Text := cdsPesquisacpf.Text;
  edtDataNascimento.Date := cdsPesquisadata_nascimento.AsDateTime;

  rgStatus.ItemIndex := 1;
  if cdsPesquisastatus.AsString = 'A' then
    rgStatus.ItemIndex := 0;
end;

procedure TFrmCadastroCliente.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox('ATENÇÃO: Deseja realmente excluir o registro selecionado?',
    'Pergunta', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    if FCliente.Excluir then
    begin
      ShowMessage('Registro excluido com sucesso!');
      LimparRegistro;
    end;
  end;
end;

procedure TFrmCadastroCliente.btnGravarClick(Sender: TObject);
begin
  inherited;
  PopulaDadosCliente;

  if FCliente.Id > 0 then
  begin
    if FCliente.Alterar then
      ShowMessage('Cliente Alterado com Sucesso!');
  end
  else
  begin
    FCliente.Inserir;
  end;
end;

procedure TFrmCadastroCliente.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  cdsPesquisa.EmptyDataSet;
  edtPesquisar.Clear;
end;

procedure TFrmCadastroCliente.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Return then
  begin
    if cdsPesquisa.RecordCount = 0 then
      exit;

    FIdRegistro := cdsPesquisaid.AsInteger;
    FCliente.Id := FIdRegistro;
    inherited;

    btnEditarClick(Sender);
  end;

end;

procedure TFrmCadastroCliente.edtCpfExit(Sender: TObject);
begin
  inherited;
  if not FCliente.VerificarCPFValido(edtCpf.Text) then
  begin
    ShowMessage('CPF Inválido. Verifique!');
    edtCpf.Clear;
  end;

  if FCliente.VerificarCPFRepetido(edtCpf.Text) then
  begin
    ShowMessage('CPF Já cadastrado. Verifique!');
    edtCpf.Clear;
  end;
end;

procedure TFrmCadastroCliente.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  PesquisarCliente;
end;

procedure TFrmCadastroCliente.FormCreate(Sender: TObject);
begin
  inherited;
  FConexao := TControleConexao.Create;
  FCliente := TControleCliente.Create(FConexao);
  cdsPesquisa.CreateDataSet;
end;

procedure TFrmCadastroCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FConexao);
  FreeAndNil(FCliente);
end;

procedure TFrmCadastroCliente.LimparRegistro;
begin
  edtNome.Clear;
  edtCpf.Clear;
  edtDataNascimento.Date := Date;
  rgStatus.ItemIndex := 0;
  cdsPesquisa.EmptyDataSet;
  FIdRegistro := 0;
end;

procedure TFrmCadastroCliente.PesquisarCliente;
var
  QryAux: TFDQuery;
begin
  inherited;
  if edtPesquisar.Text = '' then
  begin
    cdsPesquisa.EmptyDataSet;
    exit;
  end;

  FCliente.Pesquisar(edtPesquisar.Text, cdsPesquisa);

  {QryAux := FCliente.Pesquisar(edtPesquisar.Text, cdsPesquisa);
  try
    QryAux.Open;
    QryAux.First;
    while not QryAux.Eof do
    begin
      cdsPesquisa.Append;
      cdsPesquisaid.AsInteger := QryAux.FieldByName('id').AsInteger;
      cdsPesquisanome.AsString := QryAux.FieldByName('nome').AsString;
      cdsPesquisastatus.AsString := QryAux.FieldByName('status').AsString;
      cdsPesquisacpf.AsString := QryAux.FieldByName('cpf').AsString;
      cdsPesquisadata_nascimento.AsDateTime := QryAux.FieldByName('data_nascimento').AsDateTime;
      cdsPesquisa.Post;

      QryAux.Next;
    end;
  finally
    FreeAndNil(QryAux);
  end;}
end;

procedure TFrmCadastroCliente.PopulaDadosCliente;
begin
  FCliente.Id := cdsPesquisaid.AsInteger;
  FCliente.Nome := edtNome.Text;
  FCliente.Cpf := edtCpf.Text;
  FCliente.Status := 'A';
  if rgStatus.ItemIndex = 1 then
    FCliente.Status := 'I';
  FCliente.DataNascimento := edtDataNascimento.Date;
end;

end.

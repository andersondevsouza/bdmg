inherited FrmCadastroCliente: TFrmCadastroCliente
  Caption = 'FrmCadastroCliente'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    ActivePage = tsManutencao
    ExplicitHeight = 207
    inherited tsManutencao: TTabSheet
      ExplicitHeight = 179
      object Label1: TLabel [1]
        Left = 6
        Top = 3
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label2: TLabel [2]
        Left = 6
        Top = 43
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object Label3: TLabel [3]
        Left = 303
        Top = 43
        Width = 81
        Height = 13
        Caption = 'Data Nascimento'
      end
      object edtNome: TEdit [4]
        Left = 6
        Top = 20
        Width = 479
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object edtCpf: TEdit [5]
        Left = 6
        Top = 60
        Width = 121
        Height = 21
        TabOrder = 1
        OnExit = edtCpfExit
      end
      object rgStatus: TRadioGroup [6]
        Left = 136
        Top = 44
        Width = 157
        Height = 39
        Caption = 'Status'
        Columns = 2
        Ctl3D = True
        Items.Strings = (
          'Ativo'
          'Inativo')
        ParentCtl3D = False
        TabOrder = 2
      end
      object edtDataNascimento: TDateTimePicker [7]
        Left = 303
        Top = 60
        Width = 98
        Height = 21
        Date = 44901.713039618060000000
        Time = 44901.713039618060000000
        TabOrder = 3
      end
      inherited Panel1: TPanel
        TabOrder = 4
        ExplicitLeft = 0
        ExplicitTop = 185
        ExplicitWidth = 494
        inherited btnAdicionar: TButton
          ExplicitLeft = 3
          ExplicitTop = 3
          ExplicitHeight = 32
        end
        inherited btnCancelar: TButton
          ExplicitLeft = 84
          ExplicitTop = 3
          ExplicitHeight = 32
        end
        inherited btnGravar: TButton
          ExplicitLeft = 165
          ExplicitTop = 3
          ExplicitHeight = 32
        end
        inherited btnEditar: TButton
          ExplicitLeft = 246
          ExplicitTop = 3
          ExplicitHeight = 32
        end
        inherited btnExcluir: TButton
          ExplicitLeft = 327
          ExplicitTop = 3
          ExplicitHeight = 32
        end
        inherited btnPesquisar: TButton
          ExplicitLeft = 412
          ExplicitTop = 3
          ExplicitHeight = 32
        end
      end
    end
    inherited tsPesquisa: TTabSheet
      inherited DBGrid1: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            ReadOnly = True
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            ReadOnly = True
            Width = 294
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cpf'
            ReadOnly = True
            Visible = True
          end>
      end
      inherited Panel2: TPanel
        ExplicitLeft = 3
        ExplicitTop = 3
        inherited edtPesquisar: TEdit
          OnChange = edtPesquisarChange
        end
      end
      inherited Panel3: TPanel
        inherited Button1: TButton
          ExplicitLeft = 406
          ExplicitTop = 3
          ExplicitHeight = 32
        end
      end
    end
  end
  inherited ds: TDataSource
    DataSet = cdsPesquisa
    Left = 359
  end
  object cdsPesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 322
    Top = 122
    object cdsPesquisaid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object cdsPesquisanome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 50
    end
    object cdsPesquisastatus: TStringField
      DisplayLabel = 'Status'
      FieldName = 'status'
      Size = 1
    end
    object cdsPesquisacpf: TStringField
      DisplayLabel = 'Cpf'
      FieldName = 'cpf'
      Size = 11
    end
    object cdsPesquisadata_nascimento: TDateField
      DisplayLabel = 'Data Nascimento'
      FieldName = 'data_nascimento'
    end
  end
end

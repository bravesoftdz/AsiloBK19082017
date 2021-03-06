unit UProfissionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls,
  jpeg, ExtCtrls,
  Buttons,
  FMTBcd, DB, SqlExpr;

type
  TProfissionais = class(TForm)
    Image1: TImage;
    Baixo: TPanel;
    Direita: TBitBtn;
    Esquerda: TBitBtn;
    btnInserir: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnEditar: TBitBtn;
    btnDeletar: TBitBtn;
    LadoEsquerdo: TPanel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    sqlAux: TSQLQuery;
    procedure btnDeletarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure EsquerdaClick(Sender: TObject);
    procedure DireitaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Profissionais: TProfissionais;

implementation

uses UModulo;

{$R *.dfm}

procedure TProfissionais.btnDeletarClick(Sender: TObject);
begin
IF (DBEdit1.Text = '')
then
begin
   MessageDlg ('N�o a registros no banco',
                       mtWarning,
                       [mbyes,mbno],
                       0)
end
else
begin
          DBEdit2.Enabled       := false;
          DBEdit3.Enabled       := false;
          DBEdit4.Enabled       := false;
          DBEdit5.Enabled       := false;

 If
           MessageDlg ('Voc� tem certeza que deseja excluir?',
                       mtWarning,
                       [mbyes,mbno],
                       0)
          = mryes Then Begin
                         Modulo.cdsProfisional.Delete;
                         Modulo.cdsProfisional.ApplyUpdates(-1);
                         ShowMessage ('Registro Excluido com sucesso!');
                       End
                  Else Begin
                          ShowMessage ('Nenhum registro deletado!');
                       End;
                       end;
end;

procedure TProfissionais.btnInserirClick(Sender: TObject);
Var NReg : integer;
begin

          btnInserir.Enabled    := False;
          btnDeletar.Enabled    := False;

          btnEditar.Enabled     := False;
          Direita.Enabled       := False;
          Esquerda.Enabled      := False;


          DBEdit2.Enabled       := True;
          DBEdit3.Enabled       := True;
          DBEdit4.Enabled       := True;
          DBEdit5.Enabled       := True;


          btnGravar.Enabled      := True;



          sqlAux.Close;


          sqlAux.SQL.Clear;
          sqlAux.SQL.Add('SELECT MAX(COD_PRO) AS ULTIMO FROM PROFISSIONAIS ');

          sqlAux.Open;
           If sqlAux.FieldByName('ULTIMO').Value = Null
           Then NReg :=1
           Else NReg := sqlAux.FieldByName('ULTIMO').Value + 1;

           Modulo.cdsProfisional.Insert;


           Modulo.cdsProfisionalCOD_PRO.Value := NReg;


           DBEdit2.SetFocus;
end;

procedure TProfissionais.btnEditarClick(Sender: TObject);
begin
Modulo.cdsProfisional.Edit;
          btnInserir.Enabled    := False;
          btnDeletar.Enabled    := False;

          btnEditar.Enabled     := False;
          Direita.Enabled       := False;
          Esquerda.Enabled      := False;

          DBEdit2.Enabled       := True;
          DBEdit3.Enabled       := True;
          DBEdit4.Enabled       := True;
          DBEdit5.Enabled       := True;

          btnGravar.Enabled      := True;
end;

procedure TProfissionais.btnCancelarClick(Sender: TObject);
begin
Modulo.cdsProfisional.Cancel;
          
          DBEdit2.Enabled       := false;
          DBEdit3.Enabled       := false;
          DBEdit4.Enabled       := false;
          DBEdit5.Enabled       := false;

          btnInserir.Enabled    := True;
          btnDeletar.Enabled    := True;

          btnEditar.Enabled     := True;
          Direita.Enabled       := True;
          Esquerda.Enabled      := True;

          // Ligar o Gravar
          btnGravar.Enabled      := False;
end;

procedure TProfissionais.btnGravarClick(Sender: TObject);
begin
Modulo.cdsProfisional.Post;

         Modulo.cdsProfisional.ApplyUpdates(-1);

         btnCancelar.Click;
end;

procedure TProfissionais.EsquerdaClick(Sender: TObject);
begin
Modulo.cdsProfisional.Next;
end;

procedure TProfissionais.DireitaClick(Sender: TObject);
begin
Modulo.cdsProfisional.Prior;
end;

end.

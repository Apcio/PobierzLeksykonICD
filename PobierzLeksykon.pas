unit PobierzLeksykon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.StrUtils, System.IOUtils,
  mshtml, System.UITypes, system.Types, Vcl.OleCtrls, SHDocVw,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.DApt.Column, FireDAC.DApt;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    FDMemTable1: TFDMemTable;
    Button8: TButton;
    Label1: TLabel;
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Label2: TLabel;
    FDConnection2: TFDConnection;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
    strona: string;
    podstrony: TArray<string>;

    procedure testMemo(i: integer);

    procedure rozpocznijOdPunktu(start: string);
    procedure pobierzListeStron(str: string);

    procedure zapiszStrone(strona: string; nazwa: string);

    procedure inicjalizacjaMemTable();
    procedure przeniesDaneDoBazy(pol: TFDConnection);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button10Click(Sender: TObject);
begin
  FDPhysFBDriverLink1.VendorLib := 'C:\Praca\Projekty\DLL\fbclient.dll';
  FDConnection2.Close();
  FDConnection2.Params.Clear();
  FDConnection2.Params.Add('Server=10.0.0.2');
  FDConnection2.Params.Add('Protocol=TCPIP');
  FDConnection2.Params.Add('Database=E:\mlm\dane\mlm.fdb');
  FDConnection2.Params.Add('User_Name=SYSDBA');
  FDConnection2.Params.Add('Password=Krist7');
  FDConnection2.Params.Add('CharacterSet=WIN1250');
  FDConnection2.Params.Add('DriverID=FB');
  FDConnection2.Open();

  if FDConnection2.Connected = True then
    Label2.Caption := 'Po³¹czono'
  else
    Label2.Caption := 'Brak po³¹czenia';
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  przeniesDaneDoBazy(FDConnection2);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  strona := IdHTTP1.Get('http://www.leksykon.com.pl/icd.html#icd-A.html');
  Memo1.Lines.Add(strona);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  strona := IdHTTP1.Get('http://www.leksykon.com.pl/icd-a.html');
  Memo1.Lines.Add(strona);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  rozpocznijOdPunktu('icd-A.html');
end;

procedure TForm1.rozpocznijOdPunktu(start: string);
var
  znaleziona: string;
  pozycjaStart: integer;
  pozycjaStop: integer;
begin
  podstrony := [];
  Memo1.Lines.Clear();
  strona := IdHTTP1.Get('http://www.leksykon.com.pl/icd.html#' + start);
  pozycjaStart := PosEx('href="' + start, strona, 1);

  while pozycjaStart > 0 do
  begin
    pozycjaStart := PosEx('href="icd-', strona, pozycjaStart);
    if pozycjaStart = 0 then break;

    znaleziona := '';

    pozycjaStop := PosEx('"', strona, pozycjaStart + 6);
    znaleziona := Copy(strona, pozycjaStart + 6, pozycjaStop - pozycjaStart - 6);

    pozycjaStart := pozycjaStart + (pozycjaStop - pozycjaStart - 6);

    if znaleziona <> '' then
    begin
      Memo1.Lines.Add('Ga³¹Ÿ: ' + znaleziona);
      pobierzListeStron(znaleziona);
    end;

  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  testMemo(3);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  rozpocznijOdPunktu('icd-O.html');
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  plik: string;
  listaPlikow: TStringDynArray;
  wbrowser: Twebbrowser;
  dokument: IHTMLDocument3;
  elementy: IHTMLElementCollection;
  elem: IHTMLInputElement;
  i: integer;
  tresc: string;
begin
  listaPlikow := TDirectory.GetFiles(TPath.GetDirectoryName(Application.ExeName) + '/HTML/');
  wbrowser := TWebBrowser.Create(Self);

  for plik in listaPlikow do
  begin
    wbrowser.Navigate('file:///' + plik);
    dokument := wbrowser.Document As IHTMLDocument3;
    if Assigned(dokument) then
    begin
      elementy := dokument.getElementsByTagName('SPAN');

      for i := 0 to elementy.length - 1 do
      begin
        elem := elementy.item(i, EmptyParam) As IHTMLInputElement;
        tresc := elem.src;
        tresc := elem.lowsrc;
        tresc := elem.vrml;
        tresc := elem.dynsrc;
      end;



    end;
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  plik: string;
  trescPliku: string;
  listaPlikow: TStringDynArray;
  pozStart: integer;
  pozStop: integer;
  symbol: string;
  opis: string;

begin
  inicjalizacjaMemTable();
  listaPlikow := TDirectory.GetFiles(TPath.GetDirectoryName(Application.ExeName) + '/HTML/');
  Memo1.Lines.Clear();

  for plik in listaPlikow do
  begin
    trescPliku := TFile.ReadAllText(plik, TEncoding.UTF8);
   { if AnsiPos('Dostêpne produkty lecznicze', trescPliku) > 0 then
      Continue;
    if AnsiPos('<b>Brak produkt', trescPliku) > 0 then
      Continue;}

    Memo1.Lines.Add('Przetwarzam: ' + TPath.GetFileName(plik));

    pozStart := 1;
    while pozStart > 0 do
    begin
      //symbol
      pozStart := PosEx('<strong>', trescPliku, pozStart);
      if pozStart = 0 then
        break;

      pozStop := PosEx('</strong>', trescPliku, pozStart);
      symbol := Copy(trescPliku, pozStart + 8, pozStop - pozStart - 8);
      pozStart := pozStart + 8;

      //opis
      pozStart := PosEx('<span>', trescPliku, pozStart);
      if pozStart = 0 then
        break;

      pozStop := PosEx('</span>', trescPliku, pozStart);
      opis := Copy(trescPliku, pozStart + 6, pozStop - pozStart - 6);
      pozStart := pozStart + 7;

      opis := StringReplace(opis, '&oacute;', 'ó', [rfReplaceAll]);

      if FDMemTable1.Locate('SYMBOL_CHOROBY', symbol, []) = False then
      begin
        Memo1.Lines.Add('Dodajê: ' + symbol + ': ' + opis);

        FDMemTable1.Append();
        FDMemTable1.FieldByName('SYMBOL_CHOROBY').AsString := symbol;
        FDMemTable1.FieldByName('OPIS_CHOROBY').AsString := opis;
        FDMemTable1.FieldByName('KLASYFIKACJA_ICD').AsString := 'ICD-10';
        FDMemTable1.Post();
      end;

    end;

  end;

  Memo1.Lines.Add('');
  Memo1.Lines.Add('Koniec');
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  FDPhysFBDriverLink1.VendorLib := 'C:\Praca\Projekty\DLL\fbclient.dll';
  FDConnection1.Close();
  FDConnection1.Params.Clear();
  FDConnection1.Params.Add('Server=localhost');
  FDConnection1.Params.Add('Protocol=TCPIP');
  FDConnection1.Params.Add('Database=C:\Praca\Projekty\euco\Synergia\dane\mlm.fdb');
  FDConnection1.Params.Add('User_Name=SYSDBA');
  FDConnection1.Params.Add('Password=masterkey');
  FDConnection1.Params.Add('CharacterSet=WIN1250');
  FDConnection1.Params.Add('DriverID=FB');
  FDConnection1.Open();

  if FDConnection1.Connected = True then
    Label1.Caption := 'Po³¹czono'
  else
    Label1.Caption := 'Brak po³¹czenia';
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  przeniesDaneDoBazy(FDConnection1);
end;

procedure TForm1.pobierzListeStron(str: string);
var
  znaleziona: string;
  pozycjaStart: integer;
  pozycjaStop: integer;
  pobranaStrona: string;
begin
  try
    pobranaStrona := IdHTTP1.Get('http://www.leksykon.com.pl/' + str);
  except
    on e: Exception do
    begin
      pobierzListeStron(str);
      Exit();
    end;
  end;
  zapiszStrone(pobranaStrona, str);
  pozycjaStart := 1;

  while pozycjaStart > 0 do
  begin
    pozycjaStart := PosEx('href="icd-', pobranaStrona, pozycjaStart);
    if pozycjaStart = 0 then break;

    znaleziona := '';

    pozycjaStop := PosEx('"', pobranaStrona, pozycjaStart + 6);
    znaleziona := Copy(pobranaStrona, pozycjaStart + 6, pozycjaStop - pozycjaStart - 6);

    if AnsiMatchStr(znaleziona, podstrony) = True then
      znaleziona := ''
    else
      podstrony := podstrony + [znaleziona];

    pozycjaStart := pozycjaStart + (pozycjaStop - pozycjaStart - 6);

    if znaleziona <> '' then
    begin
      Memo1.Lines.Add(znaleziona);
      pobierzListeStron(znaleziona);
    end;
  end;

end;

procedure TForm1.testMemo(i: integer);
var
a: string;
begin
  a := 'aa';
  Dec(i);
  Memo1.Lines.Add(a);
  if i > 0 then
    testMemo(i);
end;

procedure TForm1.zapiszStrone(strona: string; nazwa: string);
var
  sciezka: string;
begin
  sciezka := TPath.GetDirectoryName(Application.ExeName);

  if TDirectory.Exists(sciezka + '/HTML/') = False then
    TDirectory.CreateDirectory(sciezka + '/HTML/');

  TFile.AppendAllText(sciezka + '/HTML/' + nazwa, strona, TEncoding.UTF8);
end;

procedure TForm1.inicjalizacjaMemTable();
begin
  FDMemTable1.Close();
  FDMemTable1.FieldDefs.Clear();
  FDMemTable1.FieldDefs.Add('SYMBOL_CHOROBY', ftString, 10);
  FDMemTable1.FieldDefs.Add('KLASYFIKACJA_ICD', ftString, 6);
  FDMemTable1.FieldDefs.Add('OPIS_CHOROBY', ftString, 200);

  FDMemTable1.Open();
end;

procedure TForm1.przeniesDaneDoBazy(pol: TFDConnection);
var
  fdq: TFDQuery;
  gen: Integer;
begin
  if pol.Connected = False then
  begin
    Memo1.Lines.Add('Brak po³¹czenia');
    Exit();
  end;

  if FDMemTable1.Active = False then
  begin
    Memo1.Lines.Add('Nie ma danych w MemoTable');
    Exit();
  end;

  FDMemTable1.IndexFieldNames := 'SYMBOL_CHOROBY:A';

  fdq := TFDQuery.Create(Self);
  fdq.Connection := pol;

  fdq.SQL.Text := 'SELECT GEN_ID(ID_SLW_SYMBOLE_CHOROB_GEN, 0) AS GEN FROM RDB$DATABASE';
  fdq.Open();
  gen := fdq.FieldByName('GEN').AsInteger;
  fdq.Close();


  fdq.SQL.Text := 'SELECT * FROM SLW_SYMBOLE_CHOROB';
  fdq.Open();

  fdq.BeginBatch();
  FDMemTable1.First();

  while FDMemTable1.Eof = False do
  begin
    Inc(gen);
    fdq.Append();
    fdq.FieldByName('ID_SLW_SYMBOLE_CHOROB').AsInteger := gen;
    fdq.FieldByName('SYMBOL_CHOROBY').AsString := FDMemTable1.FieldByName('SYMBOL_CHOROBY').AsString;
    fdq.FieldByName('KLASYFIKACJA_ICD').AsString := FDMemTable1.FieldByName('KLASYFIKACJA_ICD').AsString;
    fdq.FieldByName('OPIS_CHOROBY').AsString := FDMemTable1.FieldByName('OPIS_CHOROBY').AsString;
    fdq.Post();

    FDMemTable1.Next();
  end;
  fdq.EndBatch();

  fdq.Close();
  fdq.SQL.Text := 'ALTER SEQUENCE ID_SLW_SYMBOLE_CHOROB_GEN RESTART WITH ' + gen.ToString();
  fdq.ExecSQL();
  fdq.Close();

  fdq.Free();

  Memo1.Lines.Add('Przeniesiono dane');
end;

end.

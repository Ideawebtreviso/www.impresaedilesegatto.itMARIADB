using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

using MySqlConnector;
using Newtonsoft.Json;

//PDF
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

using System.Data;
using NCalc;

/// <summary>
/// Descrizione di riepilogo per StampaPDF
/// </summary>
public class StampaPDF
{
	public StampaPDF()
	{
		//
		// TODO: aggiungere qui la logica del costruttore
		//
	}

    public static void stampaPDF(int idStampa, String path, String pathImmagini, String pathPublic, String connectionString)
    {
        OpzioniStampa opzioniStampa = new OpzioniStampa(idStampa, connectionString);
        int idComputo = opzioniStampa.idComputo;
        DatiComputo datiComputo = new DatiComputo(idComputo, connectionString);

        Suddivisione root = Suddivisione.getSuddivisioneRoot(idComputo, connectionString);
        root.descrizione = opzioniStampa.titolocomputo;
        //List<Suddivisione> listaSuddivisioni = Suddivisione.getTutteLeSuddivisioniOrdinate(root);

        // arrivato qui ho listaSuddivisioni. ogni suddivisione contiene le proprie informazioni + la sua lista di voci. Ogni voce ha le sue misure.
        // le suddivisioni hanno settate correttamente le suddivisioni figli.
        //modelli_generazione_pdf_genera_pdf.generaPDF(Server.MapPath("~/modelli/generazione-pdf/PDF/test.pdf"), listaSuddivisioni);
        modelli_generazione_pdf_genera_pdf.generaPDF(path, root, datiComputo, opzioniStampa, pathImmagini, pathPublic);
    }
}

public partial class modelli_generazione_pdf_genera_pdf : System.Web.UI.Page
{
    //DIMENSIONI FOGLIO A4
    const int height = 1122;
    const int width = 793;
    const int foglio_marginLeftRight = 40;
    const int foglio_marginTopBottom = 40;
    const int foglio_width = width - (foglio_marginLeftRight * 2);
    const int foglio_height = height - (foglio_marginTopBottom * 2);
    const string formatoValutaMigliaia = "€ #,0.00";
    const string formatoMigliaia = "#,0.00";

    static Font ArialTitoloDiStampa = FontFactory.GetFont("Arial", 24, Font.NORMAL);

    static Font ArialTitoloBold = FontFactory.GetFont("Arial", 15, Font.BOLD);
    static Font ArialTitoloNormal = FontFactory.GetFont("Arial", 15, Font.NORMAL);

    static Font ArialGrandeBold = FontFactory.GetFont("Arial", 11, Font.BOLD);
    static Font ArialGrandeNormal = FontFactory.GetFont("Arial", 11, Font.NORMAL);
    static Font ArialGrandeUnderline = FontFactory.GetFont("Arial", 11, Font.UNDERLINE);

    /* da 9 a 11 */
    static Font ArialBold = FontFactory.GetFont("Arial", 11, Font.BOLD);
    static Font ArialNormal = FontFactory.GetFont("Arial", 11, Font.NORMAL);
    static Font ArialUnderline = FontFactory.GetFont("Arial", 11, Font.UNDERLINE);
    /*
    static Font ArialPiccoloBold = FontFactory.GetFont("Arial", 7, Font.BOLD);
    static Font ArialPiccoloNormal = FontFactory.GetFont("Arial", 7, Font.NORMAL);
    */
    static BaseColor baseColor_Nero = BaseColor.BLACK;
    static BaseColor baseColor_Bianco = BaseColor.WHITE;
    static BaseColor baseColor_Verde = new BaseColor(72, 185, 77);
    static BaseColor baseColor_Blu = BaseColor.BLUE;

    static String pathImmagini = "";
    static String pathPublic = "";

    static String cod_Rosso = "##";
    static String cod_Bold = "#*";
    static String cod_Sottolineato = "#_";
    static String cod_cancellato = "#-";

    static PdfPTable tableComputo;

    static Boolean stampaNumeroPagina = false;
    //Y ATTUALE: USARLO PER POSIZIONARE ELEMENTI NELLA PAGINA IN MODO ASSOLUTO
    //LAVORA AL CONTRARIO (DA HEIGHT A 0)
    //AD OGNI OGGETTO AGGIUNTO VADO A SOTTRARLO DELLA DIMENSIONE DELL'OGGETTO.
    //ALLA GENERAZIONE DI UNA NUOVA PAGINA VIENE RESETTATO
    static int yattuale;

    /*htt p : // ww w.devshed. com/c/a/java/creating-simple-pdf-files-with-itextsharp/
    paragrafo1.SpacingBefore = 72;
    paragrafo1.SpacingAfter = 72;
    paragrafo1.IndentationLeft = 72;
    paragrafo1.IndentationRight = 72;*/


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static void resettayperNuovoFoglio()
    {
        yattuale = height;
    }

    /*protected void ClickMe_Command(object sender, CommandEventArgs e)
    {
        Boolean generato = generaPDF(Server.MapPath("~/modelli/generazione-pdf/PDF/test.pdf"));

        if (generato)
            Response.Redirect("~/modelli/generazione-pdf/PDF/test.pdf");
        else
            Response.Write("<script>alert('c è stato un errore nella generazione..')</script>");
    }*/

    public static String generaPDF(String path, Suddivisione root, DatiComputo datiComputo, OpzioniStampa opzioniStampa, String pathImmagini_, String pathPublic_)
    {
        stampaNumeroPagina = opzioniStampa.stampaNumeroPagina;
        pathImmagini = pathImmagini_;
        pathPublic = pathPublic_;

        //bool conPrezzo = opzioniStampa.stampaPrezzi;
        Int32 idComputo = datiComputo.id;
        String titolo = datiComputo.titolo;
        String cliente = datiComputo.nominativoCliente;

        List<Suddivisione> listaSuddivisioni = Suddivisione.getTutteLeSuddivisioniOrdinate(root);

        String jsonString = "";

        Boolean generato = false;
        try
        {
            //GENERO UN DOCUMENTO
            //COSTRUTTORE: DIMENSIONI, MARGINI: LEFT, RIGHT, TOP, BOTTOM
            //BOTTOM PIU ALTO PERCHè DEVE STARCI IL FOOTER ^_^
            var doc1 = new Document(new Rectangle(width, height), 5, 5, 5, 50);
            doc1.SetMargins(foglio_marginLeftRight, foglio_marginTopBottom, foglio_marginLeftRight, foglio_marginTopBottom);

            //ISTANZIO UN OGGETTO CHE SCRIVE NEL DOCUMENTO
            PdfWriter writer = PdfWriter.GetInstance(doc1, new FileStream(path, FileMode.Create));

            //AGGIUNGO EVENTO PER GENERARE IL FOOTER ALLA CREAZIONE DI UNA NUOVA PAGINA
            writer.PageEvent = new MainTextEventsHandler();

            doc1.Open();

            //AGGIUNGO UN PARAGRAFO
            PdfPTable table; PdfPCell cella; Paragraph paragrafo;
            PdfContentByte cb = writer.DirectContent;

            // testo nero (default)
            //cb.SetColorStroke(baseColor_Nero); non funziona perchè quando disegno un rettangolo il fill mi sovrascrive anche lo stroke
            cb.SetColorFill(baseColor_Nero);

            // PRIMA PAGINA (copertina)
            if (opzioniStampa.stampaCopertina) {
                disegnaPaginaCopertina(doc1, writer, datiComputo, opzioniStampa);

                // termina qui la pagina
                doc1.NewPage();
            }

            // SECONDA PAGINA (condizioniprimapagina)
            /*if (datiComputo.condizioniprimapagina != "") {
                disegnaPaginaCondizioniPrimaPagina(doc1, writer, datiComputo, opzioniStampa);
                // termina qui la pagina
                doc1.NewPage();
            }*/

            // SECONDA PAGINA (suddivisioni)
            //if (opzioniStampa.stampaSuddivisioni) { -> commentato FINE 2019 / INIZIO 2020
            if (opzioniStampa.stampaSuddivisioni) { // aggiunto 2020/07/24
                disegnaSecondaPagina(doc1, writer, datiComputo, root, opzioniStampa);

                if (datiComputo.condizioniprimapagina != "")
                    disegnaPaginaCondizioniPrimaPagina(doc1, writer, datiComputo, opzioniStampa);

                // termina qui la pagina
                doc1.NewPage();
            }

            //NOTA: NECESSARIO SE PRIMA DI FARE TABELLA
            //USO UN ELEMENTO DI UN COLORE DIVERSO
            //TUTTE LE RIGHE DELLA TABELLA DEL FOGLIO ATTUALE SONO AFFETTE DAL COLORE GIALLO
            //AGGIUNGERE QUESTE RIGHE PER COLORARE DI NERO IL TESTO DELLA TABELLA.
            PdfContentByte colore = writer.DirectContent;
            colore.SetColorFill(BaseColor.BLACK);

            // ALTRE PAGINE
            Double totaleComputo = disegnaAltrePagine(doc1, writer, datiComputo, root, opzioniStampa);

            // stampo il totale a fine computo
            if (opzioniStampa.stampaTotaleFinale && opzioniStampa.stampaTotaleNelleSuddivisioni) {
                disegnaTotaleFinale(doc1, totaleComputo, opzioniStampa);
            }

            disegnaPaginaCondizioniUltimaPagina(doc1, writer, datiComputo, opzioniStampa);

            // Può essere stato scelto
            /* [ ] Stampa Prezzi 
             * [ ] Stampa Totale Suddivisioni
             * [] Stampa Totale Finale 
             * [ ] IVA
             * 
             * L'IVA si stampa SSE ((totale s. o totale f. sono checckati) && IVA indicata).
             * In tutti gli altri casi non si stampa l'IVA, e va messa la frase "tutti i prezzi sono esenti iva".
             * Quindi ci può essere il caso in cui si indica la scelta dell'IVA ma non essendoci i totali scelti l'iva non esce e viene ignorata.
             * */


            // dicitura di fine documento "Tutti i prezzi sono Iva Esclusa"
            //if (opzioniStampa.stampaPrezzi) {
            //    paragrafo = new Paragraph();
            //    paragrafo.Add(new Chunk("\n\nTutti i prezzi sono Iva Esclusa"));
            //    doc1.Add(paragrafo);
            //}
            //if (opzioniStampa.stampaPrezzi &&
            //    opzioniStampa.stampaTotaleFinale == true) {
                table = new PdfPTable(24);
                table.WidthPercentage = 100;

                if ((opzioniStampa.stampaTotaleNelleSuddivisioni || opzioniStampa.stampaTotaleFinale) && opzioniStampa.iva != DBNull.Value) {
                    double soloIvaComputo = totaleComputo * (Convert.ToDouble(opzioniStampa.iva)) / 100;
                    double totaleComputoConIva = totaleComputo * (100 + Convert.ToDouble(opzioniStampa.iva)) / 100;

                    cella = creaCella(" ", ArialNormal, 24, 'l');
                    table.AddCell(cella);

                    cella = creaCella("Iva di legge " + opzioniStampa.iva.ToString() + "%", ArialGrandeBold, 12, 'l');
                    table.AddCell(cella);
                    cella = creaCella(soloIvaComputo.ToString(formatoValutaMigliaia), ArialGrandeBold, 12, 'r');
                    table.AddCell(cella);

                    cella = creaCella("TOTALE FINALE ", ArialGrandeBold, 12, 'l');
                    table.AddCell(cella);
                    cella = creaCella(totaleComputoConIva.ToString(formatoValutaMigliaia), ArialGrandeBold, 12, 'r');
                    table.AddCell(cella);

                } else {

                    cella = creaCella(" ", ArialNormal, 24, 'l');
                    table.AddCell(cella);
                    cella = creaCella("Tutti i prezzi sono Iva Esclusa ", ArialGrandeBold, 12, 'l');
                    table.AddCell(cella);
                    cella = creaCella(" ", ArialGrandeBold, 12, 'r');
                    table.AddCell(cella);

                }
                //doc1.Add(table);
                Paragraph paragraphPerTabellaTotaleFinale = new Paragraph();
                paragraphPerTabellaTotaleFinale.Add(table);
                doc1.Add(paragraphPerTabellaTotaleFinale);
            //}


            //CHIUDO E SALVO
            doc1.Close();

            generato = true;
        }
        catch (Exception ex)
        {
            return jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    /************************************************* ###PAGINA COPERTINA (PRIMA PAGINA) ************************************************/
    /* il primo metodo è l'header valido per tutte le pagine, per il metodo generico cerca 'disegnaHeaderPagina' */
    public static PdfPTable disegnaHeaderPrimaPagina(PdfContentByte cb, OpzioniStampa opzioniStampa)
    {
        PdfPTable table, table2;
        PdfPCell cella;
        // tabella
        table = new PdfPTable(24);
        table.WidthPercentage = 100;
        if (opzioniStampa.stampaLogo) {

            //DISEGNO IMMAGINE IN POSIZIONE ASSOLUTA.
            //iTextSharp.text.Image imgPROVA = iTextSharp.text.Image.GetInstance(pathImmagini + "immagine-muretto.png"); -> cambiato in data 09/08/2018
            iTextSharp.text.Image imgPROVA = iTextSharp.text.Image.GetInstance(pathImmagini + "logo-impresa-edile-segatto.jpg");

            //POSIZIONO IMMAGINE
            imgPROVA.SetAbsolutePosition(10, yattuale - imgPROVA.Height);
            imgPROVA.ScalePercent(55);

            cella = new PdfPCell(imgPROVA);
            cella.Border = 0;
            cella.Colspan = 6;
            //cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 2;
            cella.PaddingLeft = 0; cella.PaddingTop = 1; cella.PaddingRight = 8; cella.PaddingBottom = 0;
            cella.HorizontalAlignment = Element.ALIGN_CENTER;
            table.AddCell(cella);

            // Prima cella (su 4)
            table2 = new PdfPTable(24);
            table2.DefaultCell.Border = 0;


            //cella = creaCella("SEGATTO RENZO E F.LLI SNC", ArialGrandeNormal, 24, 'l', false);
            //cella.BorderWidthRight = 0;
            //cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            //table2.AddCell(cella);
            //cella = creaCella("di Segatto Renzo & C.", ArialGrandeNormal, 24, 'l', false);
            //cella.BorderWidthRight = 0;
            //cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            //table2.AddCell(cella);

            // modificato il 09/08/2018
            cella = creaCella("IMPRESA EDILE SEGATTO SRL", ArialGrandeNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("IMPRESA COSTRUZIONI EDILI", ArialGrandeNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("Via dell'artigianato, 16 - 31040 Chiarano Treviso", ArialGrandeNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("Tel. 0422.746046 Fax 0422.806854", ArialGrandeNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            //cb.SetColorFill(baseColor_Blu); // testo blu (testo blu e sottolineato per specificare che è un link)
            cella = creaCella("info@impresaedilesegatto.it", ArialGrandeUnderline, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 2; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("www.impresaedilesegatto.it", ArialGrandeUnderline, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);
            //cb.SetColorFill(baseColor_Nero); // testo nero (ripristino il colore del testo al colore nero di default)

            // creo una cella che serve solo per riempire lo spazio vuoto
            cella = new PdfPCell(new Phrase(" ", FontFactory.GetFont("Arial", 1, Font.NORMAL))); cella.Colspan = 24; cella.BorderWidth = 0; cella.Padding = 0;
            table2.AddCell(cella);

            cella = new PdfPCell(table2);
            cella.BorderWidthLeft = 0; cella.BorderWidthTop = 0; cella.BorderWidthRight = 0; cella.BorderWidthBottom = 0;
            cella.Colspan = 9;
            cella.Padding = 0;
            table.AddCell(cella);

            // Terza e quarta cella (su 4)
            table2 = new PdfPTable(24);

            cella = creaCella("Reg.Imp. TV n.8734/96 - Reg.Ditte n. 125254", ArialGrandeNormal, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("P.IVA e C.F. 00538590266", ArialGrandeNormal, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("C.C.I.A.A. n. 39097", ArialGrandeNormal, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            // creo una cella che serve solo per riempire lo spazio vuoto
            cella = new PdfPCell(new Phrase(" ", FontFactory.GetFont("Arial", 1, Font.NORMAL))); cella.Colspan = 24; cella.BorderWidth = 0; cella.Padding = 0;
            table2.AddCell(cella);

            cella = new PdfPCell(table2);
            cella.BorderWidthLeft = 0; cella.BorderWidthTop = 0; cella.BorderWidthRight = 0; cella.BorderWidthBottom = 0;
            cella.Colspan = 9;
            cella.Padding = 0;
            cella.PaddingTop = 0;

            table.AddCell(cella);

            // lascio un po' di spazio tra questo e il prossimo elemento
            table.SpacingAfter = 10;
        }

        return table;
    }
    private static void disegnaPaginaCopertina(Document doc1, PdfWriter writer, DatiComputo datiComputo, OpzioniStampa opzioniStampa)
    {
        PdfPTable table; PdfPCell cella; Paragraph paragrafo;
        PdfContentByte cb = writer.DirectContent;

        //DISEGNO HEADER DI PRIMA PAGINA
        paragrafo = new Paragraph();
        paragrafo.Add(disegnaHeaderPrimaPagina(cb, opzioniStampa));
        doc1.Add(paragrafo);

        table = new PdfPTable(24);
        table.SpacingBefore = 80;
        table.WidthPercentage = 100;

        cella = creaCella(opzioniStampa.titolocomputo, ArialTitoloDiStampa, 24, 'c');
        cb.SetColorFill(baseColor_Bianco); // testo bianco (cambio il colore del testo)
        cella.BackgroundColor = baseColor_Verde;
        cella.PaddingTop = 4;
        cella.PaddingLeft = 8;
        cella.PaddingRight = 8;
        cella.PaddingBottom = 12;
        table.AddCell(cella);

        paragrafo = new Paragraph();
        paragrafo.Add(table);
        doc1.Add(paragrafo);

        cb.SetColorFill(baseColor_Nero); // testo nero (ripristino il colore del testo al colore nero di default)

        //ISTANZIO TABELLA A 24 COLONNE E LARGA 90% (la larghezza è settata in percentuale, l'altezza viene calcolata dinamicamente)
        table = new PdfPTable(24);
        table.WidthPercentage = 100;

        // la somma deve fare 24
        int colonna1 = 5;
        int colonna2 = 24 - colonna1;

        // riga 1
        cella = creaCella("Committente:", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        cella = creaCella(datiComputo.nominativoCliente, ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 2
        cella = creaCella(" ", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        cella = creaCella(datiComputo.indirizzoCliente, ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 3
        cella = creaCella(" ", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        cella = creaCella(datiComputo.cittaCliente, ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 4
        cella = creaCella(" ", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        cella = creaCella(datiComputo.telefonoCliente, ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 5
        cella = creaCella(" ", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        cella = creaCella(datiComputo.emailCliente, ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 6 (vuota)
        cella = creaCella(" ", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        cella = creaCella(" ", ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 7
        cella = creaCella("Descrizione lavori:", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0;
        cella.VerticalAlignment = Element.ALIGN_TOP; table.AddCell(cella);
        cella = creaCella(datiComputo.descrizione, ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        //cella = new PdfPCell(new Phrase(datiComputo.descrizione, ArialTitoloNormal));
        //cella.Colspan = colonna2;
        //cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 8 (vuota)
        cella = creaCella(" ", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0; table.AddCell(cella);
        cella = creaCella(" ", ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);

        // riga 9 (opzioniStampa dataora)
        cella = creaCella("Data:", ArialTitoloNormal, colonna1, 'r', false); cella.BorderWidthRight = 0;
        cella.VerticalAlignment = Element.ALIGN_TOP; table.AddCell(cella);
        String dataDiStampa = opzioniStampa.dataDiStampa.ToShortDateString();
        cella = creaCella(dataDiStampa, ArialTitoloNormal, colonna2, 'l', false); cella.BorderWidthRight = 0; table.AddCell(cella);
     
        //AGGIUNGO LA TABELLA CON UN PO DI MARGINE TOP (400)
        table.SpacingBefore = 80;
        paragrafo = new Paragraph();
        paragrafo.Add(table);
        doc1.Add(paragrafo);

        // disegna rettangolo(left, top, right, bottom, PdfContentByte, BaseColor);
        //disegnaRettangolo(40, 60, width - 40, 54, cb, baseColor_Verde);
    }

    /************************************************* ###PAGINA RIEPILOGO (SECONDA PAGINA) ************************************************/

    private static void disegnaSecondaPagina(Document doc1, PdfWriter writer, DatiComputo datiComputo, Suddivisione root, OpzioniStampa opzioniStampa)
    {
        PdfPTable table; PdfPCell cella; Paragraph paragrafo;
        PdfContentByte cb = writer.DirectContent;

        paragrafo = new Paragraph();
        paragrafo.Add(disegnaHeaderPagina(cb, opzioniStampa));
        doc1.Add(paragrafo);

        //ISTANZIO TABELLA A 24 COLONNE E LARGA 90% (la larghezza è settata in percentuale, l'altezza viene calcolata dinamicamente)
        table = new PdfPTable(24);
        table.WidthPercentage = 100;
        table.SpacingBefore = 10;

        cella = creaCella("RIEPILOGO " + opzioniStampa.titolocomputo, ArialTitoloBold, 24, 'c', false);
        cella.PaddingTop = 7; cella.PaddingBottom = 9;
        cella.BorderWidthRight = 0;
        cella.BorderWidthLeft = 0.1F;
        cella.BorderWidthTop = 0.1F;
        cella.BorderWidthBottom = 0.1F;
        cella.BorderWidthRight = 0.1F;

        table.AddCell(cella);

        Double totaleComputo = recursivaStampaRiepilogo(table, root, 0, opzioniStampa);
/*
        // stampo il totaleComputo (opzione con o senza prezzo)
        if (opzioniStampa.stampaPrezzi == true) {
            cella = creaCella(" ", ArialNormal, 24, 'l');
            table.AddCell(cella);
            cella = creaCella("TOTALE PREVENTIVO", ArialGrandeBold, 12, 'l');
            table.AddCell(cella);
            cella = creaCella("€ " + totaleComputo.ToString("F2"), ArialGrandeBold, 12, 'r');
            table.AddCell(cella);
        }*/

        //AGGIUNGO LA TABELLA CON UN PO DI MARGINE TOP (400)
        paragrafo = new Paragraph();
        paragrafo.Add(table);
        doc1.Add(paragrafo);
    }

    /* Condizioni prima pagina */
    private static void disegnaPaginaCondizioniPrimaPagina(Document doc1, PdfWriter writer, DatiComputo datiComputo, OpzioniStampa opzioniStampa)
    {
        /*PdfPTable table; PdfPCell cella; */
        Paragraph paragrafo;
        PdfContentByte cb = writer.DirectContent;

        //paragrafo = new Paragraph();
        //paragrafo.Add(disegnaHeaderPagina(cb, opzioniStampa));
        //doc1.Add(paragrafo);

        int condizioniprimapagina_Length = datiComputo.condizioniprimapagina.Length;
        int primoACapo = datiComputo.condizioniprimapagina.IndexOf('\n');

        // titolo
        if (primoACapo >= 0) {
            String condizioniprimapagina_titolo = datiComputo.condizioniprimapagina.Substring(0, primoACapo);
            paragrafo = new Paragraph(condizioniprimapagina_titolo, ArialGrandeBold);
            doc1.Add(paragrafo);
        }

        // testo
        String condizioniprimapagina_testo = datiComputo.condizioniprimapagina.Substring(primoACapo + 1, condizioniprimapagina_Length - 1 - primoACapo);
        paragrafo = new Paragraph(condizioniprimapagina_testo, ArialTitoloNormal);
        paragrafo.SpacingBefore = 10; // spazio tra il titolo e il testo
        doc1.Add(paragrafo);
    }

    // Tabella larga 24 colonne, 2 colonne per il totale, la profondità dell'albero varia da 0 a 20.
    private static Double recursivaStampaRiepilogo(PdfPTable table, Suddivisione corrente, int profondita, OpzioniStampa opzioniStampa)
    {
        // calcolo il totale delle misure delle voci della suddivisione
        Double totaleSuddivisioneCorrente = Suddivisione.calcolaTotale(corrente);
        Double totaleFigli = 0;

        // 1. STAMPA TITOLO E PREZZO DELLA SUDDIVISIONE
        stampaRigaSuddivisioneCorrente(profondita, corrente.descrizione, totaleSuddivisioneCorrente, table, opzioniStampa);

        // 2. RICORSIONE!
        foreach (Suddivisione figlio in corrente.figli) {
            // devo stampare SOLO le suddivisioni di primo livello presenti nelle opzioni di stampa, 
            // quindi quando mi trovo nel nodo di root verifico che figlio.id sia presente
            if (profondita == 0 && !opzioniStampa.suddPrimoLvDaStampare.Contains(figlio.id)) {
            } else {
                if (profondita < 20)
                    totaleFigli += recursivaStampaRiepilogo(table, figlio, profondita + 1, opzioniStampa);
                else
                    totaleFigli += recursivaStampaRiepilogo(table, figlio, profondita, opzioniStampa);
            }
        }

        // 3. STAMPA TOTALE DELLA SUDDIVISIONE CORRENTE (solo se non foglia)
        // (nota: aggiungo anche una riga vuota alla fine di ogni suddivisione di primo livello)
        if (opzioniStampa.stampaTotaleFinale && opzioniStampa.stampaTotaleNelleSuddivisioni) {
            stampaRigaTotaleSuddivisioneCorrente(profondita, corrente, totaleSuddivisioneCorrente, totaleFigli, table, opzioniStampa);
        }

        return totaleSuddivisioneCorrente + totaleFigli;
    }

    // STAMPA TITOLO E PREZZO DELLA SUDDIVISIONE
    public static void stampaRigaSuddivisioneCorrente(int profondita, string descrizioneSuddivisioneCorrente, double totaleSuddivisioneCorrente, PdfPTable table, OpzioniStampa opzioniStampa)
    {
        if (profondita > 0) { // non si riesce a mandare in stampa una cella vuota, il PDF stampa comunque qualcosa
            PdfPCell cellaVuota = creaCella("", ArialNormal, profondita, 'c', false);
            cellaVuota.BorderWidthRight = 0;
            table.AddCell(cellaVuota);
        }
        PdfPCell cella = creaCella(descrizioneSuddivisioneCorrente, ArialNormal, 20 - profondita, 'l', false);
        cella.BorderWidthRight = 0;
        table.AddCell(cella);

        // con profondità = 0 non mostro il totale
        if (profondita == 0) {
            PdfPCell cellaTotale;
            cellaTotale = creaCella(" ", ArialNormal, 4);
            cellaTotale.BorderWidthRight = 0;
            table.AddCell(cellaTotale);
        } else {
            // stampa il totale della suddivisione corrente (opzione con o senza prezzo)
            PdfPCell cellaTotale;
            if (opzioniStampa.stampaPrezzi == true && opzioniStampa.stampaTotaleNelleSuddivisioni == true)
                cellaTotale = creaCella(totaleSuddivisioneCorrente.ToString(formatoValutaMigliaia), ArialNormal, 4, 'r', false);
            else
                cellaTotale = creaCella(" ", ArialNormal, 4);
            cellaTotale.BorderWidthRight = 0;
            table.AddCell(cellaTotale);
        }
    }
    // STAMPA TOTALE DELLA SUDDIVISIONE CORRENTE (solo se non foglia)
    public static void stampaRigaTotaleSuddivisioneCorrente(int profondita, Suddivisione corrente, double totaleSuddivisioneCorrente, double totaleFigli, PdfPTable table, OpzioniStampa opzioniStampa)
    {
        if (opzioniStampa.stampaPrezzi == true && corrente.figli.Count > 0) {
            // stampa la cella del totale (3 celle: spazio, descrizione, totale)
            if (profondita > 0) { // non si riesce a mandare in stampa una cella vuota, il PDF stampa comunque qualcosa
                PdfPCell cellaVuota2 = creaCella("", ArialBold, profondita, 'c', false);
                cellaVuota2.BorderWidthRight = 0;
                table.AddCell(cellaVuota2);
            }

            PdfPCell cellaDescrizioneTotale = creaCella(corrente.descrizione + " TOTALE", ArialBold, 20 - profondita, 'l', false);
            cellaDescrizioneTotale.BorderWidthTop = 0.1F;
            cellaDescrizioneTotale.BorderWidthRight = 0;
            table.AddCell(cellaDescrizioneTotale);

            // stampa il totale della suddivisione corrente + il totale dei figli (opzione con o senza prezzo)
            PdfPCell cellaTotali;
            cellaTotali = creaCella((totaleSuddivisioneCorrente + totaleFigli).ToString(formatoValutaMigliaia), ArialBold, 4, 'r', false);
            cellaTotali.BorderWidthTop = 0.1F;
            cellaTotali.BorderWidthRight = 0;
            table.AddCell(cellaTotali);

            // aggiungo una riga vuota alla fine di ogni suddivisione di primo livello
            if (profondita == 1) {
                PdfPCell cellaRigaVuota = creaCella(" ", ArialBold, 24);
                table.AddCell(cellaRigaVuota);
            }

        }
    }

    /************************************************** ###PAGINE COMPUTO (ALTRE PAGINE) **************************************************/

    private static Double disegnaAltrePagine(Document doc1, PdfWriter writer, DatiComputo datiComputo, Suddivisione root, OpzioniStampa opzioniStampa)
    {
        // ricreo la rabella
        nuovaTabellaComputo(writer, datiComputo, opzioniStampa);

        Double totaleComputo = recursivaStampaComputo(doc1, writer, datiComputo, root, root, 0, opzioniStampa, opzioniStampa.titolocomputo, 0);

        // chiudi la tabella
        chiudiTabellaComputo(doc1, datiComputo, opzioniStampa);

        return totaleComputo;
    }
    public static void nuovaTabellaComputo(PdfWriter writer, DatiComputo datiComputo, OpzioniStampa opzioniStampa)
    {
        //ISTANZIO TABELLA A 24 COLONNE E LARGA 90% (la larghezza è settata in percentuale, l'altezza viene calcolata dinamicamente)
        //table.DefaultCell.Border = Rectangle.NO_BORDER;
        tableComputo = new PdfPTable(24);
        tableComputo.WidthPercentage = 100;
        //tableComputo.SplitLate = true; tableComputo.SplitRows = false; <- vecchio codice (prima di 19/07/2016)
        tableComputo.SplitLate = false; tableComputo.SplitRows = true;

        ///L'HEADER VIENE RIPETUTO SU TUTTE LE PAGINE
        PdfContentByte cb = writer.DirectContent;
        aggiungiRigaHeader(cb, tableComputo, datiComputo, opzioniStampa);
    }
    public static void chiudiTabellaComputo(Document doc1, DatiComputo datiComputo, OpzioniStampa opzioniStampa)
    {
        //AGGIUNGO LA TABELLA CON UN PO DI MARGINE TOP (10)
        Paragraph paragraphPerTabella = new Paragraph();
        paragraphPerTabella.SpacingBefore = 10;
        paragraphPerTabella.Add(tableComputo);
        doc1.Add(paragraphPerTabella);
    }

    // public static void aggiungiRigaHeader(PdfContentByte cb, PdfPTable table, DatiComputo datiComputo, OpzioniStampa opzioniStampa)
    public static void aggiungiRigaHeader(PdfContentByte cb, PdfPTable table, DatiComputo datiComputo, OpzioniStampa opzioniStampa)
    {
        PdfPCell cella;

        // HEADER
        cella = new PdfPCell(disegnaHeaderPagina(cb, opzioniStampa));
        cella.Colspan = 24;
        cella.BorderWidth = 0;
        table.AddCell(cella);

        cella = creaCella(opzioniStampa.titolocomputo, ArialTitoloBold, 24, 'c', false);
        cella.BorderWidthRight = 0;
        cella.PaddingBottom = 20;
        table.AddCell(cella);

        cella = creaCella("N°", ArialBold, 1, 'c', true);
        cella.BorderWidthBottom = 0.1F; cella.BorderWidthTop = 0.1F;
        table.AddCell(cella);

        cella = creaCella("Codice", ArialBold, 2, 'c', false);
        cella.BorderWidthBottom = 0.1F; cella.BorderWidthTop = 0.1F;
        table.AddCell(cella);

        cella = creaCella("Descrizione", ArialBold, 12, 'c', false);
        cella.BorderWidthBottom = 0.1F; cella.BorderWidthTop = 0.1F;
        table.AddCell(cella);

        cella = creaCella("Quantità", ArialBold, 3, 'c', false);
        cella.BorderWidthBottom = 0.1F; cella.BorderWidthTop = 0.1F;
        table.AddCell(cella);

        PdfPTable table2 = new PdfPTable(2);
        table2.WidthPercentage = 100;
        cella = creaCella("Euro", ArialBold, 2, 'c', false);
        cella.BorderWidthBottom = 0.1F;
        table2.AddCell(cella);
        cella = creaCella("PREZZO", ArialBold, 1, 'c', false);
        table2.AddCell(cella);
        cella = creaCella("IMPORTO", ArialBold, 1, 'c', false);
        table2.AddCell(cella);
        cella = new PdfPCell(table2);
        cella.Colspan = 6; cella.BorderWidth = 0; cella.BorderWidthTop = 0.1F; cella.BorderWidthBottom = 0.1F;

        table.AddCell(cella);

        // FOOTER
        cella = creaCella("", ArialBold, 24, 'c');
        cella.BorderWidthTop = 0.1F;
        table.AddCell(cella);

        // Come funziona: Fin'ora ho creato 4 righe per questa tabella. 3 righe di header e 1 riga di footer.
        // - table.HeaderRows = righeDiHeader + righeDiFooter; -> 3+1 = 4
        // - table.FooterRows = righeDiFooter; -> 1
        table.HeaderRows = 4;
        table.FooterRows = 1;
    }

    // Tabella larga 24 colonne, 2 colonne per il totale, la profondità dell'albero varia da 0 a 21. Le colonne sono da 0 a 23, due le teniamo libere per i totali
    private static Double recursivaStampaComputo(Document doc1, PdfWriter writer, DatiComputo datiComputo, Suddivisione root, Suddivisione corrente, int profondita, OpzioniStampa opzioniStampa, string briciole, int contamisure)
    {
        //List<Suddivisione> listaSuddivisioni = Suddivisione.getTutteLeSuddivisioniOrdinate(root);
        // calcolo il totale delle misure delle voci della suddivisione
        if (profondita > 0) {
            //string risultato = ottieniBricioleDaSuddCorrente(corrente, listaSuddivisioni, corrente.descrizione);
            //briciole = briciole + " > " + corrente.descrizione;
            //aggiungiRigaBriciole(tableComputo, profondita, briciole);
            //string risultato = ottieniBricioleDaSuddCorrente(corrente, root, "");
            string risultato = "";
            foreach (Suddivisione figlio in root.figli) { // ciclo sulla root perchè non voglio stampare il nome del computo, ma solo le suddivisioni
                string temp = ottieniBricioleDaSuddCorrente(corrente, figlio, "");
                if (temp != "")
                    risultato = temp;
            }
            aggiungiRigaBriciole(tableComputo, profondita, risultato);
        }

        for (int j = 0; j < corrente.listaVoci.Count; ++j) {
            // ottengo la voce
            Voce voce = corrente.listaVoci[j];
            // creo la riga
            aggiungiRigaTitoloVoce(tableComputo, voce);
            aggiungiRigaDescrizioneVoce(tableComputo, voce);

            for (int k = 0; k < voce.listaMisure.Count; k++) {
                // ottengo la misura
                Misura misura = corrente.listaVoci[j].listaMisure[k];
                // creo la riga
                aggiungiRigaMisura(tableComputo, misura, ++contamisure, opzioniStampa);
                aggiungiRigaMisura_calcolo(tableComputo, misura, opzioniStampa);
            }
            // alla fine della lista delle misure ci devono essere le somme
            //aggiungiRigaMisura_sommaFinale(table, voce);
        }


        Double totaleSuddivisioneCorrente = Suddivisione.calcolaTotale(corrente);
        Double totaleFigli = 0;

        // 1. STAMPA TITOLO E PREZZO DELLA SUDDIVISIONE
        //stampaRigaSuddivisioneCorrente(profondita, corrente.descrizione, totaleSuddivisioneCorrente, table, opzioniStampa);

        // 2. RICORSIONE!
        foreach (Suddivisione figlio in corrente.figli) {
            // devo stampare SOLO le suddivisioni di primo livello presenti nelle opzioni di stampa, 
            // quindi quando mi trovo nel nodo di root verifico che figlio.id sia presente
            if (profondita == 0 && !opzioniStampa.suddPrimoLvDaStampare.Contains(figlio.id)) {
            } else {
                if (profondita < 21)
                    totaleFigli += recursivaStampaComputo(doc1, writer, datiComputo, root, figlio, profondita + 1, opzioniStampa, briciole, contamisure);
                else
                    totaleFigli += recursivaStampaComputo(doc1, writer, datiComputo, root, figlio, profondita, opzioniStampa, briciole, contamisure);
            }
        }

        // 3. STAMPA TOTALE DELLA SUDDIVISIONE CORRENTE (solo se non foglia)
        // (nota: aggiungo anche SALTO PAGINA alla fine di ogni suddivisione di primo livello)
        bool isUltimoFiglioSuddivisioneLivello1 = root.isUltimoFiglio(corrente);
        stampaRigaTotaleSuddivisioneCorrente2(doc1, writer, datiComputo, profondita, corrente, totaleSuddivisioneCorrente, totaleFigli, tableComputo, opzioniStampa, isUltimoFiglioSuddivisioneLivello1);


        return totaleSuddivisioneCorrente + totaleFigli;
    }

    public static string ottieniBricioleDaSuddCorrente(Suddivisione corrente, Suddivisione root, string risultato)
    {
        if (corrente.id == root.id)
            return root.descrizione;
        else {
            foreach (Suddivisione figlio in root.figli) {
                string temp = ottieniBricioleDaSuddCorrente(corrente, figlio, "");
                if (temp != "")
                    risultato = root.descrizione + " > " + temp;
            }
            return risultato;
        }
    }

    /*public static string ottieniBricioleDaSuddCorrente(Suddivisione corrente, List<Suddivisione> listaSuddivisioni, string risultato)
    {
        for (int i = 0; i < listaSuddivisioni.Count; i++) {
            for (int j = 0; j < listaSuddivisioni[i].figli.Count; j++) {
                if (listaSuddivisioni[i].figli[j].id == corrente.id) {
                    risultato = listaSuddivisioni[i].descrizione + " > " + risultato;
                    if (listaSuddivisioni[i].idPadre != null)
                        risultato = ottieniBricioleDaSuddCorrente(listaSuddivisioni[i], listaSuddivisioni, risultato);
                }
            }
        }
        return risultato;
    }*/
    public static void aggiungiRigaBriciole(PdfPTable table, int profondita, string briciole){
        PdfPCell cella = creaCella(briciole, ArialGrandeBold, 24);
        cella.BorderWidthLeft = 0.1F;
        cella.BorderWidthRight = 0.1F;
        cella.BorderWidthBottom = 0.1F;
        //if (profondita > 1)
        cella.BorderWidthTop = 0.1F;
        cella.PaddingTop = 14;
        cella.PaddingBottom = 16;
        table.AddCell(cella);
    }
    // STAMPA TOTALE DELLA SUDDIVISIONE CORRENTE (solo se non foglia)
    public static void stampaRigaTotaleSuddivisioneCorrente2(Document doc1, PdfWriter writer, DatiComputo datiComputo, int profondita, Suddivisione corrente, double totaleSuddivisioneCorrente, double totaleFigli, PdfPTable table, OpzioniStampa opzioniStampa, bool isUltimoFiglioSuddivisioneLivello1)
    {
        if (profondita > 0){
            // && corrente.figli.Count > 0
            if (opzioniStampa.stampaPrezzi == true) {
                if (opzioniStampa.stampaTotaleNelleSuddivisioni == true) {
                    // 21 + 3 per il totale
                    PdfPCell cellaDescrizioneTotale = creaCella(corrente.descrizione + " TOTALE", ArialGrandeBold, 21, 'l', false);
                    cellaDescrizioneTotale.BorderWidthTop = 0.1F;
                    cellaDescrizioneTotale.BorderWidthLeft = 0.1F;
                    cellaDescrizioneTotale.BorderWidthRight = 0.1F;
                    cellaDescrizioneTotale.BorderWidthBottom = 0.1F;
                    table.AddCell(cellaDescrizioneTotale);

                    // stampa il totale della suddivisione corrente + il totale dei figli (opzione con o senza prezzo)
                    PdfPCell cellaTotali;
                    cellaTotali = creaCella((totaleSuddivisioneCorrente + totaleFigli).ToString(formatoValutaMigliaia), ArialGrandeBold, 3, 'r', false);
                    cellaTotali.PaddingLeft = 0;
                    cellaTotali.BorderWidthTop = 0.1F;
                    cellaTotali.BorderWidthRight = 0.1F;
                    cellaTotali.BorderWidthBottom = 0.1F;
                    table.AddCell(cellaTotali);
                } else {
                    // non mostor il prezzo, quindi ho una sola cella grande quanto tutta la riga (=24)
                    PdfPCell cellaDescrizioneTotale = creaCella(corrente.descrizione, ArialGrandeBold, 24, 'l', false);
                    cellaDescrizioneTotale.BorderWidthTop = 0.1F;
                    cellaDescrizioneTotale.BorderWidthLeft = 0.1F;
                    cellaDescrizioneTotale.BorderWidthRight = 0.1F;
                    cellaDescrizioneTotale.BorderWidthBottom = 0.1F;
                    table.AddCell(cellaDescrizioneTotale);
                }

                // aggiungo un SALTO PAGINA alla fine di ogni suddivisione di primo livello
                if (profondita == 1 && !isUltimoFiglioSuddivisioneLivello1) {
                    /*PdfPCell cellaRigaVuota = creaCella(" ", ArialGrandeBold, 24);
                    table.AddCell(cellaRigaVuota);*/
                    chiudiTabellaComputo(doc1, datiComputo, opzioniStampa);
                    doc1.NewPage();
                    nuovaTabellaComputo(writer, datiComputo, opzioniStampa);
                }
            }
        }
    }

    public static void aggiungiRigaSuddivisione(PdfPTable table, Suddivisione sudd, List<Suddivisione> listaSuddivisioni)
    {
        PdfPCell cella;

        String sudd_descrizione = sudd.descrizione;
        String percorso = sudd_descrizione;
        while (sudd != null && sudd.idPadre != DBNull.Value) {
            sudd = Suddivisione.getNodoPadre(sudd, listaSuddivisioni);
            if (sudd != null) {
                sudd_descrizione = sudd.descrizione;
                percorso = sudd_descrizione + " > " + percorso;
            }
        }

        cella = creaCella("", ArialNormal, 1, 'r', true);
        table.AddCell(cella);

        cella = creaCella("", ArialNormal, 2, 'r', false);
        table.AddCell(cella);

        cella = creaCella(percorso, ArialNormal, 12, 'l', false);
        cella.Padding = 8; // padding maggiore e più spazio superiore
        table.AddCell(cella);

        cella = creaCella("", ArialNormal, 3, 'r', false);
        table.AddCell(cella);

        cella = creaCella("", ArialNormal, 3, 'r', false);
        table.AddCell(cella);

        cella = creaCella("", ArialNormal, 3, 'r', false);
        table.AddCell(cella);
        // 18+6 = deve essere 24
    }
    public static void aggiungiRigaTitoloVoce(PdfPTable table, Voce voce)
    {
        PdfPCell cella;


        /* questo era un test, BUTTA
        String testo = "mioTesto";

        //esempio: #*questo font è bold #_ questo invece è font bold e sottolineato#_#*
        // [1 = Bold, 2 = Sottolineato, 3 = Cancellato] + [0 = nero, 10 = Rosso] il risultato va come secondo elemento dell'array
        // array = ["#*questo font è bold #_ questo invece è font bold e sottolineato#_#*", 0]
        List<Phrase> frasi = new List<Phrase>();
        frasi.Add(new Phrase("ciao", FontFactory.GetFont("Arial", 11, Font.NORMAL, BaseColor.GREEN)));
        frasi.Add(new Phrase("ciao2", FontFactory.GetFont("Arial", 11, Font.BOLD, BaseColor.RED)));
        cella = new PdfPCell();
        for (int i = 0; i < frasi.Count; i++) {
            cella.AddElement(frasi[i]);
        }
        table.AddCell(cella);

        //frasi = creaCellaDaTestoFormattato("testo", "Arial", 11, float, 'l');
        //frasi = creaCellaDaTestoFormattato(string testo, string tipoFont, int altezzaFont, char align);
        */

        /*
        string codice = "ng rebr th eaog hrenoi";
        codice = convertiTestoInHTML(codice);

        public static void convertiTestoInHTML(string testo) {
            
        }

         */

        //int idVoce = voce.id;
        String codice = voce.codice;
        String titolo = voce.titolo;
        //String descrizione = voce.descrizione;
        //codice.Split("#_",

        cella = creaCella("", ArialBold, 1, 'r', true); // un po' di tab per la riga misura
        cella.PaddingTop = 16;
        table.AddCell(cella);

        cella = creaCellaConTestoHTML(codice, ArialBold, 2, 'r', false); // un po' di tab per la riga misura
        cella.VerticalAlignment = Element.ALIGN_TOP;
        cella.PaddingTop = 16;
        table.AddCell(cella);

        //cella = creaCella(titolo, ArialBold, 12, 'l', false);
        cella = creaCellaConTestoHTML(titolo, ArialBold, 12, 'l', false);
        cella.HorizontalAlignment = Element.ALIGN_JUSTIFIED;
        cella.VerticalAlignment = Element.ALIGN_TOP;
        cella.PaddingTop = 16;
        table.AddCell(cella);

        cella = creaCella("", ArialBold, 3, 'r', false);
        table.AddCell(cella);
        cella = creaCella("", ArialBold, 3, 'r', false);
        table.AddCell(cella);
        cella = creaCella("", ArialBold, 3, 'r', false);
        table.AddCell(cella);
        // 1+4+12+7 = deve essere 24
    }
    public static void aggiungiRigaDescrizioneVoce(PdfPTable table, Voce voce)
    {
        PdfPCell cella;

        //int idVoce = voce.id;
        //String codice = voce.codice;
        //String titolo = voce.titolo;
        String descrizione = voce.descrizione;

        cella = creaCella("", ArialBold, 1, 'r', true); // un po' di tab per la riga misura
        table.AddCell(cella);
        cella = creaCella("", ArialBold, 2, 'r', false); // un po' di tab per la riga misura
        cella.VerticalAlignment = Element.ALIGN_TOP;
        table.AddCell(cella);

        if (descrizione.StartsWith("Fornitura e posa orditura della copertura costituita da travi principali in legno lamellare GL24h")) {
            String a = "";
        }
        cella = creaCellaConTestoHTML(descrizione + "\r\n", ArialNormal, 12, 'l', false);
        //cella.HorizontalAlignment = Element.ALIGN_JUSTIFIED;
        cella.VerticalAlignment = Element.ALIGN_TOP;
        table.AddCell(cella);

        /*Paragraph paragrafo = new Paragraph(Element.ALIGN_JUSTIFIED_ALL, descrizione, ArialNormal);
        cella = new PdfPCell(paragrafo);
        cella.BorderWidth = 0; cella.BorderWidthRight = 0.1F;
        //cella.VerticalAlignment = Element.ALIGN_TOP;  
        cella.Colspan = 12;
        cella.Padding = 5; cella.PaddingTop = 3;*/

        /*cella = new PdfPCell();
        Paragraph paragrafo = new Paragraph(Element.ALIGN_JUSTIFIED_ALL, descrizione, ArialNormal);
        cella.Colspan = 12;
        cella.AddElement(paragrafo);
        cella.HorizontalAlignment = Element.ALIGN_JUSTIFIED_ALL; //This has no effect
        cella.VerticalAlignment = Element.ALIGN_TOP; //This has no effect*/


        cella = creaCella("", ArialBold, 3, 'r', false);
        table.AddCell(cella);
        cella = creaCella("", ArialBold, 3, 'r', false);
        table.AddCell(cella);
        cella = creaCella("", ArialBold, 3, 'r', false);
        table.AddCell(cella);
        // 1+4+12+7 = deve essere 24
    }

    public static void aggiungiRigaMisura(PdfPTable table, Misura misura, int contamisure, OpzioniStampa opzioniStampa)
    {
        PdfPCell cella;

        // ALGORITMO: si splitta il contenuto di descrizione sugli =
        // Per ogni riga, si stampano i dati 
        // se prima riga stampare anche n e codice

        int idMisura = misura.id;
        String stringaContamisure = contamisure.ToString();
        String sottocodice = misura.sottocodice;
        String descrizione = misura.descrizione;

        // '\n' non '='
        String[] listaRigheDescrizione = descrizione.Split('\n');
        for (int i = 0; i < listaRigheDescrizione.Length; i++) {
            if (i == 1) { // al secondo ciclo azzera le stringhe in modo che non vengano visualizzate
                stringaContamisure = "";
                sottocodice = "";
            }
            // il padding serve solo alla prima e all'ultima riga
            int paddingTop = 0; if (i == 0) paddingTop = 2;
            int paddingBottom = 1; if (i == listaRigheDescrizione.Length - 1) paddingBottom = 4;

            cella = creaCella(stringaContamisure, ArialNormal, 1, 'r', true); // un po' di tab per la riga misura
            cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
            cella.VerticalAlignment = Element.ALIGN_TOP;
            table.AddCell(cella);
            cella = creaCella(sottocodice, ArialNormal, 2, 'r', false);
            cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
            cella.VerticalAlignment = Element.ALIGN_TOP;
            table.AddCell(cella);

            if (opzioniStampa.stampaMisure == true) {
                // se stampo le misure mostro sia le righe con = che quelle senza uguale
                //cella = creaCella(listaRigheDescrizione[i], ArialNormal, 12, 'l', false);
                cella = creaCellaConTestoHTML(listaRigheDescrizione[i], ArialNormal, 12, 'l', false);
                cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
                cella.VerticalAlignment = Element.ALIGN_TOP;
                table.AddCell(cella);
            } else {
                // se non stampo le misure, NON mostro le righe con =
                if (listaRigheDescrizione[i].Length > 0 && listaRigheDescrizione[i][0] == '=') {
                    //cella = creaCella("", ArialNormal, 12, 'l', false);
                    cella = creaCellaConTestoHTML("", ArialNormal, 12, 'l', false);
                    cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
                    cella.VerticalAlignment = Element.ALIGN_TOP;
                    table.AddCell(cella);
                } else {
                    //cella = creaCella(listaRigheDescrizione[i], ArialNormal, 12, 'l', false);
                    cella = creaCellaConTestoHTML(listaRigheDescrizione[i], ArialNormal, 12, 'l', false);
                    cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
                    cella.VerticalAlignment = Element.ALIGN_TOP;
                    table.AddCell(cella);
                }
            }

            // importi a destra
            String stringaCalcolo = "";
            if (opzioniStampa.stampaMisure == true && listaRigheDescrizione[i] != "" && listaRigheDescrizione[i][0] == '=') {
                //decimal result = Convert.ToDecimal(new NCalc.Expression(stringaDaValutare).Evaluate());
                string stringaDaValutare = listaRigheDescrizione[i].Split('=')[1];
                double result = 0;
                try {
                    result = Convert.ToDouble(new NCalc.Expression(stringaDaValutare).Evaluate());
                } catch {
                    result = 0;
                }
                stringaCalcolo = result.ToString("F3");
            }
            cella = creaCella(stringaCalcolo, ArialNormal, 3, 'r', false);
            cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
            cella.VerticalAlignment = Element.ALIGN_TOP;
            table.AddCell(cella);
            cella = creaCella("", ArialNormal, 3, 'r', false);
            cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
            cella.VerticalAlignment = Element.ALIGN_TOP;
            table.AddCell(cella);
            cella = creaCella("", ArialNormal, 3, 'r', false);
            cella.PaddingBottom = paddingBottom; cella.PaddingTop = paddingTop;
            cella.VerticalAlignment = Element.ALIGN_TOP;
            table.AddCell(cella);
        }
    }
    public static void aggiungiRigaMisura_calcolo(PdfPTable table, Misura misura, OpzioniStampa opzioniStampa)
    {
        PdfPCell cella;

        int idMisura = misura.id;
        String sottocodice = misura.sottocodice;
        String descrizione = misura.descrizione;
        //String unitadimisura = misura.idUnitaMisura.ToString();
        String nomeunitadimisura = misura.nomeUnitaMisura;
        Double prezzoUnitario = misura.prezzounitario;
        Double totaleMisura = misura.totalemisura;
        Double totaleImporto = misura.totaleimporto;

        cella = creaCella("", ArialBold, 1, 'r', true); // un po' di tab per la riga misura
        table.AddCell(cella);
        cella = creaCella("", ArialBold, 2, 'r', false); // un po' di tab per la riga misura
        table.AddCell(cella);

        // unita di misura
        //&& totaleMisura > 0 -> tolto
        if (opzioniStampa.stampaMisure == true) {
            cella = creaCella(nomeunitadimisura, ArialBold, 12, 'r', false);
        } else {
            cella = creaCella("", ArialBold, 12, 'r', false);
        }
        table.AddCell(cella);

        // quantita a destra
        if (opzioniStampa.stampaMisure == true) {
            if (totaleMisura > 0)
                cella = creaCella(totaleMisura.ToString("F3"), ArialBold, 3, 'r', false);
            else
                cella = creaCella("", ArialBold, 3, 'r', false);
            cella.BorderWidthTop = 0.1F;
        } else {
            cella = creaCella("", ArialBold, 3, 'r', false);
        }
        table.AddCell(cella);

        // prezzo a destra
        if (opzioniStampa.stampaMisure == true && opzioniStampa.stampaPrezzi == true) {
            // MODIFICA FATTA UN DATA 17/09/2015 dopo la telefonata con Romina. L'unita di misura va mostrata anche se l'importo totale è 0
            //if (totaleMisura > 0)
                cella = creaCella(prezzoUnitario.ToString("F2"), ArialBold, 3, 'r', false);
            //else
            //    cella = creaCella("", ArialBold, 3, 'r', false);
            cella.BorderWidthTop = 0.1F;
        } else {
            cella = creaCella(" ", ArialBold, 3, 'r', false);
        }
        table.AddCell(cella);

        // importo a destra
        if (opzioniStampa.stampaPrezzi) {
            if (totaleMisura > 0)
                cella = creaCella(totaleImporto.ToString(formatoMigliaia), ArialBold, 3, 'r', false);
            else
                cella = creaCella("", ArialBold, 3, 'r', false);

            cella.BorderWidthTop = 0.1F;
        } else {
            cella = creaCella(" ", ArialBold, 3, 'r', false);
        }
        table.AddCell(cella);

    }

    /************************************************* ###TOTALE COMPUTO (ULTIMA PAGINA) *************************************************/

    private static void disegnaTotaleFinale(Document doc1, Double totaleComputo, OpzioniStampa opzioniStampa)
    {
        PdfPTable table = new PdfPTable(24);
        table.WidthPercentage = 100;
        // stampo il totaleComputo (opzione stampaTotaleFinale, non considero stampaPrezzi)
        //if (opzioniStampa.stampaPrezzi == true) {

        // applico l'iva se c'è
        //if (opzioniStampa.iva != DBNull.Value) {
        //    totaleComputo = totaleComputo * (100 + Convert.ToDouble(opzioniStampa.iva)) / 100;
        //}

        PdfPCell cella = creaCella(" ", ArialNormal, 24, 'l');
        table.AddCell(cella);
        cella = creaCella(opzioniStampa.titolocomputo.ToUpper() + " TOTALE IMPONIBILE ", ArialGrandeBold, 12, 'l');
        table.AddCell(cella);
        cella = creaCella(totaleComputo.ToString(formatoValutaMigliaia), ArialGrandeBold, 12, 'r');
        table.AddCell(cella);
        //}
        Paragraph paragraphPerTabellaTotaleFinale = new Paragraph();
        paragraphPerTabellaTotaleFinale.Add(table);
        doc1.Add(paragraphPerTabellaTotaleFinale);
    }


    /* Condizioni ultima pagina */
    private static void disegnaPaginaCondizioniUltimaPagina(Document doc1, PdfWriter writer, DatiComputo datiComputo, OpzioniStampa opzioniStampa)
    {
        /*PdfPTable table; PdfPCell cella; */
        Paragraph paragrafo;
        PdfContentByte cb = writer.DirectContent;

        int condizioniultimapagina_Length = datiComputo.condizioniultimapagina.Length;
        int primoACapo = datiComputo.condizioniultimapagina.IndexOf('\n');
        int spaziatura = 20; // spazio prima del titolo

        // titolo
        if (primoACapo >= 0) {
            String condizioniultimapagina_titolo = datiComputo.condizioniultimapagina.Substring(0, primoACapo);
            paragrafo = new Paragraph(condizioniultimapagina_titolo, ArialTitoloBold); // ArialGrandeBold);
            paragrafo.SpacingBefore = spaziatura;
            spaziatura = 10; // spazio tra il titolo e il testo
            doc1.Add(paragrafo);
        }

        // testo
        String condizioniultimapagina_testo = datiComputo.condizioniultimapagina.Substring(primoACapo + 1, condizioniultimapagina_Length - 1 - primoACapo);
        paragrafo = new Paragraph(condizioniultimapagina_testo, ArialTitoloNormal); // ArialNormal);
        paragrafo.SpacingBefore = spaziatura;
        doc1.Add(paragrafo);
    }

    /* altre funzioni */
    public static PdfPTable disegnaHeaderPagina(PdfContentByte cb, OpzioniStampa opzioniStampa)
    {
        PdfPTable table, table2;
        PdfPCell cella;
        // tabella
        table = new PdfPTable(24);
        table.WidthPercentage = 100;
        if (opzioniStampa.stampaLogo) {

            //DISEGNO IMMAGINE IN POSIZIONE ASSOLUTA.
            //iTextSharp.text.Image imgPROVA = iTextSharp.text.Image.GetInstance(Server.MapPath("~/gestionale/immagini/immagine-muretto.png"));
            //iTextSharp.text.Image imgPROVA = iTextSharp.text.Image.GetInstance("../../../immagini/immagine-muretto.png");
            //iTextSharp.text.Image imgPROVA = iTextSharp.text.Image.GetInstance("/gestionale/immagini/immagine-muretto.png");
            //iTextSharp.text.Image imgPROVA = iTextSharp.text.Image.GetInstance(pathImmagini + "immagine-muretto.png"); -> cambiato in data 09/08/2018
            iTextSharp.text.Image imgPROVA = iTextSharp.text.Image.GetInstance(pathImmagini + "logo-impresa-edile-segatto.jpg");

            //POSIZIONO IMMAGINE
            imgPROVA.SetAbsolutePosition(10, yattuale - imgPROVA.Height);
            imgPROVA.ScalePercent(44);

            cella = new PdfPCell(imgPROVA);
            cella.Border = 0;
            cella.Colspan = 6;
            //cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 2;
            cella.PaddingLeft = 0; cella.PaddingTop = 1; cella.PaddingRight = 8; cella.PaddingBottom = 0;
            cella.HorizontalAlignment = Element.ALIGN_CENTER;
            table.AddCell(cella);

            // Prima cella (su 4)
            table2 = new PdfPTable(24);
            table2.DefaultCell.Border = 0;


            //cella = creaCella("SEGATTO RENZO E F.LLI SNC", ArialNormal, 24, 'l', false);
            //cella.BorderWidthRight = 0;
            //cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            //table2.AddCell(cella);
            //cella = creaCella("di Segatto Renzo & C.", ArialNormal, 24, 'l', false);
            //cella.BorderWidthRight = 0;
            //cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            //table2.AddCell(cella);

            // modificato il 09/08/2018
            cella = creaCella("IMPRESA EDILE SEGATTO SRL", ArialGrandeNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 4; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("IMPRESA COSTRUZIONI EDILI", ArialNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("Via dell'artigianato, 16 - 31040 Chiarano Treviso", ArialNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("Tel. 0422.746046 Fax 0422.806854", ArialNormal, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            //cb.SetColorFill(baseColor_Blu); // testo blu (testo blu e sottolineato per specificare che è un link)
            cella = creaCella("info@impresaedilesegatto.it", ArialUnderline, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 1; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("www.impresaedilesegatto.it", ArialUnderline, 24, 'l', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);
            //cb.SetColorFill(baseColor_Nero); // testo nero (ripristino il colore del testo al colore nero di default)

            // creo una cella che serve solo per riempire lo spazio vuoto
            cella = new PdfPCell(new Phrase(" ", FontFactory.GetFont("Arial", 1, Font.NORMAL))); cella.Colspan = 24; cella.BorderWidth = 0; cella.Padding = 0;
            table2.AddCell(cella);

            cella = new PdfPCell(table2);
            cella.BorderWidthLeft = 0; cella.BorderWidthTop = 0; cella.BorderWidthRight = 0; cella.BorderWidthBottom = 0;
            cella.Colspan = 9;
            cella.Padding = 0;
            table.AddCell(cella);

            // Terza e quarta cella (su 4)
            table2 = new PdfPTable(24);

            /*cella = creaCella("VIA DELL'ARTIGIANATO, 16", ArialBold, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.Padding = 2; cella.PaddingTop = 0; // al top assegno sempre 2px in meno
            table2.AddCell(cella);
            cella = creaCella("31040 CHIARANO TV tel. +39 0422 746046", ArialBold, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.Padding = 2; cella.PaddingTop = 0; // al top assegno sempre 2px in meno
            table2.AddCell(cella);
            cella = creaCella("www.impresaedilesegatto.it - info@impresaedilesegatto.it", ArialBold, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.Padding = 2; cella.PaddingTop = 0; // al top assegno sempre 2px in meno
            table2.AddCell(cella);*/

            cella = creaCella("Reg.Imp. TV n.8734/96 - Reg.Ditte n. 125254", ArialNormal, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("P.IVA e C.F. 00538590266", ArialNormal, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            cella = creaCella("C.C.I.A.A. n. 39097", ArialNormal, 24, 'r', false);
            cella.BorderWidthRight = 0;
            cella.PaddingLeft = 0; cella.PaddingTop = 3; cella.PaddingRight = 0; cella.PaddingBottom = 0;
            table2.AddCell(cella);

            // creo una cella che serve solo per riempire lo spazio vuoto
            cella = new PdfPCell(new Phrase(" ", FontFactory.GetFont("Arial", 1, Font.NORMAL))); cella.Colspan = 24; cella.BorderWidth = 0; cella.Padding = 0;
            table2.AddCell(cella);

            cella = new PdfPCell(table2);
            cella.BorderWidthLeft = 0; cella.BorderWidthTop = 0; cella.BorderWidthRight = 0; cella.BorderWidthBottom = 0;
            cella.Colspan = 9;
            cella.Padding = 0;
            cella.PaddingTop = 0;

            table.AddCell(cella);

            // lascio un po' di spazio tra questo e il prossimo elemento
            table.SpacingAfter = 10;
        }

        return table;
    }

    private static void stampaTesto(Document doc1, PdfContentByte cb, String testo)
    {
        stampaTesto(doc1, cb, testo, width / 2, 10, "l");
    }
    private static void stampaTesto(Document doc1, PdfContentByte cb, String testo, Int32 xattuale)
    {
        stampaTesto(doc1, cb, testo, xattuale, 10, "l");
    }
    private static void stampaTesto(Document doc1, PdfContentByte cb, String testo, Int32 xattuale, Int32 fontSize)
    {
        stampaTesto(doc1, cb, testo, xattuale, fontSize, "l");
    }
    private static void stampaTesto(Document doc1, PdfContentByte cb, String testo, Int32 xattuale, Int32 fontSize, string textAlign)
    {
        /*if (yattuale < 0) { //AGGIUNGO NUOVA PAGINA SE SERVE l'ho commentato perchè in teoria lo fa in automatico, da testare se no decommentare
            doc1.NewPage(); yattuale = height;
        }*/
        cb.SetFontAndSize(FontFactory.GetFont(FontFactory.HELVETICA).BaseFont, fontSize);
        cb.BeginText();
        if (textAlign.ToLower() == "l") cb.ShowTextAligned(PdfContentByte.ALIGN_LEFT, testo, xattuale, yattuale, 0);
        else if (textAlign.ToLower() == "c") cb.ShowTextAligned(PdfContentByte.ALIGN_CENTER, testo, xattuale, yattuale, 0);
        else if (textAlign.ToLower() == "r") cb.ShowTextAligned(PdfContentByte.ALIGN_RIGHT, testo, xattuale, yattuale, 0);
        cb.EndText();

        int paddingBottom = (fontSize + 1 + (int)(fontSize / 10));
        yattuale -= paddingBottom;
    }

    public static PdfPCell creaCella(String testo)
    {
        Font font = FontFactory.GetFont("Arial", 12, Font.NORMAL);
        PdfPCell cella = creaCella(testo, font);
        return cella;
    }
    public static PdfPCell creaCella(String testo, int fontSize)
    {
        Font font = FontFactory.GetFont("Arial", fontSize, Font.NORMAL);
        PdfPCell cella = creaCella(testo, font);
        return cella;
    }
    public static PdfPCell creaCella(String testo, Font font)
    {
        PdfPCell cella = new PdfPCell(new Phrase(testo, font));
        cella.UseVariableBorders = true;

        // border e padding
        cella.BorderWidth = 0;
        cella.Padding = 5; cella.PaddingTop = 3;

        return cella;
    }
    public static PdfPCell creaCella(String testo, Font font, int colspan)
    {
        PdfPCell cella = new PdfPCell(new Phrase(testo, font)); cella.Colspan = colspan;
        cella.UseVariableBorders = true;

        // border e padding
        cella.BorderWidth = 0;
        cella.Padding = 5; cella.PaddingTop = 3;

        return cella;
    }
    public static PdfPCell creaCella(String testo, Font font, int colspan, char align)
    {
        PdfPCell cella = new PdfPCell(new Phrase(testo, font)); cella.Colspan = colspan;
        cella.UseVariableBorders = true;

        // border e padding
        cella.BorderWidth = 0;
        cella.Padding = 5; cella.PaddingTop = 3;

        // allineamento
        if (align == 'c') cella.HorizontalAlignment = Element.ALIGN_CENTER;
        else if (align == 'r') cella.HorizontalAlignment = Element.ALIGN_RIGHT;
        else if (align == 'l') cella.HorizontalAlignment = Element.ALIGN_LEFT;

        return cella;
    }
    // false mette un bordo a destra, true anche un bordo a sinistra
    public static PdfPCell creaCella(String testo, Font font, int colspan, char align, bool primaCella)
    {

        PdfPCell cella = new PdfPCell(new Phrase(testo, font)); cella.Colspan = colspan;
        cella.UseVariableBorders = true;

        // border
        cella.BorderWidth = 0;
        cella.BorderWidthRight = 0.1F;
        if (primaCella)
            cella.BorderWidthLeft = 0.1F;

        // line height
        cella.SetLeading(0f, 1.2f);

        // padding
        cella.Padding = 5; cella.PaddingTop = 3;

        // allineamento
        if (align == 'c')
            cella.HorizontalAlignment = Element.ALIGN_CENTER;
        else if (align == 'r')
            cella.HorizontalAlignment = Element.ALIGN_RIGHT;
        else if (align == 'l')
            cella.HorizontalAlignment = Element.ALIGN_LEFT;

        cella.VerticalAlignment = Element.ALIGN_MIDDLE;

        return cella;
    }
    // false mette un bordo a destra, true anche un bordo a sinistra
    public static PdfPCell creaCellaConTestoHTML(String testo, Font font, int colspan, char align, bool primaCella)
    {
        // converti in html
        testo = formattaTestoInHTML(testo);
        Paragraph paragraph = CreateSimpleHtmlPhrase(testo);
        paragraph.Font = font;
        PdfPCell cella = new PdfPCell(paragraph);
        cella.Colspan = colspan;
        cella.UseVariableBorders = true;

        // line height
        cella.SetLeading(0f, 1.2f);

        // border
        cella.BorderWidth = 0;
        cella.BorderWidthRight = 0.1F;
        if (primaCella)
            cella.BorderWidthLeft = 0.1F;

        // padding
        cella.Padding = 5; cella.PaddingTop = 3;

        // allineamento
        if (align == 'c')
            cella.HorizontalAlignment = Element.ALIGN_CENTER;
        else if (align == 'r')
            cella.HorizontalAlignment = Element.ALIGN_RIGHT;
        else if (align == 'l')
            cella.HorizontalAlignment = Element.ALIGN_LEFT;

        cella.VerticalAlignment = Element.ALIGN_MIDDLE;

        return cella;
    }
    public static string formattaTestoInHTML(string testo)
    {
        // a capo riga
        testo = testo.Replace("\n", "<br />");

        // maiuscolo/minuscolo. tag di chiusura
        testo = testo.Replace("/#G", "</b>"); testo = testo.Replace("/#g", "</b>");
        testo = testo.Replace("/#C", "</i>"); testo = testo.Replace("/#c", "</i>");
        testo = testo.Replace("/#S", "</u>"); testo = testo.Replace("/#s", "</u>");
        testo = testo.Replace("/#B", "</strike>"); testo = testo.Replace("/#b", "</strike>");
        testo = testo.Replace("/#R", "</span>"); testo = testo.Replace("/#r", "</span>");

        // maiuscolo/minuscolo. tag di apertura
        testo = testo.Replace("#G", "<b>"); testo = testo.Replace("#g", "<b>");
        testo = testo.Replace("#C", "<i>"); testo = testo.Replace("#c", "<i>");
        testo = testo.Replace("#S", "<u>"); testo = testo.Replace("#s", "<u>");
        testo = testo.Replace("#B", "<strike>"); testo = testo.Replace("#b", "<strike>");
        testo = testo.Replace("#R", "<span style='color:red'>"); testo = testo.Replace("#r", "<span style='color:red'>");

        return testo;
    }
    public static Paragraph CreateSimpleHtmlPhrase(String text)
    {
        //Our return object
        Paragraph p = new Paragraph();
        
        //ParseToList requires a StreamReader instead of just text
        // DZ 2016 12 28 - va in errore con <u><</u>, probabilmente non accetta il minore...per il momento risolvo con una patch
        using (StringReader sr = new StringReader(text.Replace("<u><</u>", "<"))) {
            //Parse and get a collection of elements
            List<IElement> elements = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(sr, null);
            foreach (IElement e in elements) {
                //Add those elements to the paragraph
                p.Add(e);
            }
        }
        //Return the paragraph
        return p;
    }
    // disegna rettangolo(left, top, right, bottom, colore);
    public static void disegnaRettangolo(int left, int top, int right, int bottom, PdfContentByte cb, BaseColor colore)
    {
        cb.SetColorFill(colore);
        //PARAMETRI: LEFT, TOP, WIDTH, HEIGHT
        cb.Rectangle(left, top, right - left, bottom - top);
        cb.Fill();
    }

    //EVENTO PER LA GENERAZIONE AUTOMATICA DEL FOOTER ^_^
    internal class MainTextEventsHandler : PdfPageEventHelper
    {
        public override void OnStartPage(PdfWriter writer, Document document)
        {
            //GENERO IL FOOTER
            if (stampaNumeroPagina)
                generaFOOTER(document, writer);

            //RESETTO LA POSIZIONE Y ^_^
            modelli_generazione_pdf_genera_pdf.resettayperNuovoFoglio();
        }

        //METODO PER GENERARE FOOTER
        private void generaFOOTER(Document d1, PdfWriter writer)
        {            
            PdfContentByte cb = writer.DirectContent;

            //BaseFont FontFOOTER = FontFactory.GetFont(FontFactory.COURIER_BOLD).BaseFont;
            //cb.SetFontAndSize(FontFOOTER, 10);

            BaseFont temp = FontFactory.GetFont(FontFactory.HELVETICA).BaseFont;
            cb.SetFontAndSize(temp, 10);

            cb.BeginText();
            //NON ASCOLTA IL MARGIN BOTTOM DELLA PAGINA!
            cb.ShowTextAligned(PdfContentByte.ALIGN_CENTER, writer.CurrentPageNumber.ToString(), 410, foglio_marginTopBottom-15, 0);
            cb.EndText();
        }
    }
}

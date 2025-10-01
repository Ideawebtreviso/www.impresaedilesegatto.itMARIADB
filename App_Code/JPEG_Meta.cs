//using System;
//using System.Collections.Generic;
//using System.Web;
//using System.Drawing;
//using System.Drawing.Imaging;
//using System.Diagnostics;
//using System.Reflection;
//using System.IO;
//using System.Windows.Media.Imaging;

///// <summary>
///// Descrizione di riepilogo per JPEG_Meta
///// </summary>
//public class JPEG_Meta
//{
//    public JPEG_Meta()
//    {
//    }
//    public static Boolean SaveMeta(String file, List<String> _keywords, String URL_sito, String artist)
//    {
//        String file_ = Path.GetFileNameWithoutExtension(file);
//        file_ = file_.ToLower().Replace("-", " ").Replace("_thumb", "").Replace(" ", "")
//            .Replace("0", "").Replace("1", "").Replace("2", "").Replace("3", "").Replace("4", "").Replace("5", "").Replace("6", "").Replace("7", "").
//            Replace("8", "").Replace("9", "");
//        String fileEXT = Path.GetExtension(file);

//        String titolo = _keywords[0];

//        String commenti = _keywords[0];

//        //KEYWORDS
//        /*
//        List<String> kw = new List<String>();
//        String kw_Buffer = titolo + "; Fna; Confappi; Amministratori condominiali; corsi per amministratore condominiale; Treviso; Confederazione piccoli proprietari immobiliari;";
//        String k = "";
//        for (int i = 0; i < kw_Buffer.Length; ++i)
//        {
//            if (kw_Buffer[i] == ';')
//            {
//                kw.Add(k);
//                k = "";
//            }
//            else
//            {
//                k += kw_Buffer[i];
//            }
//        }*/
//        System.Collections.ObjectModel.ReadOnlyCollection<String> keywords = 
//            new System.Collections.ObjectModel.ReadOnlyCollection<String>(_keywords);

//        //ARTISTA
//        String artista = artist;

//        //COPYRIGHT
//        String copyright = "Copyright "+DateTime.Now.Year+" - "+URL_sito;

//        //PROGRAMMA
//        String programma = "";

//        //DATAORAMODIFICA.
//        String dataoramodifica = DateTime.Now.ToString("yyyy:MM:dd") + "  " + DateTime.Now.ToString("HH:mm:ss");


//        BitmapFrame to_save;
//        BitmapDecoder decoder;

//        try
//        {
//            //FileIOPermission filePerm = new FileIOPermission(PermissionState.Unrestricted);
//            //filePerm.AllFiles = FileIOPermissionAccess.Write;
//            using (
//                Stream jpegStreamIn = File.Open(file, FileMode.Open, FileAccess.ReadWrite, FileShare.None))
//            {
//                decoder = BitmapDecoder.Create(jpegStreamIn, BitmapCreateOptions.PreservePixelFormat, BitmapCacheOption.OnLoad);
//                to_save = decoder.Frames[0];
//            }
//            InPlaceBitmapMetadataWriter writer = to_save.CreateInPlaceBitmapMetadataWriter();
//            //FUNZIONANO
//            //TITOLO
//            writer.Title = titolo;
//            //DESCRIZIONE
//            writer.SetQuery("/app1/ifd/exif:{uint=270}", commenti);
//            //KEYWORDS
//            writer.Keywords = keywords;
//            //ARTISTA
//            writer.SetQuery("/app1/ifd/exif:{uint=315}", artista);
//            //RATING
//            writer.SetQuery("/app1/ifd/exif:{uint=18246}", "5");
//            //PROGRAMMA USATO
//            writer.SetQuery("/app1/ifd/exif:{uint=305}", programma);
//            //COPYRIGHT
//            writer.SetQuery("/app1/ifd/exif:{uint=33432}", copyright);
//            //DATA E ORA MODIFICA
//            writer.SetQuery("/app1/ifd/exif:{uint=306}", dataoramodifica);


//            //SALVATAGGIO IMMAGINE
//            JpegBitmapEncoder encoder = new JpegBitmapEncoder();
//            encoder.QualityLevel = 95;
//            encoder.Frames.Add(BitmapFrame.Create(to_save, to_save.Thumbnail, writer, to_save.ColorContexts));
//            using (Stream jpegStreamOut = File.Open(file, FileMode.Create, FileAccess.ReadWrite))
//            {
//                encoder.Save(jpegStreamOut);
//            }
//            return true;
//        }
//        catch(Exception ex)
//        {
//            return false;
//        }
//    }
//}
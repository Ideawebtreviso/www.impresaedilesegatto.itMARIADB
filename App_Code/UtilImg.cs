using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

/// <summary>
/// Descrizione di riepilogo per UtilImg
/// </summary>
public class UtilImg
{
    public static int width = 160;
    public static int height = 120;
    public static Color coloreDiSfondo = Color.White;

	public UtilImg()
	{
		//
		// TODO: aggiungere qui la logica del costruttore
		//
	}
    public static Bitmap creaIcona(Bitmap immagine) {

        int thumbWidth = -1;
        int thumbHeight = -1;

        int originalWidth = immagine.Width;
        int originalHeight = immagine.Height;

        double rationOriginalImage = (1.0 * originalWidth / originalHeight);
        double ratioThumb = (1.0 * UtilImg.width / UtilImg.height);
        // Se l'immagine eccede in larghezza...
        if (rationOriginalImage > ratioThumb)
        {
            thumbWidth = UtilImg.width;
            double thumbHeightDouble = UtilImg.width / rationOriginalImage;
            thumbHeight = Convert.ToInt32(Math.Truncate(thumbHeightDouble));
        }
        else
        {//... altrimenti eccede in altezza
            thumbHeight = UtilImg.height;
            double thumbWidthDouble = UtilImg.height * rationOriginalImage;
            thumbWidth = Convert.ToInt32(Math.Truncate(thumbWidthDouble));
        }

        int posIntoThumbHoriz = Convert.ToInt32((UtilImg.width - thumbWidth) / 2);
        int posIntoThumbVert = Convert.ToInt32((UtilImg.height - thumbHeight) / 2);

        Rectangle r = new Rectangle(posIntoThumbHoriz, posIntoThumbVert, thumbWidth, thumbHeight);


        Bitmap b = new Bitmap(UtilImg.width, UtilImg.height);
        Graphics g = Graphics.FromImage(b);
        g.FillRectangle(new SolidBrush(UtilImg.coloreDiSfondo), 0, 0, UtilImg.width, UtilImg.height);
        
        g.DrawImage(immagine, r);
        return (Bitmap)b;

        /*
        int thumbWidth = -1;
        int thumbHeight = -1;
        
        int originalWidth = immagine.Width;
        int originalHeight = immagine.Height;

        double rationOriginalImage = (1.0 * originalWidth / originalHeight);
        double ratioThumb = (1.0 * UtilImg.width / UtilImg.height);
        // Se l'immagine eccede in larghezza...
        if (rationOriginalImage > ratioThumb) {
            thumbWidth = UtilImg.width;
            double thumbHeightDouble = UtilImg.width / rationOriginalImage;
            thumbHeight = Convert.ToInt32(Math.Truncate(thumbHeightDouble));
        }
        else {//... altrimenti eccede in altezza
            thumbHeight = UtilImg.height;
            double thumbWidthDouble = UtilImg.height * rationOriginalImage;
            thumbWidth = Convert.ToInt32(Math.Truncate(thumbWidthDouble));
        }

        System.Drawing.Image pThumbnail = immagine.GetThumbnailImage(thumbWidth, thumbHeight, null, IntPtr.Zero);
       


        int posIntoThumbHoriz = Convert.ToInt32((UtilImg.width - thumbWidth) / 2);
        int posIntoThumbVert = Convert.ToInt32((UtilImg.height - thumbHeight) / 2);
        g.DrawImage(immagine, posIntoThumbHoriz, posIntoThumbVert);
        return b;
         * */
    }

    public static EncoderParameters  getEncoderParameters() {

        ImageCodecInfo jgpEncoder = GetEncoder(ImageFormat.Jpeg);

        // Create an Encoder object based on the GUID
        // for the Quality parameter category.
        System.Drawing.Imaging.Encoder myEncoder = System.Drawing.Imaging.Encoder.Quality;

        // Create an EncoderParameters object.
        // An EncoderParameters object has an array of EncoderParameter
        // objects. In this case, there is only one
        // EncoderParameter object in the array.
        EncoderParameters myEncoderParameters = new EncoderParameters(1);

        EncoderParameter myEncoderParameter = new EncoderParameter(myEncoder, 95L);
        myEncoderParameters.Param[0] = myEncoderParameter;

        /*
        Encoder myEncoderCompression = Encoder.Compression;
        EncoderParameter myEncoderParameterCompression = new EncoderParameter(myEncoderCompression, (long) EncoderValue.ColorTypeCMYK);
        myEncoderParameters.Param[0] = myEncoderParameterCompression;
        */

        return myEncoderParameters;
    
    }

    public static ImageCodecInfo GetEncoderJpeg()
    {

        ImageCodecInfo[] codecs = ImageCodecInfo.GetImageDecoders();

        foreach (ImageCodecInfo codec in codecs)
        {
            if (codec.FormatID ==ImageFormat.Jpeg.Guid)
            {
                return codec;
            }
        }
        return null;
    }
    public static ImageCodecInfo GetEncoder(ImageFormat format)
    {

        ImageCodecInfo[] codecs = ImageCodecInfo.GetImageDecoders();

        foreach (ImageCodecInfo codec in codecs)
        {
            if (codec.FormatID == format.Guid)
            {
                return codec;
            }
        }
        return null;
    }

   
}

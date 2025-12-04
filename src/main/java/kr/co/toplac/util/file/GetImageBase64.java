package kr.co.toplac.util.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

/*
*********************************************************
* Program ID	: GetImageBase64
* Program Name	: GetImageBase64
* Description	: ImageBase64로 인코딩된 String을 얻는 Class
* Author		: rjh
* Date			: 2016.04.19.
*********************************************************
*/
public class GetImageBase64 {

	/*
	*********************************************************
	* Method ID		: getOneImgeBase64
	* Method Name	: getOneImgeBase64
	* Description	: ImageBase64로 인코딩된 String 하나를 얻는 Class
	* Author		: rjh
	* Date			: 2016.04.19.
	*********************************************************
	*/
	public String getOneImgeBase64(String dbpath, String fileType){

		File uploadFile = new File(dbpath);

		BufferedImage originalImage = null;
		
		try {
			originalImage = ImageIO.read(uploadFile);
		} catch (IOException e1) {
			e1.printStackTrace();
			return "data:image/png;base64,";
		}
		
		int iheight = originalImage.getHeight();
		int iwidth = originalImage.getWidth();
		
		
		//long fileSize = uploadFile.length();
        
        //System.out.println("File Size :["+fileSize/1024+"]kb");
        
        File thumbnail = null;
		try {
			thumbnail = File.createTempFile("c:\\", "." + fileType);
            //System.out.println("FILE PATH:["+thumbnail.getAbsolutePath()+"]");
            
        } catch (IOException e) {
			e.printStackTrace();
		} 
		try {
			ThumbnailUtil.makeThumbnail( uploadFile, thumbnail, iwidth, iheight);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String imageBase64 = ImageUtils.encodeToString( thumbnail, fileType);

		return "data:image/png;base64," + imageBase64;
	}//end of getOneImge
    
    /**
     * 작은 이미지 전용 base64 스트링 생성
     * @param dbpath
     * @param fileType
     * @return
     */
	public String imageBase64Small(String dbpath, String fileType){
        
        File imageFile = new File(dbpath);
	    
        if (!imageFile.exists()){
            System.out.println("FILE NOT EXISTS!!");
            return "data:image/png;base64,";
        }
        
        String imageBase64 = ImageUtils.encodeToString(imageFile, fileType);
        return "data:image/png;base64," + imageBase64;
    }
}

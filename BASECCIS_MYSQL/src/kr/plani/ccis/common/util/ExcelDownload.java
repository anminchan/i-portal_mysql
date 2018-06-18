package kr.plani.ccis.common.util;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.service.common.CommonService;

public class ExcelDownload {
	private static final Logger logger = LoggerFactory.getLogger(ExcelDownload.class);
	
	/** 공통기능 서비스   */
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	 * excelDownload 목록 엑셀 다운로드
	 * @param excelDataList
	 * @param headerName
	 * @param columnName
	 * @param sheetName
	*******************************************************************/
	public static void excelDownload(HttpServletResponse response, List<HashMap<String, String>> excelDataList, String[] headerName, String[] columnName, String sheetName){

		// Workbook 및 Helper 생성
		
		String f_name = "";
		try {
			f_name = URLEncoder.encode(sheetName, "UTF-8");
			f_name = f_name.replaceAll("\\+", " "); 
		} catch (UnsupportedEncodingException e2) {
			logger.info("오류발생");
		} 
		
		//hashmap에 int로 입력되어 있는 것을  String으로 바꾸는 로직 추가
		for(int i = 0; i < excelDataList.size(); i++){
			for(int j=0; j < columnName.length; j++){
				((Map)excelDataList.get(i)).put(columnName[j].toUpperCase(), (((Map)excelDataList.get(i)).get(columnName[j].toUpperCase()) + ""));
			}
		}
		
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename="+f_name+".xls");	//엑셀작성될 화일명지정
	    response.setHeader("Content-Description", "JSP Generated Data");  							//요거 중요함..
	    response.setHeader("Content-Transfer-Encoding", "binary;");
	    response.setHeader("Pragma", "no-cache;");
	    response.setHeader("Expires", "-1;"); 

		HSSFWorkbook wb = new HSSFWorkbook();

		// 스타일을 사용할 Map을 만들어준다.
		Map<String, CellStyle> styles = createStyles(wb);
		
		Row row;
		Cell cell;
		Sheet hssfSheet;

		// Sheet 생성
		hssfSheet = wb.createSheet(sheetName);

		BufferedOutputStream fileOut = null;
		
		try {
			
			fileOut = new BufferedOutputStream(response.getOutputStream());
	
			int rowIndex = 0;
			int cellIndex = 0;
			
			row = hssfSheet.createRow(rowIndex++);
			row.setHeight((short)420);
			
			for(int i = 0; i < headerName.length; i++){
				cell = row.createCell(cellIndex++);
				cell.setCellValue(headerName[i]);
				cell.setCellStyle(styles.get("default_header_style"));
				hssfSheet.setColumnWidth(i, 6000);
			}
			
			
			for(int i=0; i<excelDataList.size(); i++){
				row = hssfSheet.createRow(rowIndex++);
				cellIndex = 0;
				for(int j=0; j < columnName.length; j++){
					cell = row.createCell(cellIndex++);
					cell.setCellValue(excelDataList.get(i).get(columnName[j].toUpperCase()) == null ? "" : excelDataList.get(i).get(columnName[j].toUpperCase()));
					cell.setCellStyle(styles.get("default_content_style"));
				}
				
			}
			
			wb.write(fileOut);

		}catch(Exception e){
			try {
				throw e;
			} catch (Exception e1) {
				logger.info("오류발생");
			}
		}finally{
			if(fileOut != null){
				try {
					fileOut.close();
				} catch (IOException e) {
					logger.info("오류발생");
				}
			}
		}
	}

	
	/*****************************************************************
	 * excelDownload 목록 엑셀 다운로드
	 * @param excelDataList
	 * @param headerName
	 * @param columnName
	 * @param sheetName
	*******************************************************************/
	public static void excelDownloadPesonInfo(CommonService commonService, HttpServletResponse response, List<HashMap<String, String>> excelDataList, String[] headerName, String[] columnName, String sheetName, DefaultDomain defaultDomain, String menuId, String inRECUserID, String fileGubun){

		String f_name = "";
		try {
			f_name = URLEncoder.encode(sheetName, "UTF-8");
			f_name = f_name.replaceAll("\\+", " "); 
		} catch (UnsupportedEncodingException e2) {
			logger.info("오류발생");
		} 
		
		//hashmap에 int로 입력되어 있는 것을  String으로 바꾸는 로직 추가
		for(int i = 0; i < excelDataList.size(); i++){
			for(int j=0; j < columnName.length; j++){
				((Map)excelDataList.get(i)).put(columnName[j].toUpperCase(), (((Map)excelDataList.get(i)).get(columnName[j].toUpperCase()) + ""));
			}
		}
		
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename="+f_name+".xls");	//엑셀작성될 화일명지정
	    response.setHeader("Content-Description", "JSP Generated Data");  							//요거 중요함..
	    response.setHeader("Content-Transfer-Encoding", "binary;");
	    response.setHeader("Pragma", "no-cache;");
	    response.setHeader("Expires", "-1;"); 

		HSSFWorkbook wb = new HSSFWorkbook();

		// 스타일을 사용할 Map을 만들어준다.
		Map<String, CellStyle> styles = createStyles(wb);
		
		Row row;
		Cell cell;
		Sheet hssfSheet;

		// Sheet 생성
		hssfSheet = wb.createSheet(sheetName);

		// 파일 사이즈 구하기 위해
		ByteArrayOutputStream bos = null;
		
		try {
			bos = new ByteArrayOutputStream();
			
			int rowIndex = 0;
			int cellIndex = 0;
			
			row = hssfSheet.createRow(rowIndex++);
			row.setHeight((short)420);
			
			for(int i = 0; i < headerName.length; i++){
				cell = row.createCell(cellIndex++);
				cell.setCellValue(headerName[i]);
				cell.setCellStyle(styles.get("default_header_style"));
				hssfSheet.setColumnWidth(i, 6000);
			}
			
			
			for(int i=0; i<excelDataList.size(); i++){
				row = hssfSheet.createRow(rowIndex++);
				cellIndex = 0;
				for(int j=0; j < columnName.length; j++){
					cell = row.createCell(cellIndex++);
					cell.setCellValue(excelDataList.get(i).get(columnName[j].toUpperCase()) == null ? "" : excelDataList.get(i).get(columnName[j].toUpperCase()));
					cell.setCellStyle(styles.get("default_content_style"));
				}
			}
			
			//wb.write(fileOut);
			wb.write(bos);
			response.setHeader("Content-Length", ""+bos.size());
			wb.write(response.getOutputStream());
			int length = bos.size();
			
			logger.info("", length);
			
			//개인정보로그 인서트 호출
			defaultDomain.setInExecMenuId(menuId);
			defaultDomain.setInRECUserID(inRECUserID);
			defaultDomain.setInRECDesc("엑셀 다운로드");
			defaultDomain.setInGubun("E");
			defaultDomain.setFileGubun(fileGubun);
			defaultDomain.setNo2(Integer.toString(length));
			commonService.insertUserInfoLog(defaultDomain);
			
		}catch(Exception e){
			try {
				throw e;
			} catch (Exception e1) {
				logger.info("오류발생");
			}
		}finally{
			if(bos != null){
				try {
					bos.close();
				} catch (IOException e) {
					logger.info("오류발생");
				}
			}
		}
	}
	
	public static void excelDownload2(CommonService commonService, HttpServletResponse response, List<HashMap<String, String>> excelDataList, String[] headerName, String[] columnName, String sheetName, String title, DefaultDomain defaultDomain, String menuId, String inRECUserID, String fileGubun){

		// Workbook 및 Helper 생성
		
		String f_name = "";
		try {
			f_name = URLEncoder.encode(sheetName, "UTF-8");
			f_name = f_name.replaceAll("\\+", " "); 
		} catch (UnsupportedEncodingException e2) {
			logger.info("오류발생");
		} 
		
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename="+f_name+".xls");	//엑셀작성될 화일명지정
	    response.setHeader("Content-Description", "JSP Generated Data");  							//요거 중요함..
	    response.setHeader("Content-Transfer-Encoding", "binary;");
	    response.setHeader("Pragma", "no-cache;");
	    response.setHeader("Expires", "-1;"); 

		HSSFWorkbook wb = new HSSFWorkbook();

		// 스타일을 사용할 Map을 만들어준다.
		Map<String, CellStyle> styles = createStyles(wb);
		
		HSSFCellStyle cs = wb.createCellStyle();
		Font font1 = wb.createFont();
		font1.setBoldweight(Font.BOLDWEIGHT_BOLD);
		
		cs.setAlignment(CellStyle.ALIGN_LEFT);
		cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		cs.setFont(font1);
		cs.setBorderBottom(CellStyle.BORDER_THIN);
		cs.setBorderLeft(CellStyle.BORDER_THIN);
		cs.setBorderRight(CellStyle.BORDER_THIN);
		cs.setBorderTop(CellStyle.BORDER_THIN);
		
		Row row;
		Cell cell;
		Sheet hssfSheet;

		// Sheet 생성
		hssfSheet = wb.createSheet(sheetName);

		//BufferedOutputStream fileOut = null;
		
		// 파일 사이즈 구하기 위해
		ByteArrayOutputStream bos = null;
		
		try {
			
			//fileOut = new BufferedOutputStream(response.getOutputStream());
			
			bos = new ByteArrayOutputStream();
	
			int rowIndex = 0;
			int cellIndex = 0;

			// title
			row = hssfSheet.createRow(rowIndex++);
			row.setHeight((short)450);
			cell = row.createCell(0);
			cell.setCellValue(title);
			cell.setCellStyle(cs);
			hssfSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, headerName.length-1));

			row = hssfSheet.createRow(rowIndex++);
			row.setHeight((short)420);
			
			for(int i = 0; i < headerName.length; i++){
				cell = row.createCell(cellIndex++);
				cell.setCellValue(headerName[i]);
				cell.setCellStyle(styles.get("default_header_style"));
				hssfSheet.setColumnWidth(i, 6000);
			}
			
			
			for(int i=0; i<excelDataList.size(); i++){
				row = hssfSheet.createRow(rowIndex++);
				cellIndex = 0;
				for(int j=0; j < columnName.length; j++){
					cell = row.createCell(cellIndex++);
					cell.setCellValue(excelDataList.get(i).get(columnName[j].toUpperCase()) == null ? "" : excelDataList.get(i).get(columnName[j].toUpperCase()));
					cell.setCellStyle(styles.get("default_content_style"));
				}
				
			}
			
			//wb.write(fileOut);
			wb.write(bos);
			response.setHeader("Content-Length", ""+bos.size());
			wb.write(response.getOutputStream());
			int length = bos.size();
			
			logger.info("", length);
			
			//개인정보로그 인서트 호출
			defaultDomain.setInExecMenuId(menuId);
			defaultDomain.setInRECUserID(inRECUserID);
			defaultDomain.setInRECDesc("주소록 다운로드");
			defaultDomain.setInGubun("E");
			defaultDomain.setFileGubun(fileGubun);
			defaultDomain.setNo2(Integer.toString(length));
			commonService.insertUserInfoLog(defaultDomain);
			
		}catch(Exception e){
			try {
				throw e;
			} catch (Exception e1) {
				logger.info("오류발생");
			}
		}finally{
			if(bos != null){
				try {
					bos.close();
				} catch (IOException e) {
					logger.info("오류발생");
				}
			}
		}
	}

	public static void excelDownload3(HttpServletResponse response, List<HashMap<String, String>> excelDataList, String[][] headerName, String[] columnName, String sheetName){

		// Workbook 및 Helper 생성
		
		String f_name = "";
		try {
			f_name = URLEncoder.encode(sheetName, "UTF-8");
			f_name = f_name.replaceAll("\\+", " "); 
		} catch (UnsupportedEncodingException e2) {
			logger.info("오류발생");
		} 
		
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename="+f_name+".xls");	//엑셀작성될 화일명지정
	    response.setHeader("Content-Description", "JSP Generated Data");  							//요거 중요함..
	    response.setHeader("Content-Transfer-Encoding", "binary;");
	    response.setHeader("Pragma", "no-cache;");
	    response.setHeader("Expires", "-1;"); 

		HSSFWorkbook wb = new HSSFWorkbook();

		// 스타일을 사용할 Map을 만들어준다.
		Map<String, CellStyle> styles = createStyles(wb);
		
		Row row;
		Cell cell;
		Sheet hssfSheet;

		// Sheet 생성
		hssfSheet = wb.createSheet(sheetName);

		BufferedOutputStream fileOut = null;
		try {
			fileOut = new BufferedOutputStream(response.getOutputStream());
	
			int rowIndex = 0;
			int cellIndex = 0;
			
			for(int i = 0; i < headerName.length; i++){
				if(i == 0){
					hssfSheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
				}
				row = hssfSheet.createRow(rowIndex++);
				row.setHeight((short)420);
				cellIndex = i == 0 ? 0 : 1;
				for(int j = 0; j < headerName[i].length; j++){
					if(i == 0 && j != 0){
						hssfSheet.addMergedRegion(new CellRangeAddress(0, 0, j * 2 - 1, j * 2));
						cell = row.createCell(cellIndex);
						cellIndex += 2;
					}else{
						cell = row.createCell(cellIndex++);
					}
					cell.setCellValue(headerName[i][j]);
					cell.setCellStyle(styles.get("default_header_style"));
				}
			}
			
			int[] total = new int[columnName.length - 1];
			
			for(int i=0; i<excelDataList.size(); i++){
				row = hssfSheet.createRow(rowIndex++);
				cellIndex = 0;
				for(int j=0; j < columnName.length; j++){
					cell = row.createCell(cellIndex++);
					cell.setCellValue(String.valueOf(excelDataList.get(i).get(columnName[j].toUpperCase())));
					cell.setCellStyle(styles.get("default_content_style"));
					if(j != 0){
						total[j-1] += Integer.parseInt(String.valueOf(excelDataList.get(i).get(columnName[j].toUpperCase())));
					}
				}
				
			}
			row = hssfSheet.createRow(rowIndex++);
			cellIndex = 0;
			for(int i = 0; i < columnName.length; i++){
				cell = row.createCell(cellIndex++);
				if(i == 0){
					cell.setCellValue("계");
				}else{
					cell.setCellValue(total[i - 1]);
				}
				cell.setCellStyle(styles.get("default_header_style"));
				hssfSheet.setColumnWidth(i, 4000);
			}
			wb.write(fileOut);
			
		}catch(Exception e){
			try {
				throw e;
			} catch (Exception e1) {
				logger.info("오류발생");
			}
		}finally{
			if(fileOut != null){
				try {
					fileOut.close();
				} catch (IOException e) {
					logger.info("오류발생");
				}
			}
		}
	}
	
	// 엑셀 스타일
	private static Map<String, CellStyle> createStyles(Workbook wb) {
		Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
		DataFormat df = wb.createDataFormat();

		CellStyle style;
		Font headerFont = wb.createFont();
		headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);

		Font font1 = wb.createFont();
		font1.setBoldweight(Font.BOLDWEIGHT_BOLD);

		Font font2 = wb.createFont();
		font2.setBoldweight(Font.BOLDWEIGHT_NORMAL);

		// 현재 사용하고 있는 스타일
		style = createBorderedStyle(wb);
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(font1);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setFillBackgroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());    
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		styles.put("default_header_style", style);

		// 현재 사용하고 있는 스타일
		style = createBorderedStyle(wb);
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(font2);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setBorderTop(CellStyle.BORDER_THIN);
		styles.put("default_content_style", style);

		return styles;
	}

	// 셀의 Border스타일을 정의한다.
	private static CellStyle createBorderedStyle(Workbook wb) {
		CellStyle style = wb.createCellStyle();
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		return style;
	}
}

package kr.plani.ccis.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class ExcelRead {
	private static final Logger logger = LoggerFactory.getLogger(ExcelDownload.class);
	
	public static List<List<String>> readExcel(String fileName) throws Exception {
		List<List<String>> row = new ArrayList<List<String>>();

		// Excel 97~2003(.xls)과 Excel 2007(.xlsx)은 각각 처리
		if (fileName.indexOf(".xlsx") > -1)
			row = readExcel2007(fileName);
		else if (fileName.indexOf(".xls") > -1)
			row = readExcel2003(fileName);

		return row;
	}

	// Excel 2007(.xlsx)
	public static List<List<String>> readExcel2007(String fileName) throws IOException {
		// check file
		File file = new File(fileName);
		if (!file.exists() || !file.isFile() || !file.canRead()) {
			throw new IOException(fileName);
		}

		List<List<String>> rowExcel = new ArrayList<List<String>>();

		XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));
		try {
			//for (int i = 0; i < wb.getNumberOfSheets(); i++) {
			DecimalFormat df = new DecimalFormat();
			int i = 0;
				for (Row row : wb.getSheetAt(i)) {
					List<String> rowValue = new ArrayList<String>();
					for (Cell cell : row) {
						String cellValue = "";
						switch (cell.getCellType()) {
						case XSSFCell.CELL_TYPE_STRING:
							cellValue = cell.getRichStringCellValue().getString();
							break;
						case XSSFCell.CELL_TYPE_NUMERIC:
							if (HSSFDateUtil.isCellDateFormatted(cell)) {
								//java.util.Date dateValue = cell.getDateCellValue();
								//Integer year = dateValue.getYear(); // or
																	// getYear
																	// if (year
																	// != -1)
								// dateFormat.format(dateValue);
								// else
								// timeFormat.format(dateValue);
							} else {
								if(Double.valueOf(cell.getNumericCellValue()) == Double.valueOf(cell.getNumericCellValue()).intValue())
									cellValue = Double.valueOf(cell.getNumericCellValue()).intValue() + "";
								else
									cellValue = Double.valueOf(cell.getNumericCellValue()).toString();
							}
							break;
						case XSSFCell.CELL_TYPE_FORMULA:
							switch (cell.getCellType()) {
								case XSSFCell.CELL_TYPE_NUMERIC:
									double fddata = cell.getNumericCellValue();         
									cellValue = df.format(fddata);
									break;
								case XSSFCell.CELL_TYPE_STRING:
									cellValue = cell.getStringCellValue();
									break;
								case XSSFCell.CELL_TYPE_BOOLEAN:
									boolean fbdata = cell.getBooleanCellValue();         
									cellValue = String.valueOf(fbdata); 
									break;
								default:
									break;
							}

							//cellValue = cell.getCellFormula();
						case XSSFCell.CELL_TYPE_BOOLEAN:
							cellValue = cell.getBooleanCellValue() + "";
							break;
						case XSSFCell.CELL_TYPE_ERROR:
							cellValue = cell.getErrorCellValue() + "";
							break;
						case XSSFCell.CELL_TYPE_BLANK:
							cellValue = "";
							break;
						default:
							break;
						}

						rowValue.add(cellValue);
					}

					rowExcel.add(rowValue);
				}
			//}
		} catch (Exception ex) {
			logger.info("오류발생");
		}

		return rowExcel;
	}
	

	// Excel 97~2003(.xls)
	public static List<List<String>> readExcel2003(String fileName) throws IOException {
		// check file
		File file = new File(fileName);
		if (!file.exists() || !file.isFile() || !file.canRead()) {
			throw new IOException(fileName);
		}

		List<List<String>> rowExcel = new ArrayList<List<String>>();

		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(file));
		try {
			DecimalFormat df = new DecimalFormat();
			//for (int i = 0; i < wb.getNumberOfSheets(); i++) {
			int i = 0;
				for (Row row : wb.getSheetAt(i)) {
					List<String> rowValue = new ArrayList<String>();
					for (Cell cell : row) {
						String cellValue = "";

						switch (cell.getCellType()) {
						case HSSFCell.CELL_TYPE_STRING:
							cellValue = cell.getRichStringCellValue().getString();
							break;
						case HSSFCell.CELL_TYPE_NUMERIC:
							if (HSSFDateUtil.isCellDateFormatted(cell)) {
								//java.util.Date dateValue = cell.getDateCellValue();
								//Integer year = dateValue.getYear(); // or
																	// getYear
																	// if (year
																	// != -1)
								// dateFormat.format(dateValue);
								// else
								// timeFormat.format(dateValue);
							} else {
								if(Double.valueOf(cell.getNumericCellValue()) == Double.valueOf(cell.getNumericCellValue()).intValue())
									cellValue = Double.valueOf(cell.getNumericCellValue()).intValue() + "";
								else
									cellValue = Double.valueOf(cell.getNumericCellValue()).toString();
							}
							break;
						case HSSFCell.CELL_TYPE_FORMULA:
							switch (cell.getCellType()) {
								case XSSFCell.CELL_TYPE_NUMERIC:
									double fddata = cell.getNumericCellValue();         
									cellValue = df.format(fddata);
									break;
								case XSSFCell.CELL_TYPE_STRING:
									cellValue = cell.getStringCellValue();
									break;
								case XSSFCell.CELL_TYPE_BOOLEAN:
									boolean fbdata = cell.getBooleanCellValue();         
									cellValue = String.valueOf(fbdata); 
									break;
								default:
									break;
							}
						case HSSFCell.CELL_TYPE_BOOLEAN:
							// cellValue = cell.getBooleanCellValue();
							cellValue = cell.getBooleanCellValue() + "";
							break;
						case HSSFCell.CELL_TYPE_ERROR:
							// cellValue = cell.getErrorCellValue();
							cellValue = cell.getErrorCellValue() + "";
							break;
						case HSSFCell.CELL_TYPE_BLANK:
							cellValue = "";
							break;
						default:
							break;
						}

						rowValue.add(cellValue);
					}
					
					rowExcel.add(rowValue);
				}
			//}
		} catch (Exception ex) {
			logger.info("오류발생");
		}

		return rowExcel;
	}

	/**
	 *  값이 없는 빈 cell도 공백("")으로 채워서 리턴하는 메소드
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	public static List<List<String>> readExcel2(String fileName) throws Exception{
		List<List<String>> row = new ArrayList<List<String>>();

		// Excel 97~2003(.xls)과 Excel 2007(.xlsx)은 각각 처리
		if (fileName.indexOf(".xlsx") > -1)
			row = readExcelXlsx(fileName);
		else if (fileName.indexOf(".xls") > -1)
			row = readExcelXls(fileName);

		return row;
	}

	// read XLSX
	private static List<List<String>> readExcelXlsx(String fileName) throws IOException{
		
		File file = new File(fileName);
		if (!file.exists() || !file.isFile() || !file.canRead()) {
			throw new IOException(fileName);
		}

		List<List<String>> rowExcel = new ArrayList<List<String>>();
		XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));
		
		try {
			for(int i=0; i<wb.getNumberOfSheets(); i++){
				Sheet sheet = wb.getSheetAt(i);
				
				int firstRowNum = sheet.getFirstRowNum();
				int lastRowNum = sheet.getLastRowNum();
				int lastCellNum = sheet.getRow(0).getLastCellNum();
				
				for (int j = firstRowNum; j <= lastRowNum; j++) {
					
					List<String> rowValue = new ArrayList<String>();
					Row row = sheet.getRow(j);
					
					if(row==null){
						
					}else{
						for (int k = 0; k < lastCellNum; k++) {
							Cell cell = row.getCell(k);
							
							if(cell == null){
								rowValue.add(""); 
							}else{
								rowValue.add(cell.getRichStringCellValue()+""); 
							}
						}
					}
					rowExcel.add(rowValue);
				}
			}
		} catch (Exception ex) {
			logger.info("오류발생");
		}
		
		return rowExcel;
	}

	// read XLS
	private static List<List<String>> readExcelXls(String fileName) throws IOException{
		
		File file = new File(fileName);
		if (!file.exists() || !file.isFile() || !file.canRead()) {
			throw new IOException(fileName);
		}

		List<List<String>> rowExcel = new ArrayList<List<String>>();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(file));
		
		try {
			for(int i=0; i<wb.getNumberOfSheets(); i++){
				Sheet sheet = wb.getSheetAt(i);
				
				int firstRowNum = sheet.getFirstRowNum();
				int lastRowNum = sheet.getLastRowNum();
				int lastCellNum = sheet.getRow(0).getLastCellNum();
				
				for (int j = firstRowNum; j < lastRowNum; j++) {
					
					List<String> rowValue = new ArrayList<String>();
					Row row = sheet.getRow(j);
					if(row==null){
						
					}else{
						for (int k = 0; k < lastCellNum; k++) {
							Cell cell = row.getCell(k);
							if(cell == null){
								rowValue.add(""); 
							}else{
								rowValue.add(cell.getRichStringCellValue()+""); 
							}
						}
					}
					rowExcel.add(rowValue);
				}
			}
		} catch (Exception ex) {
			logger.info("오류발생");
		}
		
		return rowExcel;
	}

}


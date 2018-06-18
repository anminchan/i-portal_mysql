package kr.plani.ccis.ips.mapper.stat;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("fileDownloadStatMapper")
public interface FileDownloadStatMapper {

	public List<?> list(Object obj);
	
}

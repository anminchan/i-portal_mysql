package kr.plani.ccis.ips.mapper.site;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("attachFileMgrMapper")
public interface AttachFileMgrMapper {

	public List<?> selectAttachFileList(Object obj);
	public Object selectAttachFileView(Object obj);

	public int insertAttachFile(Object obj);
	public int updateAttachFile(Object obj);
	public int deleteAttachFile(Object obj);

	public List<?> selectAttachFiles(Object obj);
	
	public int insertAttachFiles(Object obj);
	public int deleteAttachFiles(Object obj);
	
}




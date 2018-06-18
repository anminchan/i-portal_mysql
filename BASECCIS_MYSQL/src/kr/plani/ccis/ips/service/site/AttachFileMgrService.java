package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.mapper.site.AttachFileMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("attachFileMgrService")
public class AttachFileMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private AttachFileMgrMapper attachFileMgrMapper;

	
	@Override
	public List<?> getObjectList(Object obj) throws Exception {
		return attachFileMgrMapper.selectAttachFileList(obj);
	}

	public List<?> selectAttachFiles(Object obj) throws Exception {
		return attachFileMgrMapper.selectAttachFiles(obj);
	}
	
	@Override
	public Object getObject(Object obj) throws Exception {
		return attachFileMgrMapper.selectAttachFileView(obj);
	}

	public int insertAttachFile(Object obj) throws Exception {
		return attachFileMgrMapper.insertAttachFile(obj);
	}

	public int updateAttachFile(Object obj) throws Exception {
		return attachFileMgrMapper.updateAttachFile(obj);
	}

	public int deleteAttachFile(Object obj) throws Exception {
		return attachFileMgrMapper.deleteAttachFile(obj);
	}

	public int insertAttachFiles(Object obj) throws Exception {
		return attachFileMgrMapper.insertAttachFiles(obj);
	}
	
	public int deleteAttachFiles(Object obj) throws Exception {
		return attachFileMgrMapper.deleteAttachFiles(obj);
	}
	
	@Override
	public Object insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}

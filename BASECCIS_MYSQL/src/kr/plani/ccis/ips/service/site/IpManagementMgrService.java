package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.IpManagement;
import kr.plani.ccis.ips.mapper.site.IpManagementMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("ipManagementMgrService")
public class IpManagementMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private IpManagementMgrMapper ipManagementMgrMapper;
	
	public List<?> selectIpManagementList(Object obj) throws Exception {
		return ipManagementMgrMapper.selectIpManagementList(obj);
	}
		
	public List<?> selectIpManagementView(Object obj) throws Exception {
		return ipManagementMgrMapper.selectIpManagementView(obj);
	}
	
	public String selectIpAllYnCheck(Object obj) throws Exception {
		return ipManagementMgrMapper.selectIpAllYnCheck(obj);
	}
	
	public void insertIpManagement(Object obj) throws Exception {
		IpManagement inObj = (IpManagement) obj;
		if(inObj.getSeq() <= 0){
			ipManagementMgrMapper.insertIpManagement(inObj);
		}else{
			ipManagementMgrMapper.updateIpManagement(inObj);
		}
	}
	
	@Override
	public Object updateObject(Object obj) throws Exception {
		return null;
	}

	@Override
	public Object deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getObjectList(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object insertObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}

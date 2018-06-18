package kr.plani.ccis.ips.service.site;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.Trans;
import kr.plani.ccis.ips.mapper.site.ContentTransMgrMapper;

@Service("contentTransMgrService")
public class ContentTransMgrService extends EgovAbstractServiceImpl {

	private static final Logger logger = LoggerFactory.getLogger(ContentTransMgrService.class);
	
	@Resource
	private ContentTransMgrMapper contentTransMgrMapper;

	public List<?> selectTransMenu(Object obj) throws Exception {
		return contentTransMgrMapper.selectTransMenu(obj);
	}
	public List<?> selectTransTargetMenu(Object obj) throws Exception {
		return contentTransMgrMapper.selectTransTargetMenu(obj);
	}
	
	@Transactional
	public void actTransMenu(Object obj) throws Exception {
		Trans trans = (Trans) obj;
		
		String transGubun = trans.getTransGubun();
		
		String[] menu_target_id = trans.getTRANSID_ARR();
		String menu_id = trans.getTransMenuId();
		
		logger.info("getTransMenuId >> " + menu_id);
		
		if(transGubun.equals("trans")){
			contentTransMgrMapper.deleteTransMenuId(trans);
		
			String transId = "";

			if(menu_target_id != null && menu_target_id.length > 0){
				for(int i=0; i<menu_target_id.length; i++){
					logger.info("getTRANSID_ARR >> " + menu_target_id[i]);
					transId = contentTransMgrMapper.selectNextTransId(trans);
					
					trans.setTransId(transId);
					trans.setTransTargetMenuId(menu_target_id[i]);
					
					contentTransMgrMapper.insertTransMenu(trans);
				}
			}
		}else{
			contentTransMgrMapper.deleteTransTargetMenuId(trans);
		
			String transId = "";
			
			if(menu_target_id != null && menu_target_id.length > 0){
				for(int i=0; i<menu_target_id.length; i++){
					logger.info("getTRANSID_ARR >> " + menu_target_id[i]);
					transId = contentTransMgrMapper.selectNextTransId(trans);
					
					trans.setTransId(transId);
					trans.setTransMenuId(menu_target_id[i]);
					
					contentTransMgrMapper.insertTransMenu(trans);
				}
			}
		}
	}

	@Transactional
	public void deleteTransMenu(Object obj) throws Exception {
		Trans trans = (Trans) obj;
		
		String transGubun = trans.getTransGubun();
		
		String[] menu_trans_id = null;
		String[] menu_target_id = null;
		String menu_id = trans.getTransMenuId();
		
		HashMap<String, String> hm = new HashMap<String, String>();
		
		if(transGubun.equals("trans")){
			menu_trans_id = trans.getTRANSID_ARR();
			
			logger.info("getTransMenuId >> " + menu_id);
			if(menu_trans_id != null && menu_trans_id.length > 0){
				for(int i=0; i<menu_trans_id.length; i++){
					hm = new HashMap<String, String>();
					logger.info("getTRANSID_ARR >> " + menu_trans_id[i]);
					hm.put("TRANSID", menu_trans_id[i]);
					contentTransMgrMapper.deleteTransMenu(hm);
				}
			}
		}else{
			menu_target_id = trans.getTRANSID_TARGET_ARR();
			logger.info("getTransMenuId >> " + menu_id);
			
			if(menu_target_id != null && menu_target_id.length > 0){
				for(int i=0; i<menu_target_id.length; i++){
					hm = new HashMap<String, String>();
					logger.info("getTRANSID_TARGET_ARR >> " + menu_target_id[i]);
					hm.put("TRANSID", menu_target_id[i]);
					contentTransMgrMapper.deleteTransMenu(hm);
				}
			}
		}
		
		//contentTransMgrMapper.deleteTransMenu(obj);
	}
	
	public void insertTransMenu(Object obj) throws Exception {
		contentTransMgrMapper.insertTransMenu(obj);
	}
}

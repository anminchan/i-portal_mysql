package kr.plani.ccis.ips.service.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.plani.ccis.ips.domain.site.TabooWord;
import kr.plani.ccis.ips.mapper.site.TabooWordMgrMapper;
import kr.plani.ccis.ips.service.DefaultService;

@Service("tabooWordMgrService")
public class TabooWordMgrService extends EgovAbstractServiceImpl implements DefaultService {
	
	@Resource
	private TabooWordMgrMapper tabooWordMgrMapper;
	
	public List<?> selectTabooWordList(Object obj) throws Exception
	{
		TabooWord inObj = (TabooWord)obj;
		return tabooWordMgrMapper.selectTabooWordList(inObj);
	}	

	public int insertTabooWord(Object obj) throws Exception {
		TabooWord inObj = (TabooWord)obj;
		return tabooWordMgrMapper.insertTabooWord(inObj);
	}
	
	public int updateTabooWord(Object obj) throws Exception {
		TabooWord inObj = (TabooWord)obj;
		return tabooWordMgrMapper.updateTabooWord(inObj);
	}
	
	public int deleteTabooWord(Object obj) throws Exception {
		TabooWord inObj = (TabooWord)obj;
		return tabooWordMgrMapper.deleteTabooWord(inObj);
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

	@Override
	public Object deleteObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object updateObject(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}

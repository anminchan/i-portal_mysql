package kr.plani.ccis.ips.service;


public interface DefaultService {
	public Object getObjectList(Object obj) throws Exception;
	public Object getObject(Object obj) throws Exception;
	public Object insertObject(Object obj) throws Exception;
	
	public Object updateObject(Object obj) throws Exception;
	public Object deleteObject(Object obj) throws Exception;
}

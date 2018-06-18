package kr.plani.ccis.common.util;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

@Repository 
public class JsonUtil {

	public String listmap_to_json_string(List<Map<String, Object>> list)
	{   
		
		if(list == null) return "";
		
	    JSONArray json_arr=new JSONArray();
	    for (Map<String, Object> map : list) {
	        JSONObject json_obj=new JSONObject();
	        for (Map.Entry<String, Object> entry : map.entrySet()) {
	            String key = entry.getKey();
	            Object value = entry.getValue();
	            try {
	                json_obj.put(key.toLowerCase(),value+"");
	            } catch (Exception e) {
	                // TODO Auto-generated catch block
	                //e.printStackTrace();
	            	System.out.println("처리 중 오류가 발생했습니다.");
	            }                           
	        }
	        json_arr.add(json_obj);
	    }
	    return json_arr.toString();
	}
	
	public String map_to_json_string(Map<String, Object> map)
	{        
		if(map == null) return "";
	        JSONObject json_obj=new JSONObject();
	        for (Map.Entry<String, Object> entry : map.entrySet()) {
	            String key = entry.getKey();
	            Object value = entry.getValue();
	            try {
	                json_obj.put(key,value+"");
	            } catch (Exception e) {
	                // TODO Auto-generated catch block
	                //e.printStackTrace();
	            	System.out.println("처리 중 오류가 발생했습니다.");
	            }                           
	        }
	    return json_obj.toString();
	}
		
}

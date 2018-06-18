package kr.plani.ccis.common.util;

public class Cryptograph {
	public Cryptograph() {}

	public static String Base64Encode(String str)
	{
		String ret_str="";
		
		if(!(str == null || "".equals(str))){
			int i; boolean hiteof = false;
			int iidx;
			int str_len = str.length();
			byte in[] = new byte[str_len];
			byte dtable[] = new byte[256];
			in = str.getBytes();
	
			for (i = 0; i < 26; i++){
				dtable[i] = (byte)('A' + i);
				dtable[26+i] = (byte)('a' + i);
			}
			for (i = 0; i < 10; i++)
				dtable[52 + i] = (byte)('0' + i);
	
			dtable[62] = (byte)'+';
			dtable[63] = (byte)'/';
			iidx = 0;
			while (!hiteof) {
				byte igroup[] = new byte[3];
				byte ogroup[] = new byte[4];
				byte c;
				int  n;
				igroup[0] = igroup[1] = igroup[2] = (byte)0x00;
				for (n = 0; n < 3; n++) {
					if (iidx<str_len)
						c = in[iidx++];
					else {
						c = 0;
						hiteof = true;
						break;
					};
					igroup[n] = (byte)(c&0xff);
				}
				if (n > 0) {
					ogroup[0] = dtable[(((igroup[0]&0xff) >> 2)&0x3f)];
					ogroup[1] = dtable[(((((igroup[0] & 0x3) << 4)&0x3f) | (((igroup[1]&0xff) >> 4)&0x3f))&0x3f)];
					ogroup[2] = dtable[(((((igroup[1] & 0xF) << 2)&0x3f) | (((igroup[2]&0xff) >> 6)&0x3f))&0x3f)];
					ogroup[3] = dtable[(igroup[2] & 0x3F)];
					if (n < 3) {
						ogroup[3] = (byte)'=';
						if (n < 2)
							ogroup[2] = (byte)'=';
					}
					ret_str += new String(ogroup);
				}
			}
		}
		return ret_str;
	}

    public static String Base64Decode(String str)
    {
    	String ret_str="";
    	
    	if(!(str == null || "".equals(str))){
	        int i;
	        int iidx;
	        int str_len = str.length();
	        byte in[] = new byte[str_len];
	        byte dtable[] = new byte[256];
	        in = str.getBytes();
	        for (i = 0; i < 255; i++) { dtable[i] = (byte)0x80; };
	        for (i = 'A'; i <= 'Z'; i++) { dtable[i] = (byte)(0 + (i - 'A')); };
	        for (i = 'a'; i <= 'z'; i++) { dtable[i] = (byte)(26 + (i - 'a')); };
	        for (i = '0'; i <= '9'; i++) { dtable[i] = (byte)(52 + (i - '0')); };
	        dtable['+'] = (byte)62;
	        dtable['/'] = (byte)63;
	        dtable['='] = (byte)0;
	        iidx = 0;
	        while (true) {
	            byte a[] = new byte[4];
	            byte b[] = new byte[4];
	            byte o[] = new byte[3];
	            for (i = 0; i < 4; i++) {
	                byte c = in[iidx++];
	                if ((dtable[c] & (byte)0x80)!=0) {
	                    i--;
	                    continue;
	                }
	                a[i] = c;
	                b[i] = dtable[c];
	                if(iidx >= str_len){
	                    break;
	                }
	            }
	            o[0] = (byte)(b[0] << 2);
	            o[0] |= (byte)(b[1] >> 4);
	            o[1] = (byte)(b[1] << 4);
	            o[1] |= (byte)(b[2] >> 2);
	            o[2] = (byte)(b[2] << 6);
	            o[2] |= b[3];
	            i = a[2] == '=' ? 1 : (a[3] == '=' ? 2 : 3);
	            ret_str += new String(o);
	            if ((i < 3) || (iidx >= str_len)) return ret_str;
	        }
    	}
    	return ret_str;
    }

}

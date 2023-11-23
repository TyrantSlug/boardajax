package com.lime.user.service;

import com.lime.user.vo.UserVO;

public interface UserService {
	
	Integer idCheck(String userId) throws Exception;

	boolean createUser(UserVO userVO) throws Exception;
	
//	String joinEmail(String email);
}

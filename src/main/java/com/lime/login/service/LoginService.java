package com.lime.login.service;

import java.util.Map;

import com.lime.user.vo.UserVO;

public interface LoginService {

//	UserVO loginUser(Map<String, Object> inOutMap) throws Exception;
	boolean login(Map<String, Object> user) throws Exception;

}

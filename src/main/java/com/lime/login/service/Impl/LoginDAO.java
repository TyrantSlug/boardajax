package com.lime.login.service.Impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.lime.user.vo.UserVO;


import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("loginDAO")
public class LoginDAO extends EgovAbstractMapper {

//	public UserVO loginUser(Map<String, Object> inOutMap) throws Exception{
//		// TODO Auto-generated method stub
//		return selectOne("Login.login", inOutMap);
//	}

	public int login(Map<String, Object> user) throws Exception{
		return selectOne("Login.login", user);
		
	};
	
}

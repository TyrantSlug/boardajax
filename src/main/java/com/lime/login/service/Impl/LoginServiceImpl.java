package com.lime.login.service.Impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lime.login.service.LoginService;

@Service("LoginService")
public class LoginServiceImpl implements LoginService{
	
	@Resource(name="loginDAO")
	private LoginDAO loginDAO;

//	@Override
//	public UserVO loginUser(Map<String, Object> inOutMap) throws Exception {
//		// TODO Auto-generated method stub
//		return loginDAO.loginUser(inOutMap);
//	}
	
	@Override
    public boolean login(Map<String, Object> user) throws Exception {
        return loginDAO.login(user) > 0;
    }

}

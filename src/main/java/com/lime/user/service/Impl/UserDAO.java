package com.lime.user.service.Impl;


import org.springframework.stereotype.Repository;

import com.lime.user.vo.UserVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("userDAO")
public class UserDAO extends EgovAbstractMapper {

	public Integer idCheck(String userId) throws Exception {
        return selectOne("UserMapper.idCheck", userId);
    }
	
    public int createUser(UserVO userVO) throws Exception {
        return insert("UserMapper.createUser", userVO);
    }
    
}

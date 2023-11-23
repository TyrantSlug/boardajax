package com.lime.account.service;

import java.util.List;
import java.util.Map;

import com.lime.account.vo.AccountVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public interface AccountService {

	int insertAccount(AccountVO accountVO) throws Exception;

	AccountVO getAccountById(int id) throws Exception;

	void updateAccount(AccountVO accountVO) throws Exception;

	int getTotalCount() throws Exception;
	List<AccountVO> findAll(Map<String, Object> map) throws Exception;
	List<AccountVO> findAllList() throws Exception;
	


}

package com.lime.account.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.lime.account.vo.AccountVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("accountDAO")
public class AccountDAO extends EgovAbstractMapper {

	public void insertAccount(AccountVO accountVO) {
		insert("AccountMapper.insertAccount", accountVO);
	}

	public List<AccountVO> findAllList() throws Exception {
		return selectList("AccountMapper.findAllList");
	}

	public int getTotalCount() throws Exception {
		return selectOne("AccountMapper.getTotalCount");
	}

	public List<AccountVO> findAll(Map<String, Object> map) throws Exception {
		return selectList("AccountMapper.findAll", map);
	}

	public AccountVO getAccountById(int id) {
		// TODO Auto-generated method stub
		return selectOne("AccountMapper.getAccountById", id);
	}

	public void updateAccount(AccountVO accountVO) {
		// TODO Auto-generated method stub
		update("AccountMapper.updateAccount", accountVO);
	}

}

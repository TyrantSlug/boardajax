package com.lime.account.service.Impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.lime.account.service.AccountService;
import com.lime.account.vo.AccountVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Resource(name="accountDAO")
	private AccountDAO accountDAO;

	@Override
	public List<AccountVO> findAllList() throws Exception {
		// TODO Auto-generated method stub
		return accountDAO.findAllList();
	}
	
	
    @Override
    public int getTotalCount() throws Exception {
        return accountDAO.getTotalCount();
    }
    
	@Override
	public List<AccountVO> findAll(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return accountDAO.findAll(map);
	}


/*    @Override
    public List<AccountVO> findAllList(PaginationInfo paginationInfo) throws Exception {
        return accountDAO.findAllList(paginationInfo);
    }*/
    
    
    

	@Override
	public int insertAccount(AccountVO accountVO) throws Exception {
	    accountDAO.insertAccount(accountVO);
	    return accountVO.getAccountSeq();
	}

	@Override
	public AccountVO getAccountById(int id) throws Exception {
		// TODO Auto-generated method stub
		return accountDAO.getAccountById(id);
	}

	@Override
	public void updateAccount(AccountVO accountVO) throws Exception {
		accountDAO.updateAccount(accountVO);
		return;
		
	}

	
}

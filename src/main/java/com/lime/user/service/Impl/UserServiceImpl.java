package com.lime.user.service.Impl;


import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lime.user.service.UserService;
import com.lime.user.vo.UserVO;

@Service("UserService")
public class UserServiceImpl implements UserService {

	@Resource(name="userDAO")
	private UserDAO userDAO;


	
	@Override
	public Integer idCheck(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.idCheck(userId);
	}


	
	@Override
	public boolean createUser(UserVO userVO) throws Exception {
		return userDAO.createUser(userVO) > 0;
	}
	
	/*@Override
    public String joinEmail(String email) {
        makeRandomNumber();
        String setFrom = "anosihsh@gmail.com"; // 자신의 이메일 주소를 입력 
        String toMail = email;
        String title = "회원 가입 인증 이메일 입니다."; 
        String content = "인증 번호는 " + authNumber + "입니다.";    
        mailSend(setFrom, toMail, title, content);
        return Integer.toString(authNumber);
    }

    private void makeRandomNumber() {
        Random r = new Random();
        int checkNum = r.nextInt(888888) + 111111;
        System.out.println("인증번호 : " + checkNum);
        authNumber = checkNum;
    }

    private void mailSend(String setFrom, String toMail, String title, String content) { 
        MimeMessage message = mailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }*/
}

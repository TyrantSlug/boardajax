package com.lime.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lime.mail.MailSendService;
import com.lime.user.service.UserService;
import com.lime.user.vo.UserVO;

import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MailSendService mailService;

	
	@RequestMapping(value = "/user/userInsert.do")
	public String userInsert() {
		return "/user/userInsert";
	}
	
    @RequestMapping(value = "/user/jusoPopup.do")
	public String jusoPopup() {
		return "/user/jusoPopup";
	}
    
    @RequestMapping(value = "/user/jusoPopup2.do")
	public String jusoPopup2() {
		return "/user/jusoPopup2";
	}
    
    @RequestMapping(value = "/social/naverlogin.do")
	public String naver() {
		return "/social/naverlogin";
	}

	@ResponseBody
	@RequestMapping(value = "/user/idCheck.do", method = RequestMethod.POST)
    public String idCheck(@RequestParam("userId") String userId) throws Exception {
        int cnt = 0;
        cnt = userService.idCheck(userId);
        if (cnt != 0) {
        	return "1";
        }else {
        	return "0";
        }
    }
	
	@ResponseBody
	@RequestMapping(value="/user/createUser.do", method = RequestMethod.POST)
	public ResponseEntity<?> createUser(@RequestBody UserVO userVO) throws Exception {
	    Map<String, Object> map = new HashMap<>();
	    
	    String userId = userVO.getUserId();
	    String pwd = userVO.getPwd();

	    if (userId == null || userId.length() < 6) {
	    	map.put("result", "fail");
	    	map.put("message", "아이디는 6글자 이상이어야 합니다.");
	        System.out.println(map);
	        return ResponseEntity.ok(map);
	    }

	    String passwordPattern = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{6,12}$";
	    if (pwd == null || !pwd.matches(passwordPattern)) {
	    	map.put("result", "fail");
	    	map.put("message", "비밀번호는 6~12글자 사이이며, 영문, 숫자, 특수문자를 포함해야 합니다.");
	        System.out.println(map);
	        return ResponseEntity.ok(map);
	    }

	    if (userService.idCheck(userVO.getUserId()) == 0) {
	    	System.out.println(userVO);
	        if(userService.createUser(userVO)) {
	        	map.put("result", "success");
	        } else {
	        	map.put("result", "fail");
	        	map.put("message", "유저 생성 실패");
	            System.out.println(map);
	        }
	    } else {
	    	map.put("result", "fail");
	    	map.put("message", "아이디가 이미 존재합니다.");
	        System.out.println(map);
	    }
	    return ResponseEntity.ok(map);
	    
	}

	@ResponseBody
	@RequestMapping(value="/user/emailCheck.do", method = RequestMethod.GET)
	public String emailCheck(@RequestParam("email") String email) {
		System.out.println("이메일 인증 : " + email);
		return mailService.joinEmail(email);

	}
	
	@ResponseBody
	@RequestMapping(value="/user/message.do", method = RequestMethod.GET)
	public String message(@RequestParam("phone") String phone) throws CoolsmsException {
		System.out.println("휴대폰 인증 : " + phone);
		return mailService.message(phone);

	}
	
	
}

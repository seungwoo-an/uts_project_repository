package com.spring.project.login.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.spring.project.member.model.MemberVO;
import com.spring.project.member.service.IMemberService;

@Component
public class LoginAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	IMemberService memberService;

	@Autowired
	BCryptPasswordEncoder bpe;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String userId = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();
		String dbpw = memberService.getMemberPassword(userId);
		if (dbpw == null) {
			throw new InternalAuthenticationServiceException("없는 아이디입니다.");
		}
		if (!bpe.matches(password, dbpw)) {
			throw new BadCredentialsException("비밀번호가 다릅니다.");
		}
		MemberVO member = memberService.getMemberInfo(userId);
		if (!member.isEnabled()) {
			throw new DisabledException("허가되지 않은 사용자입니다. 관리자에게 문의하세요");
		}
		UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(member, password, member.getAuthorities() );
		return result;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}

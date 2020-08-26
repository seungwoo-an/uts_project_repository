package com.spring.project.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.project.login.service.ILoginService;
import com.spring.project.product.service.ProductService;

@Controller
public class LoginController {
	@Autowired
	ILoginService loginService;
	@Autowired
	ProductService productService;

	@RequestMapping("/")
	public String home(Authentication auth, Model model) {
		model.addAttribute("newestProductList", productService.getNewestProducts());
		model.addAttribute("popularProductList", productService.getPopularProductList());
		return "home";
	}
	@PreAuthorize("isAnonymous()")
	@RequestMapping("/login")
	public void login() {
	}

}

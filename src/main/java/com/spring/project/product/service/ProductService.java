package com.spring.project.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.product.model.ProductsVO;
import com.spring.project.product.repository.IProductRepository;

@Service
public class ProductService {
	
	@Autowired
	IProductRepository productRepository;
	
	public List<ProductsVO> getProductList(){
		return productRepository.getProductList();
	}
	
	public List<ProductsVO> getSellerProductList(String member_id){
		return productRepository.getSellerProductList(member_id);
	}
	
	public ProductsVO getProduct(int product_id) {
		return productRepository.getProduct(product_id);
	}
	@Transactional(value = "tsManager")
	public void minusProductCount(int minusCount, int product_id) {
		productRepository.minusProductCount(minusCount, product_id);
	}
	@Transactional(value = "tsManager")
	public void plusProductCount(int plusCount, int product_id) {
		productRepository.plusProductCount(plusCount, product_id);
	}
	@Transactional(value = "tsManager")
	public void insertProduct(ProductsVO product) {
			product.setProduct_id(productRepository.getMaxProductId()+1);
			productRepository.insertProduct(product);
	}
	@Transactional(value = "tsManager")
	public void afterPayment(int[] product_ids,int[] order_product_counts) {
		for(int i =0; i<product_ids.length; i++) {
			productRepository.afterPayment(product_ids[i], order_product_counts[i]);
		}
	}
	@Transactional(value = "tsManager")
	public void updateProduct(ProductsVO productVo) {
		productRepository.updateProduct(productVo);
		
	}
	@Transactional(value = "tsManager")
	public void updateProductWithImage(ProductsVO productVo) {
		productRepository.updateProductWithImage(productVo);
	}
	
	@Transactional(value = "tsManager")
	public void deleteSellerProduct(int[] product_ids) {
		for (int i = 0; i < product_ids.length; i++) {
			productRepository.deleteSellerProduct(product_ids[i]);
		}
	}
	public int getTotalCount(String member_id) {
		return productRepository.getTotalCount(member_id);
	}
	public List<ProductsVO> getNewestProducts() {
		return productRepository.getNewestProducts();
	}
	public  List<ProductsVO> getPopularProductList() {
		return productRepository.getPopularProductList();
	}

	public String getSellerCompanyName(int product_id) {
		return productRepository.getSellerCompanyName(product_id);
	}
	public  List<ProductsVO> getProductListBySearch(String search) {
		return productRepository.getProductListBySearch(search);
	}
}

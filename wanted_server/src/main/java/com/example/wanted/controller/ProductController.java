package com.example.wanted.controller;

import com.example.wanted.model.Images;
import com.example.wanted.model.Labels;
import com.example.wanted.model.Product;
import com.example.wanted.model.ProductSend;
import com.example.wanted.service.ProductService;
import org.apache.catalina.LifecycleState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

@RestController
public class ProductController {
    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @RequestMapping(value = "/productList",method = RequestMethod.GET, consumes = "application/json", produces = "application/json;charset=UTF-8")
    public List<ProductSend> getProductList(){
        //System.out.println(productService.getProductList());

        return productService.getProductList();
    }




    @RequestMapping(value = "/postProduct", method = RequestMethod.POST)
    public String getProduct(@RequestParam("images") MultipartFile[] images,
                             @RequestParam("description")String description,
                             @RequestParam("name")String name,
                             @RequestParam("location")String location,
                             @RequestParam("price")String price,
                             @RequestParam("labels")List<String> labels,
                             @RequestParam("userId")int userId) {
        Labels labelModel = productService.saveLabel(labels);
        Images imagesModel = new Images();
        try {
            imagesModel = productService.saveImage(images);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Long res = productService.saveProduct(description,name,location,price,labelModel,imagesModel,userId);
        if(res>0){
            return "成功";
        }else return "失败";
    }

}

package com.example.wanted.controller;

import com.example.wanted.model.*;
import com.example.wanted.service.RewardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.util.List;

@RestController
public class RewardController {
    private final RewardService rewardService;

    @Autowired
    public RewardController(RewardService rewardService) {
        this.rewardService = rewardService;
    }

   // @RequestMapping(value = "/rewardList",method = RequestMethod.GET)
  //  public List<Reward> getRewardList(){
   //     return rewardService.getRewardList();
   // }

    @RequestMapping(value = "/rewardList",method = RequestMethod.GET, consumes = "application/json", produces = "application/json;charset=UTF-8")
    public List<RewardSend> getRewardList(){
        //System.out.println(productService.getProductList());

        return rewardService.getRewardList();
    }

    @RequestMapping(value = "/postReward", method = RequestMethod.POST)
    public String getProduct(@RequestParam("images") MultipartFile[] images,
                             @RequestParam("description")String description,
                             @RequestParam("name")String name,
                             @RequestParam("location")String location,
                             @RequestParam("price")String price,
                             @RequestParam("labels")List<String> labels,
                             @RequestParam("userId")int userId) {
        Labels labelModel = rewardService.saveLabel(labels);
        Images imagesModel = new Images();
        try {
            imagesModel = rewardService.saveImage(images);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Long res = rewardService.saveReward(description,name,location,price,labelModel,imagesModel,userId);
        if(res>0){
            return "成功";
        }else return "失败";
    }
}

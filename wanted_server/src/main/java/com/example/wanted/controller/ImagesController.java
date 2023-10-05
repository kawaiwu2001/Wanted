package com.example.wanted.controller;

import com.example.wanted.model.Images;
import com.example.wanted.service.ImagesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class ImagesController {
    final private ImagesService imagesService;

    @Autowired
    public ImagesController(ImagesService imagesService) {
        this.imagesService = imagesService;
    }

    @RequestMapping(value = "/oneImage",method = RequestMethod.POST)
    public String getImage(@RequestParam("imagesId") String imagesId){
        return imagesService.getImage(Long.parseLong(imagesId));
    }
    @RequestMapping(value = "/images",method = RequestMethod.POST)
    public Images getImages(@RequestParam("imagesId")Long imagesId){
        return imagesService.getImages(imagesId);

    }
}

package com.example.wanted.service;
import com.example.wanted.model.Images;
import com.example.wanted.repository.ImagesRepository;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class ImagesService {
    private final ImagesRepository imagesRepository;

    public ImagesService(@Qualifier("images")ImagesRepository imagesRepository) {
        this.imagesRepository = imagesRepository;
    }


    public String getImage(Long imagesId) {
        Images images = imagesRepository.findById(imagesId).get();
        System.out.println(images.getImage1());
        return images.getImage1();
    }

    public Images getImages(Long imagesId) {
        return imagesRepository.findById(imagesId).get();
    }
}

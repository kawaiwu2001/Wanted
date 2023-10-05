package com.example.wanted.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.SerializationFeature;

import javax.persistence.*;

//@JsonIgnoreProperties(value = {"handler","hibernateLazyInitializer","fieldHandler"})

public class ProductSend {
    private Long Id;
    private Long imagesId;
    private Long labelsId;
    private int userId;
    private String name;
    private String description;
    private String location;
    private Float price;

    public ProductSend(){

    }

    public ProductSend(Long id, Long imagesId, Long labelsId, int userId, String name, String description, String location, Float price) {
        Id = id;
        this.imagesId = imagesId;
        this.labelsId = labelsId;
        this.userId = userId;
        this.name = name;
        this.description = description;
        this.location = location;
        this.price = price;
    }

    public Long getId() {
        return Id;
    }


    public int getUserId() {
        return userId;
    }

    public Long getImagesId() {
        return imagesId;
    }

    public void setImagesId(Long imagesId) {
        this.imagesId = imagesId;
    }

    public Long getLabelsId() {
        return labelsId;
    }

    public void setLabelsId(Long labelsId) {
        this.labelsId = labelsId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }
}

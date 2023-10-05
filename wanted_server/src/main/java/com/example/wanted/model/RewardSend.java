package com.example.wanted.model;

public class RewardSend {
    private Long Id;
    private Long imagesId;
    private Long labelsId;
    private int userId;
    private String name;
    private String description;
    private String location;
    private Float price;

    public RewardSend(Long id, Long imagesId, Long labelsId, int userId,String name, String description, String location, Float price) {
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

    public void setId(Long id) {
        Id = id;
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

    public int getUserId() {
        return userId;
    }

    @Override
    public String toString() {
        return "RewardSend{" +
                "Id=" + Id +
                ", imagesId=" + imagesId +
                ", labelsId=" + labelsId +
                ", userId=" + userId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", location='" + location + '\'' +
                ", price=" + price +
                '}';
    }
}

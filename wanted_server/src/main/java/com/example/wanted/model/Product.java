package com.example.wanted.model;

import com.fasterxml.jackson.annotation.JsonUnwrapped;
import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity(name = "product")
@Table
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonUnwrapped
    @OneToOne
    @JoinColumn(name = "imageId")
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    private Images images;

    @JsonUnwrapped
    @OneToOne
    @JoinColumn(name = "labelId")
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    private Labels labels;

    @JsonUnwrapped
    @ManyToOne
    @JoinColumn(name="userId")
    private User user;

    private String name;
    private String description;
    private String location;
    private Float price;

    public Product(String name, String description, String location, Float price) {
        this.name = name;
        this.description = description;
        this.location = location;
        this.price = price;
    }

    public Product() {

    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Long getProductId() {
        return id;
    }

    public Images getImages() {
        return images;
    }

    public void setImages(Images images) {
        this.images = images;
    }

    public Labels getLabels() {
        return labels;
    }

    public void setLabels(Labels labels) {
        this.labels = labels;
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

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", images=" + images +
                ", labels=" + labels +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", location='" + location + '\'' +
                ", price=" + price +
                '}';
    }
}

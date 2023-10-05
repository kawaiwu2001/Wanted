package com.example.wanted.model;

import com.fasterxml.jackson.annotation.JsonUnwrapped;
import org.hibernate.annotations.Cascade;

import javax.persistence.*;

@Entity(name = "reward")
@Table
public class Reward {
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
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    private User user;

    private String name;
    private String description;
    private String location;
    private Float price;


    public Reward(String name, String description, String location, Float price) {
        this.name = name;
        this.description = description;
        this.location = location;
        this.price = price;
    }

    public Reward() {

    }

    public Long getId() {
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

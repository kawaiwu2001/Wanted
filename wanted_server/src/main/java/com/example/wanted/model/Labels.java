package com.example.wanted.model;

import javax.persistence.*;

@Entity(name = "labels")
@Table
public class Labels {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String label1;
    private String label2;
    private String label3;
    private String label4;
    private String label5;
    private String label6;

    @OneToOne
    @JoinColumn(name = "productId")
    private Product product;

    public Labels(String label1, String label2, String label3, String label4, String label5, String label6) {
        this.label1 = label1;
        this.label2 = label2;
        this.label3 = label3;
        this.label4 = label4;
        this.label5 = label5;
        this.label6 = label6;
    }

    public Long getId() {
        return id;
    }

    public Labels() {

    }

    public String getLabel1() {
        return label1;
    }

    public void setLabel1(String label1) {
        this.label1 = label1;
    }

    public String getLabel2() {
        return label2;
    }

    public void setLabel2(String label2) {
        this.label2 = label2;
    }

    public String getLabel3() {
        return label3;
    }

    public void setLabel3(String label3) {
        this.label3 = label3;
    }

    public String getLabel4() {
        return label4;
    }

    public void setLabel4(String label4) {
        this.label4 = label4;
    }

    public String getLabel5() {
        return label5;
    }

    public void setLabel5(String label5) {
        this.label5 = label5;
    }

    public String getLabel6() {
        return label6;
    }

    public void setLabel6(String label6) {
        this.label6 = label6;
    }

    @Override
    public String toString() {
        return "Labels{" +
                "label1='" + label1 + '\'' +
                ", label2='" + label2 + '\'' +
                ", label3='" + label3 + '\'' +
                ", label4='" + label4 + '\'' +
                ", label5='" + label5 + '\'' +
                ", label6='" + label6 + '\'' +
                '}';
    }
}
